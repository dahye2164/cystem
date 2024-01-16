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
	
}
