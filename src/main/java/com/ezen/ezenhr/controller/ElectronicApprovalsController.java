package com.ezen.ezenhr.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen.ezenhr.domain.ElectronicApprovalsVo;
import com.ezen.ezenhr.domain.LeaveVo;
import com.ezen.ezenhr.service.ElectronicApprovalsService;
import com.ezen.ezenhr.service.LeaveService;

@Controller
@RequestMapping(value="/ea")
public class ElectronicApprovalsController {
	
	@Autowired
	ElectronicApprovalsService eas;
	
	@Autowired
	LeaveService ls;
	
	
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
	
	
}
