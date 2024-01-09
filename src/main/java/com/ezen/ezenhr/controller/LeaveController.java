package com.ezen.ezenhr.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ezen.ezenhr.service.LeaveService;

@Controller
@RequestMapping(value="/leave")
public class LeaveController {
	

	@RequestMapping(value="/myLeave.do")
	public String myLeave() {
		return "/my_schedule/my_leave";
	}

}
