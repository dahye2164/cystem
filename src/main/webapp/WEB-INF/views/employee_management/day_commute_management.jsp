<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.ezen.ezenhr.domain.UserVo" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

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
	    <select name="commuteYear" id="commuteYear">
	        <%
	            int currentYear = LocalDateTime.now().getYear();
	            for (int year = 2018; year <= 2024; year++) {
	                String formattedYear = String.format("%04d", year);
	        %>
	        <option value="<%= formattedYear %>"<%= (formattedYear.equals(String.valueOf(currentYear))) ? "selected" : "" %>><%= formattedYear %></option>
	        <% } %>
	    </select>
	    <p>년</p>
	    <select name="commuteMonth" id="commuteMonth">
	        <% 
	            int currentMonth = LocalDateTime.now().getMonthValue();
	            for (int month = 1; month <= 12; month++) {
	                String formattedMonth = String.format("%02d", month);
	        %>
	        <option value="<%= formattedMonth %>"<%= (formattedMonth.equals(String.valueOf(currentMonth))) ? "selected" : "" %>><%= formattedMonth %></option>
	        <% } %>
	    </select>
	    <p>월</p>
	    <select name="commuteDay" id="commuteDay">
	        <% 
	            int currentDay = LocalDateTime.now().getDayOfMonth();
	            for (int day = 1; day <= 31; day++) {
	                String formattedDay = String.format("%02d", day);
	        %>
	        <option value="<%= formattedDay %>"<%= (formattedDay.equals(String.valueOf(currentDay))) ? "selected" : "" %>><%= formattedDay %></option>
	        <% } %>
	    </select>
	    <p>일</p>
	</div><!-- //#date_select -->
	
	<!-- ... (이전 코드) ... -->
	
	<div id="currentDateContainer">
	    <p id="currentDate" style="font-size: 20px; font-weight: bold; text-align: center;"></p>
	</div>
	
	<div id="select_zone">
	    <label>부서별 :</label>
	    <select name="commuteType" id="commuteType">
	        <option value="" selected>전체</option>
	        <option value="기획부">기획부</option>
	        <option value="개발부">개발부</option>
	        <option value="영업부">영업부</option>
	        <option value="인사부">인사부</option>
	        <option value="총무부">총무부</option>
	    </select>
	    <button id="typeBtn" onclick="searchByDate()"><i class="xi-search"></i></button>
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
                    <th>출/퇴근 상태</th>
                  </tr>
                </thead>
                <tbody>
                <c:forEach var="commute" items="${clist}" varStatus="loop">
                    <tr>
                        <td>${commute.departmentName}</td>
                        <td>${uNames[loop.index]}</td>
                        <td>${commute.cInTime.format(DateTimeFormatter.ofPattern("a hh:mm"))}</td>
                        <td>${commute.cOutTime.format(DateTimeFormatter.ofPattern("a hh:mm"))}</td>
                        <td>${commute.ctype}</td>
                    </tr>
                </c:forEach>
            </tbody>
            </table>

             <!-- 페이징 부분 -->

<!-- 페이징 부분 끝 -->
        </div><!-- //#main_zone -->
    </main>
    <script>
    function updateDate(selectedDate) {
        var currentDate = selectedDate || new Date();
        var year = currentDate.getFullYear();
        var month = ('0' + (currentDate.getMonth() + 1)).slice(-2);
        var day = ('0' + currentDate.getDate()).slice(-2);
        var dayOfWeek = ['일', '월', '화', '수', '목', '금', '토'][currentDate.getDay()];

        $('#currentDate').text(year + '.' + month + '.' + day + ' (' + dayOfWeek + ')');
    }

    function searchByDate() {
        var selectedYear = $('#commuteYear').val();
        var selectedMonth = $('#commuteMonth').val();
        var selectedDay = $('#commuteDay').val();
        var selectedDate = new Date(selectedYear, selectedMonth - 1, selectedDay); 

        // 여기서부터 수정
        // 검색 로직을 수행하지 않고, 바로 날짜를 업데이트
        updateDate(selectedDate);
        // 여기까지 수정
    }

    $(document).ready(function() {
        // 초기화
        updateDate();
    });

    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('active');
    }
</script>
</body>
</html>