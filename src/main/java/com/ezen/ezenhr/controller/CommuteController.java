package com.ezen.ezenhr.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/commute")
public class CommuteController {
	
	
	@RequestMapping(value="/myCommute.do")
	public String myCommute() {
		return "/my_schedule/my_commute";
	}

}
