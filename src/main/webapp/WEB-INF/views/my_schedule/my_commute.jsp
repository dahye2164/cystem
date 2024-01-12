<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ page import = "com.ezen.ezenhr.domain.UserVo" %>
<%
	UserVo user = (UserVo) request.getAttribute("user");
%>

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

<!-- FullCalendar CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css" />

<!-- FullCalendar JavaScript 및 의존성 라이브러리(moment) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.js"></script>
<!-- FullCalendar 한국어 언어 파일 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/locale/ko.js"></script>

<script>
	$(document).ready(function () {
	    // FullCalendar 초기화
	    $('#api_zone').fullCalendar({
	        header: {
	            left: 'prev,next today',
	            center: 'title',
	            right: 'month,basicWeek,basicDay'
	        },
	        defaultView: 'month', // 기본으로 월 뷰로 설정
	        eventRender: function (event, element) {
	            // 이벤트 렌더링을 위한 설정 (추후 서버에서 받아온 이벤트 데이터로 적절하게 설정)
	        },
	        locale: 'ko' // 한국어로 설정
	        // 추가적인 설정 및 서버에서 데이터를 받아와서 이벤트를 렌더링하는 로직을 작성할 수 있습니다.
	    });
	});
</script>

<script>
    $(document).ready(function () {
        // 서버에서 출퇴근 데이터를 받아올 로직 (예시)
        const commuteData = [
            { title: '출근', start: '2024-01-01T09:00:00' },
            { title: '퇴근', start: '2024-01-01T18:00:00' },
            // 서버에서 받아온 출퇴근 데이터 형식에 맞게 설정
        ];

        // FullCalendar 초기화 및 이벤트 렌더링
        $('#api_zone').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,basicWeek,basicDay'
            },
            defaultView: 'month',
            events: commuteData, // 출퇴근 데이터 설정
            eventRender: function (event, element) {
                // 이벤트 렌더링을 위한 설정 (추후 서버에서 받아온 이벤트 데이터로 적절하게 설정)
            }
            // 추가적인 설정과 서버에서 데이터를 받아오는 로직을 작성할 수 있습니다.
        });
    });
</script>
</head>
<body>
	<%@include file="../include/header.jsp"%>
	
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
				<span><%= user.getuName() %></span>
				<p><%= user.getuGrade() %></p>
			</div> <!-- //.info_title -->

			<div class="info_text">
				<label>사원번호 :</label>
				<span><%= user.getUidx() %></span>
			</div><!-- //.info_text -->

			<div class="info_text">
				<label>부서 :</label>
				<span><%= user.getDidx() %></span>
			</div><!-- //.info_text -->

			<div class="info_text">
				<label>결재권한 :</label>
				<span><%= user.getuApprovalLevel() %></span>
			</div><!-- //.info_text -->

			<div class="info_text">
				<label>입사일 :</label>
				<span><%= user.getuHireDate() %></span>
			</div><!-- //.info_text -->
		</section><!--//#my_info-->
		<div id="main_zone">
			<div id="api_zone">
				
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
					<button type="button" id="signInBtn" onclick="signIn()">출근하기</button>

         			<!-- 퇴근하기 버튼 (최초에는 숨겨둠) -->
         			<button type="button" id="signOutBtn" style="display:none;" onclick="signOut()">퇴근하기</button>
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
     <script>
   // 출근하기 버튼 클릭 시
   function signIn() {
      // 여기에 출근 처리 로직을 추가 (서버와의 통신 등)

      // 출근하기 버튼 숨기고 퇴근하기 버튼 표시
      document.getElementById('signInBtn').style.display = 'none';
      document.getElementById('signOutBtn').style.display = 'block';
   }

   // 퇴근하기 버튼 클릭 시
   function signOut() {
      // 여기에 퇴근 처리 로직을 추가 (서버와의 통신 등)

      // 퇴근하기 버튼 숨기고 출근하기 버튼 표시
      document.getElementById('signOutBtn').style.display = 'none';
      document.getElementById('signInBtn').style.display = 'block';
   }

   // ... (이전 코드 생략) ...
</script>

</body>
</html>