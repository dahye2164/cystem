<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.ezen.ezenhr.domain.UserVo" %>
<%@ page import="java.util.List" %>




<%
    List<UserVo> uList = (List<UserVo>)request.getAttribute("uList");
%>

<%
    // uList를 Map으로 변환
    Map<Integer, String> userMap = new HashMap<>();
    for (UserVo user : uList) {
        userMap.put(user.getUidx(), user.getuName());
    }
%>

<%-- Debugging: Print uList to console --%>
<%
    System.out.println("uList: " + uList);
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
	<link rel="stylesheet" href="${path }/resources/css/employee_management/employee_day_manage.css"/>
	<title>일일근태조회</title>
</head>
<body>
	<%@include file="../include/header.jsp"%>
	
	<!-- 사이드바 시작 -->
	<button onclick="toggleSidebar()" id="sideBtn"><i class="xi-bars"></i></button>
	
	<div class="sidebar" id="sidebar">
		<ul>
			<li><a class="side_link" href="<%=request.getContextPath() %>/commute/dayCommuteManagement.do" style="color:#fff; background-color: #4682B4;">일일근태조회</a></li>
			<li><a class="side_link" href="<%=request.getContextPath()%>/ea/eaList.do">상세근태조회</a></li>
            <li><a class="side_link" href="<%=request.getContextPath()%>/ea/eaAdminList.do" >전체휴가조회</a></li>
			<li><a class="side_link" href="#">상세휴가조회</a></li>
			<li><a class="side_link" href="#">사원정보관리</a></li>
		</ul>
	</div><!-- //.sidebar -->
   <!-- 사이드바종료 -->
   
   <!-- 메인시작 -->
	<main>
		<h2>일일근태조회</h2>
		<div id="main_zone">
			<div id="hign_zone">
				<form name="sFrm" id="sFrm">
					<div id="date_select">
						<select name="leaveYear" id="leaveYear">
							<% 
								for (int year = 2018; year <= 2024; year++) {
								String formattedYear = String.format("%04d", year); // 연도를 4자리로 표현
							%>
							<option value="<%= formattedYear %>"<%= (formattedYear.equals(year)) ? "selected" : "" %>><%= formattedYear %></option>
							<% } %>
						</select>
						<p>년</p>
						<select name="leaveMonth" id="leaveMonth">
							<% 
								for (int month = 1; month <= 12; month++) {
								String formattedMonth = String.format("%02d", month); // 월을 2자리로 표현
							%>
							<option value="<%= formattedMonth %>"<%= (formattedMonth.equals(month)) ? "selected" : "" %>><%= formattedMonth %></option>
							<% } %>
						</select>
						<p>월</p>
					</div><!-- //#date_select -->
					<div id="select_zone">
					<label>부서별 :</label>
						<select name="leaveType" id="leaveType">
							<option value="전체" selected>전체</option>
							<option value="기획부">기획부</option>
							<option value="개발부">개발부</option>
							<option value="영업부">영업부</option>
							<option value="인사부">인사부</option>
							<option value="총무부">총무부</option>
						</select>
						<button id="typeBtn"><i class="xi-search"></i></button>
					</div>
				</form>
			</div><!-- //#high_zone-->

			<table id="main_table">
				<thead>
				  <tr>
					<th>부서</th>
					<th>사원명</th>
					<th>출근</th>
					<th>퇴근</th>
					<th>출/퇴근 구분</th>
				  </tr>
				</thead>
				<tbody>
			    <c:forEach var="commute" items="${clist}" varStatus="loop">
			     <c:set var="currentIndex" value="${loop.index}" />
			        <tr>
			            <td>${commute.departmentName}</td>
						<td>${uNames[currentIndex]}</td>
			            <td>${commute.cInTime}</td>
			            <td>${commute.cOutTime}</td>
			            <td>${commute.ctype}</td>
			        </tr>
			    </c:forEach>
			</tbody>
			</table>
				  


			<div id="paging_zone">
				<c:set var="keyword" value="${pm.scri.keyword}" />
				<c:set var="parm" value="&searchType=${pm.scri.searchType}&keyword=${pm.scri.keyword}" />

				<table border=0 style="width:600px;text-align:center;">
					<tr>
						<td style="width:100px;text-align:right;">
							<c:if test="${pm.prev == true}">
								<a href="${pageContext.request.contextPath}/board/boardList.do?page=${pm.startPage-1}${parm}"> ◀</a>
							</c:if>
						</td>
						<td>
							<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}" step="1">
								<a href="${pageContext.request.contextPath}/board/boardList.do?page=${i}${parm}">${i}</a> &nbsp;
							</c:forEach>
						</td>
						<td style="width:100px;text-align:left;">
							<c:if test="${pm.next == true&&pm.endPage>0}">
								<a href="${pageContext.request.contextPath}/board/boardList.do?page=${pm.endPage+1}${parm}"> ▶</a>
							</c:if>
						</td>
					</tr>
				</table>
			</div><!-- //#paging_zone -->



		</div><!-- //#main_zone -->


		<script>
			function toggleSidebar() {
			  const sidebar = document.getElementById('sidebar');
			  
			  sidebar.classList.toggle('active');
			}
		   </script>
	  
	</main>
</body>
</html>
