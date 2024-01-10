package com.ezen.ezenhr.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen.ezenhr.domain.UserVo;
import com.ezen.ezenhr.service.UserService;

@Controller
@RequestMapping(value="/user")
public class UserController {
	
	@Autowired
	UserService us;
	
	
	@Autowired // Spring Security(비밀번호 암호화 주입) 
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@RequestMapping(value="/userJoin.do")
	public String userJoin() {
		return "/user/user_join";
	}
	
	@RequestMapping(value="/userJoinAction.do")
	public String userJoinAction(UserVo uv) {
		
		
		System.out.println(uv.getuId() + " <----- 유저가 입력한 아이디");
		System.out.println(uv.getuPwd() + "<---- 유저가 입력한 비밀번호");
		
		String userPwdEncrypt = bCryptPasswordEncoder.encode(uv.getuPwd());
		System.out.println(userPwdEncrypt + "<---- 비밀번호 암호화값");
		uv.setuPwd(userPwdEncrypt);
		
		int value = us.userInsert(uv);
		
		return "redirect:/";
	}
	
	
	@ResponseBody
	@RequestMapping(value="/userIdCheck.do")
	public String userIdCheck(String uId) {
		System.out.println("컨트롤러 입성완료");
		
		String str = null;
		int value = us.userIdCheck(uId);
		
		str = "{\"value\" : \""+value+"\"}";	
		System.out.println(str);
		
		return str;
	}
	
}
