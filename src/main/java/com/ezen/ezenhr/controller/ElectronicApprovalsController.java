package com.ezen.ezenhr.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen.ezenhr.domain.ElectronicApprovalsVo;
import com.ezen.ezenhr.service.ElectronicApprovalsService;

@Controller
@RequestMapping(value="/ea")
public class ElectronicApprovalsController {
	
	@Autowired
	ElectronicApprovalsService eas;
	
	
	@RequestMapping(value="/eaList.do", method = RequestMethod.GET)
	public String eaList() {
		return "/electronic_approvals/electronic_approvals_list";
	}
	
	@RequestMapping(value="/eaWrite.do", method = RequestMethod.GET)
	public String eaWrite() {
		return "/electronic_approvals/electronic_approvals_write";
	}
	
	@RequestMapping(value="/eaAdminList.do", method = RequestMethod.GET)
	public String eaAdminList() {
		return "/electronic_approvals/electronic_approvals_admin_list";
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
	
	/*
	 * @RequestMapping(value = "/eaList.do", method = RequestMethod.GET) public
	 * String getElectronicApprovalsList(Model model, HttpSession session,
	 * 
	 * @RequestParam(required = false, defaultValue = "1") int page,
	 * 
	 * @RequestParam(required = false, defaultValue = "") String searchType,
	 * 
	 * @RequestParam(required = false, defaultValue = "") String keyword) {
	 * 
	 * // 세션에서 로그인한 사용자 정보를 가져옴 UserVo loginUser = (UserVo)
	 * session.getAttribute("loginUser");
	 * 
	 * if (loginUser == null) { // 로그인하지 않은 경우 로그인 페이지로 이동 또는 다른 처리 return
	 * "redirect:/login"; }
	 * 
	 * // 페이징 처리를 위한 Logic 생략 (위와 동일)
	 * 
	 * // 전자 결재 리스트 가져오기 (로그인한 사용자의 idx를 파라미터로 전달) List<ElectronicApprovalsVo>
	 * approvalList =
	 * electronicApprovalsService.getElectronicApprovalsListByUserIdx(loginUser.
	 * getUidx(), page, searchType, keyword);
	 * 
	 * // 모델에 전자 결재 리스트 추가 model.addAttribute("approvalList", approvalList);
	 * 
	 * // 페이징 처리 Logic 생략 (위와 동일)
	 * 
	 * return "ea/eaList"; // 해당 JSP 페이지로 이동 }
	 */
	
	
	
}
