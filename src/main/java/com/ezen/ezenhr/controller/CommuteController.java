package com.ezen.ezenhr.controller;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen.ezenhr.domain.UserVo;
import com.ezen.ezenhr.service.CommuteService;
import com.ezen.ezenhr.service.UserService;




@Controller
@RequestMapping(value="/commute")
public class CommuteController {
	
	@Autowired
	UserService us;
	
	@Autowired
	CommuteService cs;
	
	@RequestMapping(value = "/myCommute.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String userSelectOne(Model model, HttpSession session) {
	    Integer uidx = (Integer) session.getAttribute("uidx");
	    System.out.println(uidx + "<---- myCommute.do uidx 값");

	    if (uidx != null) {
	        UserVo user = us.getUserInfo(uidx);
	        System.out.println(user + "<---- 쿼리 실행 결과");

	        // 여기서 user 객체에 어떤 값이 들어있는지 확인해보세요.
	        System.out.println(user.getDidx() + "<---- 사용자 부서 번호");
	        
	        model.addAttribute("user", user);

	        String departmentName = us.getDepartmentName(user.getDidx());
	        System.out.println(departmentName + "<--- 부서 이름 ");
	        model.addAttribute("departmentName", departmentName);
	    }

	    return "/my_schedule/my_commute";
	}
	
	@RequestMapping(value = "/signIn.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> signIn(HttpSession session) {
		Map<String, Object> result = new HashMap<>();
		
		try {
			Integer uidx = (Integer) session.getAttribute("uidx");
			if (uidx != null) {
				LocalDateTime signInTime = LocalDateTime.now();
				cs.saveSignInTime(uidx, signInTime);
				
				result.put("success", true);
			} else {
				result.put("success", false);
				result.put("message", "사용자 정보가 없습니다.");
			}
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message",e.getMessage());
		}
		
		return result;
	}

}
