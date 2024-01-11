<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> -->
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<!-- 파비콘연결 -->
	<link rel="shortcut icon" href="images/favicon.png" />
	<!-- 아이콘 연결 -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css"/>
	<!-- 제이쿼리 연결 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<!-- 폰트 연결 -->
	<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css" />
	<!-- css연결 -->
	<link rel="stylesheet" href="${path }/resources/css/reset.css"/>
	<link rel="stylesheet" href="${path }/resources/css/my_schedule/my_commute.css"/>
<title>내 근태관리</title>
</head>
<body>
	<header>
		<div class="inner">
			<div id="logo">
				<a href="/"></a>
			</div>
			<nav id="gnb">
				<ul>
					<li>
						<a href="<%=request.getContextPath() %>/commute/myCommute.do"  style="color:#4682B4">내스케쥴관리</a>
							<div class="sub">
								<ul>
									<li><a href="<%=request.getContextPath() %>/commute/myCommute.do" style="color:#4682B4	">근태관리</a></li>
									<li><a href="<%=request.getContextPath() %>/leave/myLeave.do">휴가관리</a></li>
								</ul>
							</div><!-- //.sub -->
					</li><!-- 내스케쥴관리 -->
					<li>
						<a href="#">전자결재</a>
							<div class="sub">
								<ul>
									<li><a href="#">새전자결재</a></li>
									<li><a href="#">전자결재리스트</a></li>
									<li><a href="#">임시저장함</a></li>
								</ul>
							</div><!-- //.sub -->
					</li><!-- 전자결재 -->
					<li>
						<a href="#">쪽지관리</a>
							<div class="sub">
								<ul>
									<li><a href="#">수신쪽지함</a></li>
									<li><a href="#">발신쪽지함</a></li>
									<li><a href="#">새쪽지작성</a></li>
									<li><a href="#">휴지통</a></li>
								</ul>
							</div><!-- //.sub -->
					</li><!-- 쪽지관리 -->
					<li>
						<a href="#">사원관리</a>
							<div class="sub">
								<ul>
									<li><a href="#">일일근태조회</a></li>
									<li><a href="#">상세근태조회</a></li>
									<li><a href="#">전체휴가조회</a></li>
									<li><a href="#">상세휴가조회</a></li>
									<li><a href="#">사원정보관리</a></li>
								</ul>
							</div><!-- //.sub -->
					</li><!-- 사원관리 -->
					<li>
						<a href="#">DEV INFO</a>
					</li><!-- 개발자정보 -->
				</ul>
			</nav>
			<div id="sns">
				<ul>
					<li><a href="#">로그인</a></li>
					<li><a href="#">회원가입</a></li>
					<li><a href="#" class="open_search"><i class="xi-search xi-2x"></i></a></li>
				</ul>
			</div>
		</div><!--inner:end-->
	</header>
	<section id="search">
		<div class="inner">
			<form>
				<input type="text" placeholder="Search..." />
				<p>검색을 할땐 엔터를 누르고, 닫으려면 ESC키를 누르거나X를 눌러주세요.</p>
			</form>
		</div><!-- //.inner -->
		<a class="close_search"><i class="xi-close"></i></a>
	</section><!-- //#search -->
	<!-- 상단종료 -->
	
	<!-- 사이드바 시작 -->
	<button onclick="toggleSidebar()" id="sideBtn"><i class="xi-bars"></i></button>
	
	<div class="sidebar" id="sidebar">
		<ul>
			<li><a class="side_link" href="<%=request.getContextPath() %>/commute/myCommute.do"  style="color:#fff; background-color: #4682B4;">근태관리</a></li>
			<li><a class="side_link" href="<%=request.getContextPath() %>/leave/myLeave.do">휴가관리</a></li>
		</ul>
	</div><!-- //.sidebar -->
   <!-- 사이드바종료 -->
   
   <!-- 메인시작 -->
	<main>
		<section id="my_info">
			<div class="info_title">
				<span>오이사</span>
				<p>이사</p>
			</div> <!-- //.info_title -->

			<div class="info_text">
				<label>사원번호 :</label>
				<span>18030748</span>
			</div><!-- //.info_text -->

			<div class="info_text">
				<label>부서 :</label>
				<span>인사부</span>
			</div><!-- //.info_text -->

			<div class="info_text">
				<label>결재권한 :</label>
				<span>2</span>
			</div><!-- //.info_text -->

			<div class="info_text">
				<label>입사일 :</label>
				<span>2018.03.07</span>
			</div><!-- //.info_text -->
		</section><!--//#my_info-->

		<div id="main_zone">
			<div id="api_zone">
				<p>캘린더api들어갈 자리</p>
			</div><!-- //#api_zone-->
			<div id="commute_modify_form">
				<form name="frm">
					<h2>출퇴근 시간 수정</h2>
					
					<div id="input_zone">
						<div class="able_modify">
							<label>근무시간</label>
							<input type="time" name="inTime" /><span> ~ </span><input type="time" 
							name="outTime" />
						</div><!-- //.able_modify-->
						<div class="able_modify">
							<label>출근/퇴근 구분</label>
							<select name="cInOrOut">
								<option value="출근" selected>출근</option>
								<option value="퇴근">퇴근</option>
							</select>
						</div><!-- //.able_modify-->
						<div class="able_modify">
							<label>시간</label>
							<input type="time" name="modifyTime" />
						</div><!-- //.able_modify-->
					</div><!-- //#input_zone-->
						<div id="modify_reason">
							<label>사유</label>
							<textarea name="cReason" id="cReason" placeholder="사유를 입력하고 제출 버튼을 눌러주세요.								제출 버튼 클릭시 결제 대기 상태로 변경됩니다."></textarea>
						</div><!-- //#modify_reason-->
					<div id="button_zone">
						<button type="submit" id="modiBtn">제출</button>
						<button type="button" id="backBtn" onclick="history.back">취소</button>
					</div><!-- //#button_zone-->
				</form>
			</div><!-- //#commute_modify_form-->

			
		</div><!--//#main_zone-->
	</main>

   <script>
      function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        
        sidebar.classList.toggle('active');
      }
     </script>

</body>
</html>