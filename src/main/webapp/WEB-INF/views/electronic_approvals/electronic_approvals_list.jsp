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
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css"/>
	<!-- 제이쿼리 연결 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<!-- 폰트 연결 -->
	<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css" />
	<!-- css연결 -->
	<link rel="stylesheet" href="${path }/resources/css/reset.css"/>
	<link rel="stylesheet" href="${path }/resources/css/electronic_approvals/electronic_approvals_list.css"/>
	<title>전자결재리스트</title>
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
						<a href="#">내스케쥴관리</a>
							<div class="sub">
								<ul>
									<li><a href="#">근태관리</a></li>
									<li><a href="#">휴가관리</a></li>
								</ul>
							</div><!-- //.sub -->
					</li><!-- 내스케쥴관리 -->
					<li>
						<a href="#" style="color:#4682B4">전자결재</a>
							<div class="sub">
								<ul>
									<li><a href="#">새전자결재</a></li>
									<li><a href="#" style="color:#4682B4">전자결재리스트</a></li>
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
			<li><a class="side_link" href="#">새전자결재</a></li>
			<li><a class="side_link" href="#" style="color:#fff; background-color: #4682B4;">전자결재리스트</a></li>
			<li><a class="side_link" href="#">임시저장함</a></li>
		</ul>
	</div><!-- //.sidebar -->
   <!-- 사이드바종료 -->
   
   <!-- 메인시작 -->
	<main>
		<h2>전자결재리스트</h2>
		<div id="main_zone">
			<div id="hign_zone">
				<form name="sFrm" id="sFrm">
					<div id="date_select">
						<select name="leaveYear" id="leaveYear">
							<% 
								for (int year = 2018; year <= 2023; year++) {
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
					<label>유형별 :</label>
						<select name="leaveType" id="leaveType">
							<option value="전체" selected>전체</option>
							<option value="연차">연차</option>
							<option value="반차">반차</option>
							<option value="경조사">경조사</option>
							<option value="병가">병가</option>
							<option value="기타">기타</option>
						</select>
						<label>상태별 :</label>
						<select name="leaveType2" id="leaveType2">
							<option value="전체" selected>전체</option>
							<option value="승인대기">승인대기</option>
							<option value="1차결재완료">1차결재완료</option>
							<option value="최종승인완료">최종승인완료</option>
						</select>
						<button id="typeBtn"><i class="xi-search"></i></button>
					</div>
				</form>
			</div><!-- //#high_zone-->

			<table id="main_table">
				<thead>
				  <tr>
					<th>휴가유형</th>
					<th>사유</th>
					<th>사용기간 (일수)</th>
					<th>승인상태</th>
					<th>신청일</th>
				  </tr>
				</thead>
				<tbody>
				  <tr>
					<td>연차</td>
					<td>연차휴가 신청의 건</td>
					<td>2023.11.01~2023.11.01 (1일)</td>
					<td>승인완료</td>
					<td>2023.10.23</td>
				  </tr>
				  <tr>
					<td>연차</td>
					<td>연차휴가 신청의 건</td>
					<td>2023.11.01~2023.11.01(1일)</td>
					<td>승인완료</td>
					<td>2023.10.23</td>
				  </tr>
				  <tr>
					<td>연차</td>
					<td>연차휴가 신청의 건</td>
					<td>2023.11.01~2023.11.01(1일)</td>
					<td>승인완료</td>
					<td>2023.10.23</td>
				  </tr>
				  <tr>
					<td>연차</td>
					<td>연차휴가 신청의 건</td>
					<td>2023.11.01~2023.11.01(1일)</td>
					<td>승인완료</td>
					<td>2023.10.23</td>
				  </tr>
				  <tr>
					<td>연차</td>
					<td>연차휴가 신청의 건</td>
					<td>2023.11.01~2023.11.01(1일)</td>
					<td>승인완료</td>
					<td>2023.10.23</td>
				  </tr>
				  <tr>
					<td>연차</td>
					<td>연차휴가 신청의 건</td>
					<td>2023.11.01~2023.11.01(1일)</td>
					<td>승인완료</td>
					<td>2023.10.23</td>
				  </tr>
				  <tr>
					<td>연차</td>
					<td>연차휴가 신청의 건</td>
					<td>2023.11.01~2023.11.01(1일)</td>
					<td>승인완료</td>
					<td>2023.10.23</td>
				  </tr>
				  <tr>
					<td>연차</td>
					<td>연차휴가 신청의 건</td>
					<td>2023.11.01~2023.11.01(1일)</td>
					<td>승인완료</td>
					<td>2023.10.23</td>
				  </tr>
				  <tr>
					<td>연차</td>
					<td>연차휴가 신청의 건</td>
					<td>2023.11.01~2023.11.01(1일)</td>
					<td>승인완료</td>
					<td>2023.10.23</td>
				  </tr>
				  <tr>
					<td>연차</td>
					<td>연차휴가 신청의 건</td>
					<td>2023.11.01~2023.11.01(1일)</td>
					<td>승인완료</td>
					<td>2023.10.23</td>
				  </tr>
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
