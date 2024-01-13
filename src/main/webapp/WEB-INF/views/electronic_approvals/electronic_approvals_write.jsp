<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css" />
<!-- 제이쿼리 연결 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<!-- 폰트 연결 -->
<link rel="stylesheet" as="style" crossorigin
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css" />
<!-- css연결 -->
<link rel="stylesheet" href="${path }/resources/css/reset.css" />
<link rel="stylesheet"
	href="${path }/resources/css/electronic_approvals/electronic_approvals_write.css" />
<title>새전자결재</title>
</head>
<body>
	<%@include file="../include/header.jsp"%>

	<!-- 사이드바 시작 -->
	<button onclick="toggleSidebar()" id="sideBtn">
		<i class="xi-bars"></i>
	</button>

	<div class="sidebar" id="sidebar">
		<ul>
			<li><a class="side_link" href="<%=request.getContextPath() %>/ea/eaWrite.do" style="color:#fff; background-color: #4682B4;">새전자결재</a></li>
			<li><a class="side_link" href="<%=request.getContextPath()%>/ea/eaList.do">전자결재목록</a></li>
            <li><a class="side_link" href="<%=request.getContextPath()%>/ea/eaAdminList.do" >전자결재승인</a></li>
			<li><a class="side_link" href="#">임시저장함</a></li>
		</ul>
	</div>
	<!-- //.sidebar -->
	<!-- 사이드바종료 -->

	<main>
		<h2>새 전자결재 작성</h2>
		<div id="main_zone">
			<form name="frm" id="frm">
				<div id="input_zone">
					<div class="able_modify">
						<div id="date_zone">
							<label>기간</label>
							<input type="date" id="startDate" name="startDate" />
							<span> ~ </span>
							<input type="date" id="endDate" name="endDate" />
						</div><!-- //#date_zone -->
						<div id="type_zone">
							<label>종류</label> <select name="leaveType" id="leaveType">
								<option value="전체" selected>전체</option>
								<option value="연차">연차</option>
								<option value="반차">반차</option>
								<option value="경조사">경조사</option>
								<option value="병가">병가</option>
								<option value="기타">기타</option>
							</select>
						</div><!-- //type_zone -->
					</div><!-- //.able_modify-->
				</div><!-- //#input_zone-->
				<div id="reason_file">
					<label>사유</label>
					
					<div id="file_zone">
						<label>증빙서류</label>
						<button type="button" id="fileBtn">파일첨부</button>
						<p>파일명.hwp</p>
					</div><!-- //#file_zone-->
					
				</div><!-- //#reason_file-->
				<textarea name="cReason" id="cReason" placeholder="사유를 입력하고 제출 버튼을 눌러주세요. 제출 버튼 클릭시 결제 대기 상태로 변경됩니다."></textarea>
			
				<div id="person_zone">
					<div class="able_modify">
						<label>결재자</label>
						<div class="ea_person">
							<select name="department" id="department">
								<option value="전체" selected>전체</option>
								<option value="1">기획부</option>
								<option value="2">개발부</option>
								<option value="3">영업부</option>
								<option value="4">인사부</option>
								<option value="5">총무부</option>
							</select>
							<select name="uName" id="uName">
								<option value="전체" selected>전체</option>
								<option value="오이사">오이사</option>
								<option value="몰라">몰라</option>
								<option value="몰라">몰라</option>
								<option value="몰라">몰라</option>
								<option value="몰라">몰라</option>
							</select>
							<button type="button" id="addEaBtn"><i class="xi-user-plus"></i></button>
							<div id="addResult"></div>
						</div><!-- //.ea_person-->
					</div><!-- //.able_modify-->
					<div class="able_modify">
						<label>참조자</label>
						<div class="ea_person">
							<select name="department2" id="department2">
								<option value="전체" selected>전체</option>
								<option value="1">기획부</option>
								<option value="2">개발부</option>
								<option value="3">영업부</option>
								<option value="4">인사부</option>
								<option value="5">총무부</option>
							</select>
							<select name="uName2" id="uName2">
								<option value="전체" selected>전체</option>
								<option value="오이사">오이사</option>
								<option value="몰라">몰라</option>
								<option value="몰라">몰라</option>
								<option value="몰라">몰라</option>
								<option value="몰라">몰라</option>
							</select>
							<button type="button" id="addEaBtn2"><i class="xi-user-plus"></i></button>
							<div id="addResult2"></div>
						</div><!-- //.ea_person-->
					</div><!-- //.able_modify-->
				</div><!-- //#person_zone-->
				
				<div id="button_zone">
					<button type="submit" id="saveBtn">임시저장</button>
					<button type="submit" id="modiBtn">제출</button>
					<button type="button" id="backBtn" onclick="history.back">취소</button>
				</div><!-- //#button_zone-->
			</form>
		</div><!-- //#main_zone -->

		<script>
			function toggleSidebar() {
				const sidebar = document.getElementById('sidebar');
				
				sidebar.classList.toggle('active');
			}
		</script>
		
		
		<script>
		  function updateUsers() {
		    var departmentSelect = document.getElementById("department");
		    var userSelect = document.getElementById("uName");
		    var selectedDepartment = departmentSelect.value;
		
		    // 기존의 옵션 제거
		    while (userSelect.options.length > 1) {
		      userSelect.remove(1);
		    }
		
		    // 선택된 부서의 사용자 목록을 서버에서 가져오기
		  	fetch(`/getUsersForDepartment?department=${selectedDepartment}`)
		      .then(response => response.json())
		      .then(users => {
		        // 새로운 사용자 목록으로 옵션 추가
		        for (var i = 0; i < users.length; i++) {
		          var option = document.createElement("option");
		          option.value = users[i].value;
		          option.text = users[i].text;
		          userSelect.add(option);
		        }
		      })
		      .catch(error => {
		        console.error("Error fetching user data:", error);
		      });
		  }
		</script>
	</main>
</body>
</html>
