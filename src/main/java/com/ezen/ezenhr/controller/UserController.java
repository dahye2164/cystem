package com.ezen.ezenhr.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.ezenhr.domain.UserVo;
import com.ezen.ezenhr.service.UserService;

@Controller
@RequestMapping(value="/user")
public class UserController {
	
	@Autowired
	UserService us;
	
	
	@Autowired // Spring Security(비밀번호 암호화 주입) 
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@RequestMapping(value="/userJoin.do", method=RequestMethod.GET)
	public String userJoin() {
		return "/user/user_join";
	}
	
	@RequestMapping(value="/userJoinAction.do", method=RequestMethod.POST)
	public String userJoinAction(UserVo uv) {
		
		
		System.out.println(uv.getuId() + " <----- 유저가 입력한 아이디");
		System.out.println(uv.getuPwd() + "<---- 유저가 입력한 비밀번호");
		
		String userPwdEncrypt = bCryptPasswordEncoder.encode(uv.getuPwd());
		System.out.println(userPwdEncrypt + "<---- 비밀번호 암호화값");
		uv.setuPwd(userPwdEncrypt);
		
		int value = us.userInsert(uv);
		
		return "redirect:/";
	}
	
//	@RequestMapping(value="/userLogin.do")
//	public String userLogin(Model model) {
//        // 모달창에 필요한 데이터 설정
//        // 예: model.addAttribute("key", value);
//
//        // 모달창을 보여줄 뷰 반환
//        return "user/login_modal";
//    }
	
	@RequestMapping(value = "/userLoginAction.do")
	public String userLoginAction(
	        @RequestParam("uId") String uId,
	        @RequestParam("uPwd") String uPwd,
	        HttpServletRequest request,
	        HttpServletResponse response,  // HttpServletResponse 파라미터 추가
	        RedirectAttributes rttr
	) throws IOException {

	    UserVo uv = us.userLogin(uId);

	    if (uv != null && bCryptPasswordEncoder.matches(uPwd, uv.getuPwd())) {
	        // 비밀번호가 일치하면 세션에 정보 저장
	        HttpSession session = request.getSession();
	        session.setAttribute("uidx", uv.getUidx());
	        session.setAttribute("uName", uv.getuName());

	        return "redirect:/";
	    } else {
	        PrintWriter out = response.getWriter();
	        out.println("<head><meta charset=\"UTF-8\"></head>");
	        out.println("<script>alert('아이디 또는 비밀번호가 일치하지 않습니다.'); history.back();</script>");
	        return null;  // 현재 메서드에서 더 이상 진행할 필요가 없을 경우 반환값을 null로 설정
	    }
	}
	
	
	
	@RequestMapping(value="/userLogout.do", method=RequestMethod.GET)
	public String userLogout(HttpSession session) {
		
		session.removeAttribute("uidx");
		session.removeAttribute("uName");
		session.invalidate();
		
		return "redirect:/";
	}
	
	
	@ResponseBody
	@RequestMapping(value="/userIdCheck.do", method=RequestMethod.POST)
	public String userIdCheck(String uId) {
		System.out.println("컨트롤러 입성완료");
		
		String str = null;
		int value = us.userIdCheck(uId);
		
		str = "{\"value\" : \""+value+"\"}";	
		System.out.println(str);
		
		return str;
	}
	
}
