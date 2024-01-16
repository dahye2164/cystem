package com.ezen.ezenhr.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ezen.ezenhr.domain.LeaveVo;
import com.ezen.ezenhr.service.LeaveService;

@Controller
@RequestMapping(value="/leave")
public class LeaveController {
	
	@Autowired
	LeaveService ls;
	

	@RequestMapping(value="/myLeave.do", method = RequestMethod.GET)
	public String myLeave() {
		return "/my_schedule/my_leave";
	}
	
	
	@RequestMapping(value="/submitLeave.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String submitLeave(LeaveVo lv, HttpSession session, Model model) {
		int uidx = (Integer)session.getAttribute("uidx");

		lv.setUidx(uidx);
		System.out.println(lv);
		System.out.println(lv.getAidx());
		int value = ls.leaveInsert(lv);
		
		
		if (value > 0) {
            model.addAttribute("result", "success");
        } else {
            model.addAttribute("result", "error");
        }

        return "/electronic_approvals/electronic_approvals_write"; // resultPage는 성공 또는 실패 여부를 표시하는 페이지의 경로
    }
}

