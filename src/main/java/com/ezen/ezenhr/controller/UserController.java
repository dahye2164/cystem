package com.ezen.ezenhr.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

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
import com.ezen.ezenhr.service.UserUpdateForm;

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
	        @RequestParam("userId") String uId,
	        @RequestParam("userPwd") String uPwd,
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
	        
	     // 세션 스토리지에 출근 여부 저장
	        session.setAttribute("isSignedIn", true);

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
		
		session.removeAttribute("isSignedIn");
		
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
	
	
	@RequestMapping(value = "/userAllSelect.do", method = RequestMethod.GET)
    @ResponseBody
    public List<UserVo>userAllSelect() {
		
        return us.getAllUsers();
    }
	
	
   @RequestMapping(value = "/userDepartmentSelect", method = RequestMethod.GET)
    @ResponseBody
    public List<UserVo> getUserByDepartment(@RequestParam int didx) {
	   if (didx == 0) {
           // didx가 null이면 모든 사용자를 가져옴
           return us.getAllUsers();
       } else {
           // didx에 해당하는 부서의 사용자 목록을 가져옴
           return us.getUidxByDidx(didx);
       }
   }
   
   @RequestMapping(value = "/userInfoManage.do", method = RequestMethod.GET)
   public String userInfoManage(Model model) {
       // 데이터베이스에서 사용자 데이터 검색
       List<UserVo> userList = us.getAllUsers();

       // 사용자 데이터를 뷰에 전달
       model.addAttribute("userList", userList);
       
       return "employee_management/employee_info_management";
   }
   
   @RequestMapping(value = "/updateUsers", method = RequestMethod.POST)
   public String updateUsers(UserUpdateForm form, HttpSession session, Model model) {
       // 사용자 업데이트 로직 수행
       List<UserVo> userList = form.getUserList();

       try {
           us.updateUsers(userList);
           // 업데이트 성공 시, 세션 스토리지에 출근 여부 저장
           session.setAttribute("isSignedIn", true);
       } catch (Exception e) {
           e.printStackTrace();
           // 업데이트 실패 시, 에러 메시지 등을 처리
           model.addAttribute("error", "업데이트에 실패하였습니다.");
       }

       // 사용자 정보를 다시 불러와서 뷰에 전달
       List<UserVo> updatedUserList = us.getAllUsers();
       model.addAttribute("userList", updatedUserList);

       return "employee_management/employee_info_management";
   }
	

	    
	
	
}
