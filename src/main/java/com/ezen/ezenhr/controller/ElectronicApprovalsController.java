package com.ezen.ezenhr.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen.ezenhr.domain.ElectronicApprovalsVo;
import com.ezen.ezenhr.domain.LeaveVo;
import com.ezen.ezenhr.domain.UserVo;
import com.ezen.ezenhr.service.ElectronicApprovalsService;
import com.ezen.ezenhr.service.LeaveService;
import com.ezen.ezenhr.service.UserService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value="/ea")
public class ElectronicApprovalsController {
	
	@Autowired
	ElectronicApprovalsService eas;
	
	@Autowired
	LeaveService ls;
	
	@Autowired
	UserService us;
	
	
	@RequestMapping(value="/eaList.do", method = RequestMethod.GET)
	public String eaList() {
		return "/electronic_approvals/electronic_approvals_list";
	}
	

	
	@RequestMapping(value="/eaWrite.do", method = RequestMethod.GET)
	public String eaWrite() {
		return "/electronic_approvals/electronic_approvals_write";
	}
	

	@RequestMapping(value = "/submitElectronicApproval.do", method = RequestMethod.POST, consumes = "application/json")
    @ResponseBody
    public ElectronicApprovalsVo submitElectronicApproval(@RequestBody ElectronicApprovalsVo eav, HttpSession session) {
        try {
        	int uidx = (Integer)session.getAttribute("uidx");
            // 전자결재를 처리하는 비즈니스 로직 호출
        	eav.setUidx(uidx);
            int value = eas.insertElectronicApproval(eav);
            
            if (value <= 0) {
                eav.setAidx(0); // 실패한 경우에는 특정 값(예: 0)을 설정
            }
            return eav;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
	
	@RequestMapping(value="/eaAdminList.do", method = RequestMethod.GET)
	public String eaAdminList(Model model, HttpSession session) {
	    // 세션에서 로그인한 사용자 정보를 가져옴
	    int uidx = (Integer)session.getAttribute("uidx");

	    // 페이징 처리를 위한 Logic 생략 (위와 동일)

	 // 전자 결재 리스트 가져오기 (로그인한 사용자의 idx를 파라미터로 전달)
	    List<Map<String, Object>> eaaList = eas.getEAListByApproverUidxWithAdate(uidx);
	    System.out.println(eaaList + "eaaList");

	    // 해당 결재 리스트의 aidx 추출
	    List<Integer> aidxList = new ArrayList<>();
	    for (Map<String, Object> eav : eaaList) {
	        aidxList.add((Integer) eav.get("aidx"));
	        System.out.println(aidxList + "aidxList");
	    }

	 // 휴가 테이블에서 해당 aidx에 해당하는 데이터 검색
	    List<HashMap<String, Object>> alList = new ArrayList<>();
	    for (Integer aidx : aidxList) {
	        HashMap<String, Object> leaveData = ls.getLeaveDataWithUsernameByAidx(aidx);
	        System.out.println("Leave data for aidx " + aidx + ": " + leaveData);
	        if (leaveData != null) {
	            alList.add(leaveData);
	            System.out.println(alList + "alList");

	            // 로그 추가
	            System.out.println("adate from leaveData: " + leaveData.get("adate"));
	        } else {
	            // 추가한 로그
	            System.out.println("Leave data is null for aidx: " + aidx);
	        }
	    }

	    // adate 필드를 추가





	    // 모델에 전자 결재 리스트 추가
	    model.addAttribute("alList", alList);

	    return "/electronic_approvals/electronic_approvals_admin_list";
	}
	
	
	@RequestMapping(value="/eaAgree.do", method = RequestMethod.GET)
	public String eaAgree(Model model, HttpSession session, int aidx) throws Exception {
		LeaveVo lv = ls.selectLeaveByAidx(aidx);
		
		ElectronicApprovalsVo eav = eas.selectEAByAidx(aidx);
		
		
		UserVo uv1 = us.getUserInfo(eav.getApprovalUidx1());

		
		UserVo uv2 = us.getUserInfo(eav.getApprovalUidx2());
		
		UserVo uv3 = us.getUserInfo(eav.getUidx());
		
		model.addAttribute("lv", lv);
		model.addAttribute("uv1",uv1);
		model.addAttribute("uv2",uv2);
		model.addAttribute("uv3",uv3);
		
		
	
		
		return "/electronic_approvals/electronic_approvals_admin_agree";
	}
	@RequestMapping(value = "/agreeApproval.do", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	@ResponseBody
	@Transactional
	public String agreeApproval(@RequestBody Map<String, Integer> data, HttpSession session) {
	    try {
	        int uidx = (Integer) session.getAttribute("uidx");
	        int aidx = data.get("aidx");
	        System.out.println(aidx);

	        // 결재자 역할 확인
	        ElectronicApprovalsVo eav = eas.selectEAByAidx(aidx);
	        if (eav != null) {
	            if (eav.getApprovalUidx1() == uidx) {
	                // 1차 결재자인 경우
	                LeaveVo lv = new LeaveVo();
	                lv.setlAcpYn("1차결재완료");  // 변경된 휴가 승인 상태를 'Y'로 설정
	                lv.setlState("1차결재완료");

	                // 전자결재 테이블 업데이트
	                eav.setApprovalStatus("1차결재완료");  // 1차 결재자의 결재 상태를 업데이트
	                int updateEAStatus = eas.updateElectronicApprovalStatus(eav);
	                if (updateEAStatus <= 0) {
	                    System.err.println("EA Update Error: " + eav);
	                    return "afailure"; // 전자결재 테이블 업데이트 실패
	                }

	                // 휴가 테이블 업데이트
	                int updateVacationResult = ls.updateLeaveStatus(lv);
	                System.out.println(updateVacationResult);
	                if (updateVacationResult > 0) {
	                    return "success";
	                } else {
	                    System.err.println("Leave Update Error: " + lv);
	                    return "bfailure"; // 휴가 테이블 업데이트 실패
	                }
	            } else if (eav.getApprovalUidx2() == uidx) {
	                // 2차 결재자인 경우
	                LeaveVo lv = new LeaveVo();
	                lv.setlAcpYn("2차결재완료");  // 변경된 휴가 승인 상태를 'Y'로 설정
	                lv.setlState("2차결재완료");

	                // 전자결재 테이블 업데이트
	                eav.setApprovalStatus("2차결재완료");  // 2차 결재자의 결재 상태를 업데이트
	                int updateEAStatus = eas.updateElectronicApprovalStatus(eav);
	                if (updateEAStatus <= 0) {
	                    System.err.println("EA Update Error: " + eav);
	                    return "cfailure"; // 전자결재 테이블 업데이트 실패
	                }

	                // 휴가 테이블 업데이트
	                int updateVacationResult = ls.updateLeaveStatus(lv);
	                if (updateVacationResult > 0) {
	                    return "success";
	                } else {
	                    System.err.println("Leave Update Error: " + lv);
	                    return "dfailure"; // 휴가 테이블 업데이트 실패
	                }
	            } else {
	                return "efailure"; // 본인이 결재자가 아닌 경우
	            }
	        } else {
	            return "ffailure"; // 결재 정보를 찾을 수 없는 경우
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.err.println("Exception in agreeApproval: " + e.getMessage()); // 추가된 로깅
	        return "error"; // 에러 발생
	    }
	}
}