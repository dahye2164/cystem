<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>



<%
    java.util.Date now = new java.util.Date();
    request.setAttribute("commuteInfo", now);
%>

<c:set var="formattedInTime" value="<fmt:formatDate value='${cv.cInTime}' pattern='yyyy-MM-dd HH:mm:ss' timeZone='Asia/Seoul' />" />
<c:set var="formattedOutTime" value="<fmt:formatDate value='${cv.cOutTime}' pattern='yyyy-MM-dd HH:mm:ss' timeZone='Asia/Seoul' />" />

<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ page import="com.ezen.ezenhr.domain.UserVo" %>
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
    
	    <!-- SweetAlert2 CSS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.2/dist/sweetalert2.min.css">
	
	<!-- SweetAlert2 JS -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.2/dist/sweetalert2.all.min.js"></script>

    <!-- FullCalendar JavaScript 및 의존성 라이브러리(moment) -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.js"></script>
    <!-- FullCalendar 한국어 언어 파일 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/locale/ko.js"></script>

    <script>
    // 출퇴근 정보 수정 제출 버튼 클릭 시 
        $(document).ready(function () {
            // 페이지 로딩 시 출퇴근 정보를 미리 가져와서 FullCalendar 초기화
            loadCommuteInfoAndInitializeCalendar();

            // 출근 또는 퇴근 버튼 상태 업데이트 함수
            function updateButtonState(isSignedIn) {
                if (isSignedIn === 'true') {
                    // 출근 중인 경우의 처리
                    document.getElementById('signInBtn').style.display = 'none';
                    document.getElementById('signOutBtn').style.display = 'inline-block';
                    document.getElementById('signInBtn').disabled = true;
                    document.getElementById('signOutBtn').disabled = false;
                } else {
                    // 퇴근 중 또는 정보가 없는 경우의 처리
                    document.getElementById('signOutBtn').style.display = 'none';
                    document.getElementById('signInBtn').style.display = 'inline-block';
                    document.getElementById('signOutBtn').disabled = true;
                    document.getElementById('signInBtn').disabled = false;
                }
            }

            // 출근하기 버튼 클릭 시
            function signIn() {
                var isSignedIn = sessionStorage.getItem('isSignedIn');

                // 이미 출근한 경우 처리
                if (isSignedIn === 'true') {
                    alert('이미 출근하셨습니다.');
                    return;
                }

                // 출근 정보를 서버로 전송
                $.ajax({
                    url: "<%=request.getContextPath()%>/commute/signIn.do",
                    type: 'POST',
                    contentType: 'application/json',
                    success: function(response) {
                        // 서버에서의 응답에 따른 처리
                        if (response.success) {
                            sessionStorage.setItem('isSignedIn', 'true');
                            updateButtonState('true');
                        } else {
                            alert('출근 정보 전송 실패');
                        }
                    },
                    error: function() {
                        alert('서버 오류');
                    }
                });
            }

            // 퇴근하기 버튼 클릭 시
            function signOut() {
                var isSignedIn = sessionStorage.getItem('isSignedIn');

                if (isSignedIn !== 'true') {
                    alert('아직 출근하지 않았습니다.');
                    return;
                }

                // 퇴근 정보를 서버로 전송
                $.ajax({
                    url: "<%=request.getContextPath()%>/commute/signOut.do",
                    type: 'POST',
                    contentType: 'application/json',
                    success: function(response) {
                        // 서버에서의 응답에 따른 처리
                        if (response.success) {
                            sessionStorage.removeItem('isSignedIn');
                            updateButtonState('false');
                        } else {
                            alert('퇴근 정보 전송 실패');
                        }
                    },
                    error: function() {
                        alert('서버 오류');
                    }
                });
            }

            // 페이지 로딩 시 실행되는 부분
            var isSignedIn = sessionStorage.getItem('isSignedIn');
            updateButtonState(isSignedIn);

            // 페이지 로딩 시 출퇴근 정보를 가져와서 FullCalendar 초기화
            function loadCommuteInfoAndInitializeCalendar() {
                // 서버에서 출퇴근 정보를 가져오는 요청
                $.ajax({
                    url: '${path}/commute/myCommuteEvents.do',
                    method: 'GET',
                    success: function (data) {
                        // 서버에서 가져온 출퇴근 정보를 FullCalendar 이벤트로 변환
                        // FullCalendar 이벤트 생성
                        var events = data.map(function (commute) {
                            return {
                                title: commute.title, // 출근 또는 퇴근
                                start: new Date(commute.start.year, commute.start.monthValue - 1, commute.start.dayOfMonth, commute.start.hour, commute.start.minute, commute.start.second), // 출근 시간
                                end: new Date(commute.end.year, commute.end.monthValue - 1, commute.end.dayOfMonth, commute.end.hour, commute.end.minute, commute.end.second), // 퇴근 시간
                                allDay: false
                            };
                        });

                        // FullCalendar에 이벤트 추가
                        $('#api_zone').fullCalendar({
                            header: {
                                left: 'prev,next today',
                                center: 'title',
                                right: 'month,basicWeek,basicDay'
                            },
                            defaultView: 'month', // 기본으로 월 뷰로 설정
                            events: events, // 가져온 이벤트 데이터 설정
                            locale: 'ko' // 한국어로 설정
                        });
                    },
                    error: function () {
                        alert('서버 오류');
                    }
                });
            }
        });

        // 출근 또는 퇴근 버튼 상태 업데이트 함수
        function updateButtonState(isSignedIn) {
            // 세션 스토리지에 출근 여부 저장
            sessionStorage.setItem('isSignedIn', isSignedIn);

            if (isSignedIn === 'true') {
                // 출근 중인 경우의 처리
                document.getElementById('signInBtn').style.display = 'none';
                document.getElementById('signOutBtn').style.display = 'inline-block';
                document.getElementById('signInBtn').disabled = true;
                document.getElementById('signOutBtn').disabled = false;
            } else {
                // 퇴근 중 또는 정보가 없는 경우의 처리
                document.getElementById('signOutBtn').style.display = 'none';
                document.getElementById('signInBtn').style.display = 'inline-block';
                document.getElementById('signOutBtn').disabled = true;
                document.getElementById('signInBtn').disabled = false;
            }
        }

        // 출근하기 버튼 클릭 시
        function signIn() {
            var isSignedIn = sessionStorage.getItem('isSignedIn');

            // 이미 출근한 경우 처리
            if (isSignedIn === 'true') {
                alert('이미 출근하셨습니다.');
                return;
            }

            // 출근 정보를 서버로 전송
            $.ajax({
                url: "<%=request.getContextPath()%>/commute/signIn.do",
                type: 'POST',
                contentType: 'application/json',
                success: function(response) {
                    // 서버에서의 응답에 따른 처리
                    if (response.success) {
                        sessionStorage.setItem('isSignedIn', 'true');
                        updateButtonState('true');
                        Swal.fire({
                            title: '출근 처리 완료',
                            icon: 'success',
                            timer: 1500
                        });
                    } else {
                        alert('출근 정보 전송 실패');
                    }
                },
                error: function() {
                    alert('서버 오류');
                }
            });
        }

        // 퇴근하기 버튼 클릭 시
        function signOut() {
            var isSignedIn = sessionStorage.getItem('isSignedIn');

            if (isSignedIn !== 'true') {
                alert('아직 출근하지 않았습니다.');
                return;
            }

            // 퇴근 정보를 서버로 전송
            $.ajax({
                url: "<%=request.getContextPath()%>/commute/signOut.do",
                type: 'POST',
                contentType: 'application/json',
                success: function(response) {
                    // 서버에서의 응답에 따른 처리
                    if (response.success) {
                        sessionStorage.removeItem('isSignedIn');
                        updateButtonState('false');
                        
                        Swal.fire({
                            title: '퇴근 처리 완료',
                            icon: 'success',
                            timer: 1500
                        });
                    } else {
                        alert('퇴근 정보 전송 실패');
                    }
                },
                error: function() {
                    alert('서버 오류');
                }
            });
        }
        
    
    </script>
    <script type="text/javascript">
    
    function check() {

        var modiform = document.commuteModifyForm;
        var cInOrOut = document.getElementById('cInOrOut').value;
        var modifyTime = document.getElementById('modifyTime').value;
        var cReason = document.getElementById('cReason').value;

        if (cInOrOut.trim() === "") {
            Swal.fire('출근 또는 퇴근을 선택해주세요.', '', 'warning');
            modiform.cInOrOut.focus();
            return false;
        }

        if (modifyTime.trim() === "") {
            Swal.fire('시간을 설정해주세요.', '', 'warning');
            modiform.modifyTime.focus();
            return false;
        }

        if (cReason.trim() === "") {
            Swal.fire('사유를 입력해주세요.', '', 'warning');
            modiform.cReason.focus();
            return false;
        }

        modiform.action = "<%=request.getContextPath()%>/commute/commuteUpdateAction.do";
        modiform.method = "post";

        // 폼을 직접 서브밋하지 않고 AJAX로 서버에 요청
        $.ajax({
            type: modiform.method,
            url: modiform.action,
            data: $(modiform).serialize(),
            success: function (data) {
                if (data.success) {
                    // SweetAlert2로 메시지 표시
                    Swal.fire({
                        title: data.message,
                        icon: 'success',
                        timer: 1500
                    }).then(function () {
                        // "redirectURL" 키가 존재하면 해당 URL로 페이지 이동
                        if (data.redirectURL) {
                            window.location.href = data.redirectURL;
                        }
                    });
                } else {
                    // SweetAlert2로 에러 메시지 표시
                    Swal.fire('에러: ' + data.message, '', 'error');
                }
            },
            error: function () {
                // SweetAlert2로 서버 오류 메시지 표시
                Swal.fire('서버 오류', '', 'error');
            }
        });

        return false;
    }
    </script>
</head>
<body>
<%@include file="../include/header.jsp"%>

<!-- 사이드바 시작 -->
<button onclick="toggleSidebar()" id="sideBtn"><i class="xi-bars"></i></button>

<div class="sidebar" id="sidebar">
    <ul>
        <li><a class="side_link" href="<%=request.getContextPath() %>/commute/myCommute.do" style="color:#fff; background-color: #4682B4;">근태관리</a></li>
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
            <span><%= (String) request.getAttribute("departmentName") %></span>
        </div><!-- //.info_text -->

        <div class="info_text">
            <label>결재권한 :</label>
            <span><%= user.getuApprovalLevel() %></span>
        </div><!-- //.info_text -->

        <div class="info_text">
            <label>입사일 :</label>
            <span><%= user.getuHireDate().toString().substring(0, 10) %></span>
        </div><!-- //.info_text -->
    </section><!--//#my_info-->
    <div id="main_zone">
        <div id="api_zone">

        </div><!-- //#api_zone-->
        <div id="commute_modify_form">
            <form name="commuteModifyForm">
                <h2>출퇴근 시간 수정</h2>

                <div id="input_zone">
                    <div class="able_modify">
                        <label>현재 근무날짜</label>
							<p id="currentDate"></p>
							
							<!-- JavaScript 코드 -->
							<script>
							    // JavaScript를 사용하여 현재 날짜를 가져오고 p 태그에 추가
							    var currentDate = new Date();
							    var options = { year: 'numeric', month: 'long', day: 'numeric' };
							    var formattedDate = currentDate.toLocaleDateString('ko-KR', options);
							
							    // HTML에 해당 ID를 가진 요소에 날짜 추가
							    document.getElementById('currentDate').innerText = formattedDate;
							</script>
                    </div><!-- //.able_modify-->
                    <div class="able_modify">
                        <label>출근/퇴근 구분</label>
                        <select id ="cInOrOut" name="cInOrOut">
                            <option value="출근" selected>출근</option>
                            <option value="퇴근">퇴근</option>
                        </select>
                    </div><!-- //.able_modify-->
                    <div class="able_modify">
                        <label>시간</label>
                        <input type="time" id="modifyTime" name="modifyTime" />
                    </div><!-- //.able_modify-->
                </div><!-- //#input_zone-->
                <div id="modify_reason">
                    <label>사유</label>
                    <textarea name="cReason" id="cReason" placeholder="사유를 입력하고 제출 버튼을 눌러주세요. 제출 버튼 클릭시 결제 대기 상태로 변경됩니다."></textarea>
                </div><!-- //#modify_reason-->
                <div id="button_zone">
                    <button type="button" id="signInBtn" onclick="signIn()">출근하기</button>

                    <!-- 퇴근하기 버튼 (최초에는 숨겨둠) -->
                    <button type="button" id="signOutBtn" style="display:none;" onclick="signOut()">퇴근하기</button>
                    <input type="button" id="modiBtn" value="제출" onclick="check();" >
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