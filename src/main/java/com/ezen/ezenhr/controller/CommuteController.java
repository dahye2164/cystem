package com.ezen.ezenhr.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen.ezenhr.domain.CommuteVo;
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
            
            CommuteVo cv = cs.getCommuteInfo(uidx);
            
            if (cv != null) {
                model.addAttribute("cv", cv);
            }
        }

        return "/my_schedule/my_commute";
    }
    
    @Transactional
    @RequestMapping(value = "/signIn.do", method = { RequestMethod.GET, RequestMethod.POST })
    @ResponseBody
    public Map<String, Object> signIn(HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        try {
            int uidx = (Integer) session.getAttribute("uidx");
            int didx = us.getUserDepartmentId(uidx);
            System.out.println(didx + "<--- saveSignInTime의 didx");
            String departmentName = us.getDepartmentName(didx);
            System.out.println(departmentName + "<-- saveSignInTime의 departmentName");
            System.out.println(uidx + "<---- signIn.do uidx값");
            LocalDateTime signInTime = LocalDateTime.now();

            // 세션에 출근 정보 저장
            session.setAttribute("isSignedIn", true);

            // CommuteVo 객체 생성 및 값 설정
            CommuteVo cv = new CommuteVo();
            cv.setUidx(uidx);
            cv.setDidx(didx);
            cv.setDepartmentName(departmentName);
            cv.setcInTime(signInTime);
            cv.setCtype("출근");

            // CommuteVo 객체를 매퍼에 전달
            int value = cs.saveSignInTime(cv);

            if (value > 0) {
                result.put("success", true);
            } else {
                result.put("success", false);
                result.put("message", "출근 정보 저장 실패");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }

        return result;
    }
    
    @RequestMapping(value = "/signOut.do", method = { RequestMethod.GET, RequestMethod.POST })
    @ResponseBody
    public Map<String, Object> signOut(HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 세션에서 출근 여부 확인
            boolean isSignedIn = session.getAttribute("isSignedIn") != null && (boolean) session.getAttribute("isSignedIn");

            if (isSignedIn) {
                int uidx = (Integer) session.getAttribute("uidx");
                
              
                int didx = us.getUserDepartmentId(uidx);
                System.out.println(didx + "<--- saveSignInTime의 didx");
                String departmentName = us.getDepartmentName(didx);
                System.out.println(departmentName + "<-- saveSignInTime의 departmentName");
                System.out.println(uidx + "<---- signIn.do uidx값");
                LocalDateTime signOutTime = LocalDateTime.now();

                // 세션에서 출근 정보 업데이트
                session.setAttribute("isSignedIn", false);
                
                CommuteVo cv = new CommuteVo();
                cv.setUidx(uidx);
                cv.setDidx(didx);
                cv.setDepartmentName(departmentName);
                cv.setcOutTime(signOutTime);
                cv.setCtype("퇴근");

                // CommuteVo 객체 생성 및 값 설정
                int value = cs.saveSignOutTime(cv);

                if (value > 0) {
                    result.put("success", true);
                } else {
                    result.put("success", false);
                    result.put("message", "퇴근 정보 저장 실패");
                }
            } else {
                result.put("success", false);
                result.put("message", "사용자가 출근 중이 아닙니다.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }

        return result;
    }
    
    @RequestMapping(value = "/myCommuteEvents.do", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getMyCommuteEvents(HttpSession session) {
        List<Map<String, Object>> events = new ArrayList<>();

        Integer uidx = (Integer) session.getAttribute("uidx");
        if (uidx != null) {
            List<CommuteVo> commuteList = cs.getCommuteList(uidx);

            for (CommuteVo cv : commuteList) {
                Map<String, Object> event = new HashMap<>();

                // 출근 정보
                if (cv.getcInTime() != null) {
                    event.put("title", "출근");
                    event.put("start", cv.getcInTime());  // 출근 시간
                    event.put("end", cv.getcInTime());    // 출근 시간을 end에도 설정
                    events.add(event);
                }

                // 퇴근 정보
                if (cv.getcOutTime() != null) {
                    event = new HashMap<>();  // 새로운 Map 객체 생성
                    event.put("title", "퇴근");
                    event.put("start", cv.getcOutTime());  // 퇴근 시간
                    event.put("end", cv.getcOutTime());    // 퇴근 시간을 end에도 설정
                    events.add(event);
                }
            }
        }

        return events;
    }
    
    @RequestMapping(value = "/commuteUpdateAction.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> commuteUpdateAction(@RequestParam("cInOrOut") String cInOrOut,
                                                  @RequestParam("modifyTime") String modifyTime,
                                                  @RequestParam("cReason") String cReason,
                                                  HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        try {
            int uidx = (Integer) session.getAttribute("uidx");
            int didx = us.getUserDepartmentId(uidx);
            String departmentName = us.getDepartmentName(didx);

            LocalDate currentDate = LocalDate.now();
            LocalDateTime modifiedTime = LocalDateTime.of(currentDate, LocalTime.parse(modifyTime));

            CommuteVo cv = new CommuteVo();
            cv.setUidx(uidx);
            cv.setDidx(didx);
            cv.setDepartmentName(departmentName);

            if ("출근".equals(cInOrOut)) {
                cv.setcInTime(modifiedTime);
                cv.setCtype("출근");
            } else if ("퇴근".equals(cInOrOut)) {
                cv.setcOutTime(modifiedTime);
                cv.setCtype("퇴근");
            } else {
                result.put("success", false);
                result.put("message", "올바르지 않은 출퇴근 구분 값입니다.");
                return result;
            }

            if (cReason != null && !cReason.trim().isEmpty()) {
                cv.setcReason(cReason);
            }

            int value = cs.updateCommuteTime(cv);

            if (value > 0) {
                result.put("success", true);
                // 여기서 페이지 이동 키를 "redirectURL"로 설정
                result.put("redirectURL", "/ezenhr/commute/myCommute.do");
                result.put("message", "결재 대기 상태로 변경되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "출퇴근 정보 수정 실패");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }

        return result;
    }
    
    @RequestMapping(value = "dayCommuteManagement.do")
    public String dayCommuteManagementList(Model model) {
    	
    	List<CommuteVo> clist = cs.getDayCommuteList();
    	List<String> uNames = new ArrayList<>();
    	
    	for (CommuteVo cv : clist) {
            UserVo uv = us.getUserInfo(cv.getUidx());
            System.out.println(uv+"--------uv");
            uNames.add(uv.getuName());
            System.out.println(uNames+"uNames++++++++++++");
        }
    	
    	model.addAttribute("clist", clist);
    	model.addAttribute("uNames", uNames);
    	
    	return "/employee_management/day_commute_management";
    }
    
}