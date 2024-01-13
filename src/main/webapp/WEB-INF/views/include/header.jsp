<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link rel="shortcut icon" href="images/favicon.png"/>
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css"/>
        <link rel="stylesheet" href="${path }/resources/css/reset.css"/>
        <link rel="stylesheet" href="${path }/resources/css/include/header.css"/>
        
        
     
        <title>header</title>
	
    </head>
<body>
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
                        		<c:choose>
							<c:when test="${uidx == null }">
								<a href="<%=request.getContextPath()%>"
									onclick="return alert('로그인이 필요합니다.')">나의일정관리</a>
							</c:when>
							<c:otherwise>
								<a href="<%=request.getContextPath()%>/commute/myCommute.do">나의일정관리</a>
							</c:otherwise>
						</c:choose> 
                            <div class="sub">
                                <ul>
                                    <li>
                                    	<c:choose>
                                    		<c:when test="${uidx == null }">
                                    			<a href="<%=request.getContextPath()%>" onclick="return alert('로그인이 필요합니다.')">근태관리</a>
                                    		</c:when>
                                    		<c:otherwise>	
                                        		<a href="<%=request.getContextPath() %>/commute/myCommute.do">근태관리</a>
                                        	</c:otherwise>
                                        </c:choose>
                                    </li>
                                    <li>
                                    	<c:choose>
                                    		<c:when test="${uidx == null }">
                                    			<a href="<%=request.getContextPath()%>" onclick="return alert('로그인이 필요합니다.')">휴가관리</a>
                                    		</c:when>
                                    		<c:otherwise>	
                                        <a href="<%=request.getContextPath() %>/leave/myLeave.do">휴가관리</a>
                                        </c:otherwise>
                                        </c:choose>
                                    </li>
                                </ul>
                            </div>
                        </li>
                        <li>
                        	<c:choose>
                        		<c:when test="${uidx ==null }">
                            <a href="<%=request.getContextPath() %>" onclick="return alert('로그인이 필요합니다.')">전자결재</a>
                            	</c:when>
                            	<c:otherwise>
                            <a href="<%=request.getContextPath() %>/ea/eaList.do">전자결재</a>
                            	</c:otherwise>
                            </c:choose>
                            <div class="sub">
                                <ul>
                                    <li>
		                                <c:choose>
		                        			<c:when test="${uidx ==null }">
		                            			<a href="<%=request.getContextPath() %>" onclick="return alert('로그인이 필요합니다.')">새전자결재</a>
		                            		</c:when>
		                            		<c:otherwise>
		                            			<a href="<%=request.getContextPath() %>/ea/eaWrite.do">새전자결재</a>
		                            		</c:otherwise>
		                            	</c:choose>
                                    </li>
                                    <li>
                                    	<c:choose>
											<c:when test="${uidx ==null }">
												<a href="<%=request.getContextPath()%>"
													onclick="return alert('로그인이 필요합니다.')">전자결재목록</a>
											</c:when>
											<c:otherwise>
												<a href="<%=request.getContextPath()%>/ea/eaList.do">전자결재목록</a>
											</c:otherwise>
										</c:choose>
								</li>
                                     <li>
                                    	<a href="#">전자결재승인</a>
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
                           <%if (session.getAttribute("uidx") == null) { %>
                      <a href="#" id="loginBtn">로그인</a>
                     <%} else { %>
                         <a href="<%=request.getContextPath()%>/user/userLogout.do">로그아웃</a>
                     <%} %>
                        </li>
                        <div id="modalBackground"></div>
                        <div id="loginModal">
                            <span class="close-button" id="closeModalBtn" onclick="closeModal()">&times;</span>
                            <div class="modal-title">Ezen HR 로그인하기</div>
                     <form id="loginForm" name="loginForm">
                            <label for="username">아이디</label>
                            <input type="text" id="userId" name="userId"/>

                            <label for="password">비밀번호</label>
                            <input type="password" id="userPwd" name="userPwd"/>

                            <button type="button" onclick="login()">로그인</button>
                 	 </form>
                            <div class="additional-options">
                                <a href="#">아이디/비밀번호를 잊으셨나요?</a>
                                <a class="signup-button" href="#">회원가입하러가기</a>
                            </div>
                        </div>
                        <li>
                            <a href="${path }/user/userJoin.do">회원가입</a>
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
<script>
    var loginActionUrl = '<%=request.getContextPath()%>/user/userLoginAction.do';
    console.log(loginActionUrl);
</script>
<script src="${path}/resources/js/header.js"></script>
</body>
</html>