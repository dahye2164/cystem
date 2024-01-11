<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="shortcut icon" href="images/favicon.png" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css" />
<link rel="stylesheet" href="${path }/resources/css/reset.css" />
<link rel="stylesheet" href="${path }/resources/css/index.css" />
<script src="${path }/resources/js/script.js"></script>
<!--swiper plugin connect-->
<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
<title>Ezen HR</title>
</head>
<body>
	<div id="modalBackground"></div>
	<div id="loginModal">
		<span class="close-button" onclick="closeModal()">&times;</span>
		<div class="modal-title">Ezen HR 로그인하기</div>
		<form id="loginForm">
			<label for="username">아이디</label> <input type="text" id="uId"
				name="uId" /> <label for="password">비밀번호</label> <input
				type="password" id="uPwd" name="uPwd" />

			<button type="button" onclick="login()">로그인</button>
			<%
            if (request.getAttribute("loginFail") != null) {
        %>
			<script type="text/javascript">
            handleLoginFailure();
        </script>
			<%
            }
            request.removeAttribute("loginFail"); // 실패 플래시 어트리뷰트 제거
        %>
		</form>
		<div class="additional-options">
			<a href="#">아이디/비밀번호를 잊으셨나요?</a> 
			<a class="signup-button" href="#">회원가입하러가기</a>
		</div>
	</div>
	
	<script type="text/javascript">
	
	function login() {
		
		
		openModal();
        alert("로그인 버튼 클릭");
        let uId = document.getElementById('uId').value;
        alert("입력된 아이디는?" + uId);

        let fm = document.getElementById('loginForm');

        if (fm.uId.value == "") {
            alert("아이디를 입력해주세요.");
            fm.uId.focus();
            return;
        } else if (fm.uPwd.value == "") {
            alert("비밀번호를 입력해주세요");
            fm.uPwd.focus();
            return;
        }

        fm.action = "<%=request.getContextPath()%>/user/userLoginAction.do";
        fm.method = "post";
        fm.submit();

        return;
    }
	
	function openModal() {
        document.getElementById('modalBackground').style.display = 'block';
        document.getElementById('loginModal').style.display = 'block';
    }

    // 모달창 닫기
    function closeModal() {
        document.getElementById('modalBackground').style.display = 'none';
        document.getElementById('loginModal').style.display = 'none';
    }
    </script>
	
</body>
</html>