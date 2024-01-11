package com.ezen.ezenhr.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/elecAppro")
public class ElectronicApprovalsController {
	
	
	@RequestMapping(value="/elecApproList.do")
	public String elecApproList() {
		return "/electronic_approvals/electronic_approvals_list";
	}

}
