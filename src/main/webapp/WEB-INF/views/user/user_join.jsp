<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link rel="shortcut icon" href="images/favicon.png"/>
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css"/>
        <link rel="stylesheet" href="${path }/resources/css/reset.css"/>
        <link rel="stylesheet" href="${path }/resources/css/join_form.css"/>
        <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
        <!--swiper plugin connect-->
        <script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
        <title>Ezen HR</title>
        
        <script>
        $(document).ready(function(){
        	
        $("#btn").on("click",function() {
        	alert("버튼 클릭완료");
        	let userId = $("#userId").val();
        	console.log(userId);
        	
        	$.ajax({
        		type: "post",
        		url : "<%=request.getContextPath() %>/user/userIdCheck.do",
        		data : {"userId" : userId},
        		dataType : "json",
        		success : function(data) {
        			if(data.value == 0) {
        				alert("사용할 수 있는 아이디입니다.");
        			} else {
        				alert("사용할 수 없는 아이디입니다.");
        			}
        		},
        		error : function() {
        			alert("실패");
        		}
        	});
        	
        });
      });
        
        </script>
    </head>
    <body>
    
    <script>
    function check() {
    	
    var fm = document.signupForm;
    
    	if(fm.userId.value =="") {
    	alert("아이디를 입력하세요");
    	fm.userId.focus();
    	return;
    } else if(fm.userPwd.value =="") {
    	alert("비밀번호를 입력해주세요");
    	fm.userPwd.focus();
    	return;
    } else if(fm.userPwdConfirm.value == "") {
    	alert("비밀번호 확인을 입력해주세요");
    	fm.userPwdConfirm.focus();
    	return;
    } else if(fm.userPwd.value != fm.userPwdConfirm.value) {
    	alert("비밀번호가 일치하지 않습니다.");
    	fm.userPwd.value = "";
    	fm.userPwdConfirm.value= "";
    	fm.userPwd.focus();
    	return;
    } else if(fm.userName.value == "") {
    	alert("사용자 이름을 입력해주세요");
    	fm.userName.focus();
    	return;
    }  else if (fm.position.selectedIndex === 0) {
        alert("직급을 선택하세요");
        fm.position.focus();
        return;
      } else if (fm.department.selectedIndex === 0) {
        alert("부서를 선택하세요");
        fm.department.focus();
        return;
      }
    
    fm.action ="<%=request.getContextPath()%>/user/userJoinAction.do";
    fm.method = "post";
    fm.submit();
    return;
    }
    </script>
    
        <header>
            <div class="inner">
                <div id="logo">
                    <h1>
                        <a href="${path }/"></a>
                    </h1>
                </div>

                <nav id="gnb">
                    <ul>
                        <li>
                            <a href="#">내스케쥴관리</a>
                            <div class="sub">
                                <ul>
                                    <li>
                                        <a href="#">근태관리</a>
                                    </li>
                                    <li>
                                        <a href="#">휴가관리</a>
                                    </li>

                                </ul>
                            </div>
                        </li>
                        <li>
                            <a href="#">전자결재</a>
                            <div class="sub">
                                <ul>
                                    <li>
                                        <a href="#">새전자결재</a>
                                    </li>
                                    <li>
                                        <a href="#">전자결재리스트</a>
                                    </li>
                                    <li>
                                        <a href="#">임시저장함</a>
                                    </li>
                                </ul>
                            </div>
                        </li>
                        <li>
                            <a href="#">쪽지관리</a>
                            <div class="sub">
                                <ul>
                                    <li>
                                        <a href="#">수신쪽지함</a>
                                    </li>
                                    <li>
                                        <a href="#">발신쪽지함</a>
                                    </li>
                                    <li>
                                        <a href="#">새쪽지작성</a>
                                    </li>
                                    <li>
                                        <a href="#">휴지통</a>
                                    </li>
                                </ul>
                            </div>
                        </li>

                        <li>
                            <a href="#">사원관리</a>
                            <div class="sub">
                                <ul>
                                    <li>
                                        <a href="#">일일근태조회</a>
                                    </li>
                                    <li>
                                        <a href="#">상세근태조회</a>
                                    </li>
                                    <li>
                                        <a href="#">전체휴가조회</a>
                                    </li>
                                    <li>
                                        <a href="#">상세휴가조회</a>
                                    </li>
                                    <li>
                                        <a href="#">사원정보관리</a>
                                    </li>
                                </ul>
                            </div>
                        </li>
                        <li>
                            <a href="#">DEV INFO</a>
                        </li>
                    </ul>
                </nav>
                <div id="sns">
                    <ul>
                        <li>
                            <a href="#">로그인</a>
                        </li>
                        <li>
                            <a href="#">회원가입</a>
                        </li>
                        <li>
                            <a href="#" class="open_search">
                                <i class="xi-search xi-2x"></i >
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <!--inner:end-->
        </header>
        <section id="search">
            <div class="inner">
                <form>
                    <input type="text" placeholder="Search..."/>
                    <p>
                        검색을 할땐 엔터를 누르고, 닫으려면 ESC키를 누르거나X를 눌러주세요.
                    </p>
                </form>
            </div>
            <a class="close_search">
                <i class="xi-close"></i>
            </a>
        </section>
        <div class="container">
            <h2>ezenHR 회원가입</h2>
            <form action="#" method="post" name="signupForm">
              <div class="form-group">
                <label for="username">아이디</label>
                <div class="input-with-button">
                    <input type="text" id="userId" name="userId" required>
                </div>
                <input type="button" name="btn" id="btn" value="아이디 중복체크">
            </div>

                <!-- 비밀번호 입력 폼 -->
                <div class="form-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="userPwd" name="userPwd" required="required">
                </div>

                <!-- 비밀번호 확인 입력 폼 -->
                <div class="form-group">
                    <label for="confirmPassword">비밀번호 확인</label>
                    <input
                        type="password"
                        id="userPwdConfirm"
                        name="userPwdConfirm"
                        required="required">
                </div>

                <div class="form-group">
                    <label for="name">이름</label>
                    <input type="text" id="userName" name="userName" required="required">
                </div>

                <div class="form-group">
                    <label for="position">직급</label>
                    <select id="position" name="position" required="required">
                        <option value="" disabled="disabled" selected="selected">선택하세요</option>
                        <option value="신입사원">신입사원</option>
                        <option value="대리">대리</option>
                        <option value="과장">과장</option>
                        <option value="차장">차장</option>
                        <option value="부장">부장</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="department">부서</label>
                    <select id="department" name="department" required="required">
                        <option value="" disabled="disabled" selected="selected">선택하세요</option>
                        <option value="기획부">기획부</option>
                        <option value="개발부">개발부</option>
                        <option value="영업부">영업부</option>
                        <option value="인사부">인사부</option>
                        <option value="총무부">총무부</option>
                    </select>
                </div>

                <div class="form-buttons">
                    <input type="button" name="btn" class="submitBtn" value="가입하기" onclick="check();">
                    <button type="reset">취소</button>
                </div>
            </form>
        </div>

    </body>
</html>