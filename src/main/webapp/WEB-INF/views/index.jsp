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
        <link rel="stylesheet" href="${path }/resources/css/index.css"/>
        <script src="${path }/resources/js/script.js"></script>
        <!--swiper plugin connect-->
        <script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
		          <!-- SweetAlert2 CSS -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.2/dist/sweetalert2.min.css">
		
		<!-- SweetAlert2 JS -->
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.2/dist/sweetalert2.all.min.js"></script>
        <title>Ezen HR</title>
        <script type="text/javascript">
        function login() {
            let userId = document.getElementById('userId').value;
            

            let fm = document.getElementById('loginForm');

            if (fm.userId.value == "") {
                alert("아이디를 입력해주세요.");
                fm.userId.focus();
                return;
            } else if (fm.userPwd.value == "") {
                alert("비밀번호를 입력해주세요");
                fm.userPwd.focus();
                return;
            }

            fm.action = "<%=request.getContextPath()%>/user/userLoginAction.do";
            console.log(fm.action);
            fm.method = "post";
            fm.submit();

            return;
        }
        </script>
       
    </head>
    <body>
        <header>
            <div class="inner">
                <div id="logo">
                    <h1>
                        <a href="${path }">Ezen HR</a>
                    </h1>
                </div>

                <nav id="gnb">
                    <ul>
                        <li>
					        <c:choose>
					            <c:when test="${uidx == null}">
					                <a href="<%=request.getContextPath()%>" onclick="return showAlert('로그인이 필요합니다.')">나의일정관리</a>
					            </c:when>
					            <c:otherwise>
					                <a href="<%=request.getContextPath()%>/commute/myCommute.do">나의일정관리</a>
					            </c:otherwise>
					        </c:choose>
					        <div class="sub">
					            <ul>
					                <li>
					                    <c:choose>
					                        <c:when test="${uidx == null}">
					                            <a href="<%=request.getContextPath()%>" onclick="return showAlert('로그인이 필요합니다.')">근태관리</a>
					                        </c:when>
					                        <c:otherwise>
					                            <a href="<%=request.getContextPath() %>/commute/myCommute.do">근태관리</a>
					                        </c:otherwise>
					                    </c:choose>
					                </li>
					                <li>
					                    <c:choose>
					                        <c:when test="${uidx == null}">
					                            <a href="<%=request.getContextPath()%>" onclick="return showAlert('로그인이 필요합니다.')">휴가관리</a>
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
					            <c:when test="${uidx == null}">
					                <a href="<%=request.getContextPath() %>" onclick="return showAlert('로그인이 필요합니다.')">전자결재</a>
					            </c:when>
					            <c:otherwise>
					                <a href="<%=request.getContextPath() %>/ea/eaList.do">전자결재</a>
					            </c:otherwise>
					        </c:choose>
					        <div class="sub">
					            <ul>
					                <li>
					                    <c:choose>
					                        <c:when test="${uidx == null}">
					                            <a href="<%=request.getContextPath() %>" onclick="return showAlert('로그인이 필요합니다.')">새전자결재</a>
					                        </c:when>
					                        <c:otherwise>
					                            <a href="<%=request.getContextPath() %>/ea/eaWrite.do">새전자결재</a>
					                        </c:otherwise>
					                    </c:choose>
					                </li>
					                <li>
					                    <c:choose>
					                        <c:when test="${uidx == null}">
					                            <a href="<%=request.getContextPath()%>" onclick="return showAlert('로그인이 필요합니다.')">전자결재목록</a>
					                        </c:when>
					                        <c:otherwise>
					                            <a href="<%=request.getContextPath()%>/ea/eaList.do">전자결재목록</a>
					                        </c:otherwise>
					                    </c:choose>
					                </li>
					                <li>
					                    <c:choose>
					                        <c:when test="${uidx == null}">
					                            <a href="<%=request.getContextPath()%>" onclick="return showAlert('로그인이 필요합니다.')">전자결재승인</a>
					                        </c:when>
					                        <c:otherwise>
					                            <a href="<%=request.getContextPath()%>/ea/eaAdminList.do">전자결재승인</a>
					                        </c:otherwise>
					                    </c:choose>
					                </li>
                                    <li>
                                        <a href="#">임시저장함</a>
                                    </li>
                                </ul>
                            </div>
                 
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
                        		<c:choose>
	                        		<c:when test="${uidx == null}">
	                        			<a href="<%=request.getContextPath() %>" onclick="return showAlert('로그인이 필요합니다.')"> 사원관리</a>
	                        		</c:when>
	                        		<c:otherwise>
	                            <a href="<%=request.getContextPath() %>/commute/dayCommuteManagement.do">사원관리</a>
	                            	</c:otherwise>
	                            </c:choose>
	                            
	                            
                            <div class="sub">
                                <ul>
                                    <li>
					                    <c:choose>
					                        <c:when test="${uidx == null}">
					                            <a href="<%=request.getContextPath()%>" onclick="return showAlert('로그인이 필요합니다.')">일일근태조회</a>
					                        </c:when>
					                        <c:otherwise>
					                            <a href="<%=request.getContextPath() %>/commute/dayCommuteManagement.do">일일근태조회</a>
					                        </c:otherwise>
					                    </c:choose>
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
                            <span class="close-button" onclick="closeModal()">&times;</span>
                            <div class="modal-title">Ezen HR 로그인하기</div>
                     <form id="loginForm">
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
                            <a href="user/userJoin.do">회원가입</a>
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
        <main>
            <section id="main_view">
                <div class="slider">
                    <article class="view view1">
                        <div class="text">
                            <h3>휴가 관리</h3>
                            <p>내 스케쥴관리 / 휴가관리</p>
                            <a href="#">자세히보기<i class="xi-angle-right"></i>
                            </a>
                        </div>
                    </article>
                    <article class="view view2">
                        <div class="text">
                            <h3>새 전자결재 작성하기</h3>
                            <p>전자 결재 / 새 전자결재</p>
                            <a href="#">작성하러가기<i class="xi-angle-right"></i>
                            </a>
                        </div>
                    </article>
                    <article class="view view3">
                        <div class="text">
                            <h3>쪽지 작성하기</h3>
                            <p>쪽지관리 / 새 쪽지작성</p>
                            <a href="#">작성하러가기<i class="xi-angle-right"></i>
                            </a>
                        </div>
                    </article>
                    <article class="view view4">
                        <div class="text">
                            <h3>DEV INFO</h3>
                            <p>Introduce Cystem Team</p>
                            <a href="#">자세히보기<i class="xi-angle-right"></i>
                            </a>
                        </div>
                    </article>
                </div>
                <div class="pager"></div>
            </section>

            <section id="partners">
                <h3>PARTNERS</h3>
                <ul>
                    <li><img src="${path }/resources/images/partners/01.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/02.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/03.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/04.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/05.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/06.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/07.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/08.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/09.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/10.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/11.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/12.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/13.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/14.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/15.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/16.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/17.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/18.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/19.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/20.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/21.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/22.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/23.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/24.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/25.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/26.jpg" alt=""/></li>
                    <li><img src="${path }/resources/images/partners/27.jpg" alt=""/></li>
                </ul>
            </section>

            <section id="about">
                <div class="inner">
                    <h3>ABOUT EzenHR</h3>
                    <p>
                        항상 열심히 일해주시고 소중한 인연이 되어주신 모든 사원분들께 다시 한번 감사드립니다. 앞으로도 기대에 어긋나지 않는 이젠컴퍼니가 되기 위해
                        노력하겠습니다. - 대표 오다혜
                    </p>
                    <a href="#">ABOUT EzenCompany<i class="xi-arrow-right"></i>
                    </a>
                </div>
            </section>

            <footer>
                <div class="inner">
                    <div class="logo">
                        <h1>
                            <img src="${path }/resources/images/btm-logo.png" alt=""/>
                        </h1>
                    </div>
                    <div class="info">
                        <dl>
                            <dt>EzenHR</dt>
                            <dd>
                                562, Deokjin-gu, Jeonju-si, Jeollabuk-do, Korea
                            </dd>
                            <dd>ogeon135@gmail.com</dd>
                            <dd>Tel : 010-3524-4305</dd>
                            <dd>Tel : 010-5659-2164</dd>
                        </dl>
                    </div>
                    <div class="info">
                        <dl>
                            <dt>JeonJu</dt>
                            <dd>전북 전주시 덕진구 백제대로 572 5층</dd>
                            <dd>cdh2164@naver.com</dd>
                            <dd>Tel : 010-3524-4305</dd>
                            <dd>Tel : 010-5659-2164</dd>
                        </dl>
                    </div>
                </div>
                <div class="copyright">
                    <p>Copyright &copy; Cystem All Rights Reserved.</p>
                </div>
            </footer>
            <script>
                // Get the modal
                var loginModal = document.getElementById("loginModal");

                // Get the button that opens the modal
                var loginBtn = document.getElementById("loginBtn");

                // Get the <span> element that closes the modal
                var closeLoginModal = document.getElementById("closeLoginModal");

                // When the user clicks the button, open the modal
                loginBtn.onclick = function () {
                    loginModal.style.display = "block";
                };

                function closeModal() {
                    document
                        .getElementById("modalBackground")
                        .style
                        .display = "none";
                    document
                        .getElementById("loginModal")
                        .style
                        .display = "none";
                }

                // When the user clicks anywhere outside of the modal, close it
                window.onclick = function (event) {
                    if (event.target == loginModal) {
                        loginModal.style.display = "none";
                    }
                };
            </script>
            
            <script type="text/javascript">
		        function showAlert(message) {
		            Swal.fire({
		                title: message,
		                icon: 'warning',
		                showConfirmButton: false,
		                timer: 1500
		            });
		            return false; // 클릭된 링크로 이동을 막습니다.
		        }
    		</script>
        </body>
    </html>