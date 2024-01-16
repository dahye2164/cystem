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
	<!-- SweetAlert2 CSS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.2/dist/sweetalert2.min.css">
	
	<!-- SweetAlert2 JS -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.2/dist/sweetalert2.all.min.js"></script>
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
							<label>종류</label> <select name="lType" id="lType">
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
				<textarea name="lReason" id="lReason" placeholder="사유를 입력하고 제출 버튼을 눌러주세요. 제출 버튼 클릭시 결제 대기 상태로 변경됩니다."></textarea>
					</div><!-- //#reason_file-->
					<div id="file_zone">
								<label>증빙서류</label>
								<button type="button" id="fileBtn">파일첨부</button>
								<p>파일명.hwp</p>
							</div><!-- //#file_zone-->
				<div id="person_zone">
					<div class="able_modify">
						<div id="person1">
							<label>1차결재자</label>
							<div class="ea_person">
								<select id="departmentSelect1" onchange="loadFirstApproverName()">
									<option value="" selected>전체</option>
									<option value="1">기획부</option>
									<option value="2">개발부</option>
									<option value="3">영업부</option>
									<option value="4">인사부</option>
									<option value="5">총무부</option>
								</select>
								<select id="userNameSelect1">
									<option value="전체" selected>전체</option>
								</select>
								<button type="button" id="addEaBtn"><i class="xi-user-plus"></i></button>
								<div id="addResult"></div>
							</div><!-- //.ea_person-->
						</div><!-- //#person1 -->
					</div><!-- //.able_modify-->
					<div class="able_modify">
						<div id="person2">
							<label>2차결재자</label>
							<div class="ea_person">
								 <select id="departmentSelect2" onchange="loadSecondApproverName()">
				                    <option value="" selected>전체</option>
				                    <option value="1">기획부</option>
				                    <option value="2">개발부</option>
				                    <option value="3">영업부</option>
				                    <option value="4">인사부</option>
				                    <option value="5">총무부</option>
				                </select>
				                <select id="userNameSelect2">
				                    <option value="전체" selected>전체</option>
				                </select>
				                <button type="button" id="addEaBtn2"><i class="xi-user-plus"></i></button>
				                <div id="addResult2"></div>
							</div><!-- //.ea_person-->
						</div><!-- //#person2 -->
					</div><!-- //.able_modify-->
					<div class="able_modify">
						<div id="person3">
						<label>참조자</label>
						<div class="ea_person">
							<select id="refDepartmentSelect" onchange="loadRefUserName()">
								<option value="" selected>전체</option>
								<option value="1">기획부</option>
								<option value="2">개발부</option>
								<option value="3">영업부</option>
								<option value="4">인사부</option>
								<option value="5">총무부</option>
							</select>
							<select id="refUserNameSelect">
								<option value="" selected>전체</option>
							</select>
							<button type="button" id="addRefEaBtn"><i class="xi-user-plus"></i></button>
							<div id="addRefResult"></div>
							</div><!-- //.ea_person-->
						</div><!-- //#person2 -->
					</div><!-- //.able_modify-->
				</div><!-- //#person_zone-->
				
				<div id="button_zone">
					<button type="submit" id="saveBtn">임시저장</button>
					<button type="button" id="modiBtn">제출</button>
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
		
		 // didx를 부서명으로 변환하는 함수
	    function getDepartmentNameByDidx(didx) {
	        switch (didx) {
	            case 1:
	                return "기획부";
	            case 2:
	                return "개발부";
	            case 3:
	                return "영업부";
	            case 4:
	                return "인사부";
	            case 5:
	                return "총무부";
	            default:
	                return "";
	        }
	    }
		
		// 두 번째 셀렉트박스에 전체 사원이름을 추가하는 함수
		function loadAllUsers() {
    // 서버에서 전체 사용자 목록을 가져오는 AJAX 요청
    $.ajax({
        type: "GET",
        url: "<%=request.getContextPath()%>/user/userAllSelect.do",
        success: function (data) {
            // 받아온 데이터를 이용하여 두 번째 셀렉트 옵션 업데이트
            var userNameSelect1 = $("#userNameSelect1");
            userNameSelect1.empty(); // 기존 옵션 제거

         // 데이터를 이용하여 옵션 추가
            for (var i = 0; i < data.length; i++) {
                var option = $("<option>")
                    .val(data[i].uidx)
                    .text(data[i].uName)
                    .data("user-info", data[i]); // 사용자 정보 저장

                userNameSelect1.append(option);
                
            }
        },
        error: function () {
            console.error("Failed to load all users");
        }
    });
}

		// 두 번째 셀렉트박스에 전체 사원이름을 추가하는 함수
		function loadAllUsers2() {
    // 서버에서 전체 사용자 목록을 가져오는 AJAX 요청
    $.ajax({
        type: "GET",
        url: "<%=request.getContextPath()%>/user/userAllSelect.do",
        success: function (data) {
            // 받아온 데이터를 이용하여 두 번째 셀렉트 옵션 업데이트

            var userNameSelect2 = $("#userNameSelect2");
            userNameSelect2.empty(); // 기존 옵션 제거

         // 데이터를 이용하여 옵션 추가
            for (var i = 0; i < data.length; i++) {
                var option = $("<option>")
                    .val(data[i].uidx)
                    .text(data[i].uName)
                    .data("user-info", data[i]); // 사용자 정보 저장

  

                // "전체"가 선택된 경우 두 번째 셀렉트와 참조 셀렉트에는 모든 사용자를 추가
                userNameSelect2.append(option);

                
            }
        },
        error: function () {
            console.error("Failed to load all users");
        }
    });
}
		// 두 번째 셀렉트박스에 전체 사원이름을 추가하는 함수
		function loadAllUsers3() {
    // 서버에서 전체 사용자 목록을 가져오는 AJAX 요청
    $.ajax({
        type: "GET",
        url: "<%=request.getContextPath()%>/user/userAllSelect.do",
        success: function (data) {

            var refUserNameSelect = $("#refUserNameSelect");
            refUserNameSelect.empty();
         // 데이터를 이용하여 옵션 추가
            for (var i = 0; i < data.length; i++) {
                var option = $("<option>")
                    .val(data[i].uidx)
                    .text(data[i].uName)
                    .data("user-info", data[i]); // 사용자 정보 저장


                refUserNameSelect.append(option);

            }
        },
        error: function () {
            console.error("Failed to load all users");
        }
    });
}
		 // 사용자 목록을 저장할 배열
	    var selectedUsers = [];
		 
	    var selectedUser1; // 1차 결재자
	    var selectedUser2; // 2차 결재자
		
	    function loadFirstApproverName(){
	        var didx = $("#departmentSelect1").val();
	        if (!didx) {
	            // "전체"가 선택되었을 때 loadAllUsers 호출
	            loadAllUsers();
	            return;
	        }
	
	        $.ajax({
	            type: "GET",
	            url: "<%=request.getContextPath()%>/user/userDepartmentSelect?didx=" + didx,
	            success: function (data) {
	                // 받아온 데이터를 이용하여 두 번째 셀렉트 옵션 업데이트
	                var userNameSelect1 = $("#userNameSelect1");
	                userNameSelect1.empty(); // 기존 옵션 제거
	
	              
	                // 데이터를 이용하여 옵션 추가
	                for (var i = 0; i < data.length; i++) {
	                    var option = $("<option>")
	                        .val(data[i].uidx)
	                        .text(data[i].uName)
	                        .data("user-info", data[i]); // 사용자 정보 저장
	                    userNameSelect1.append(option);
	                }
	            },
	            error: function () {
	                console.error("Failed to load employees");
	            }
	        });
	    }
	    
	    $("#departmentSelect1").change(function () {
	    	 loadFirstApproverName();
	    });
	    
	

	    function addSelectedUser() {
	        var selectedUserId1 = $("#userNameSelect1").val();

	        // 사용자를 선택하지 않은 경우
	        if (!selectedUserId1) {
	        	Swal.fire({
	                title: "선택 오류",
	                text: "사용자를 선택해주세요.",
	                icon: 'error',
	                showConfirmButton: false,
	                timer: 1500
	            });
	            return;
	        }

	        var selectedUser1Info = $("#userNameSelect1 option:selected").data("user-info");

	        console.log("Selected User Info:", selectedUser1Info); // 디버깅을 위해 출력

	        // 이미 선택된 사용자인지 확인
	        if (!selectedUser1) {
	            // 새로운 사용자 추가
	            selectedUser1 = {
	                userName: selectedUser1Info.uName,
	                uidx: selectedUserId1,
	                department: getDepartmentNameByDidx(selectedUser1Info.didx)
	            };

	            // 사용자 목록 갱신
	            displaySelectedUser();
	        } else {
	            // 이미 선택된 사용자일 경우 알림
	        	 Swal.fire({
	        	        title: "선택 완료",
	        	        text: "이미 선택된 사용자가 있습니다.",
	        	        icon: 'info',
	        	        showConfirmButton: false,
	        	        timer: 1500
	        	    });
	        }
	    }

	    function displaySelectedUser() {
	        var addResult = $("#addResult");
	        addResult.empty(); // 기존 사용자 목록 제거

	        // 선택된 사용자 목록을 addResult에 추가
	        if (selectedUser1) {
	            var userContainer = $('<div>').addClass('user-container');

	            // 사용자 정보 텍스트 추가
	            var userText = $('<div>').text(selectedUser1.department + ' ' + selectedUser1.userName);

	            // 삭제 버튼 추가
	            var deleteButton = $('<button>').text('삭제').click(function () {
	                // 삭제 함수 호출
	                removeSelectedUser1();
	            });

	            // userContainer에 uidx 값 추가
	            userContainer.data('uidx', selectedUser1.uidx);

	            // 사용자 정보와 삭제 버튼을 사용자 컨테이너에 추가
	            userContainer.append(userText).append(deleteButton);

	            // 사용자 컨테이너를 addResult에 추가
	            addResult.append(userContainer);
	        }
	    }

	    function removeSelectedUser1() {
	        // 선택된 사용자 초기화
	        selectedUser1 = null;

	        // 사용자 목록 갱신
	        displaySelectedUser();
	    }

	    // 이벤트 핸들러 등록
	    $("#addEaBtn").click(function () {
	        addSelectedUser();
	    });


	    //-------------------------------2차결재자------------------------------------------------
	    
	    
	    	function loadSecondApproverName() {
	    		   var didx = $("#departmentSelect2").val();
	   	        if (!didx) {
	   	            // "전체"가 선택되었을 때 loadAllUsers 호출
	   	            loadAllUsers2();
	   	            return;
	   	        }
	
	        $.ajax({
	            type: "GET",
	            url: "<%=request.getContextPath()%>/user/userDepartmentSelect?didx=" + didx,
	            success: function (data) {
	                // 받아온 데이터를 이용하여 두 번째 셀렉트 옵션 업데이트
	                var userNameSelect2 = $("#userNameSelect2");
	                userNameSelect2.empty(); // 기존 옵션 제거
	
	              
	                for (var i = 0; i < data.length; i++) {
	                    var option = $("<option>")
	                        .val(data[i].uidx)
	                        .text(data[i].uName)
	                        .data("user-info", data[i]); // 사용자 정보 저장
	                    userNameSelect2.append(option);
	                    console.log("User Info for " + data[i].uName + ":", data[i]);
	                }
	            },
	            error: function () {
	                console.error("Failed to load employees");
	            }
	        });
	    }
	    
	    $("#departmentSelect2").change(function () {
	    	 loadSecondApproverName();
	    });
	    


	    function addSelectedUser2() {
	    	var selectedUserId2 = $("#userNameSelect2").val();

	        // 사용자를 선택하지 않은 경우
	        if (!selectedUserId2) {
	        	 Swal.fire({
	        	        title: "선택 오류",
	        	        text: "사용자를 선택해주세요.",
	        	        icon: 'error',
	        	        showConfirmButton: false,
	        	        timer: 1500
	        	    });
	            return;
	        }

	        
	        var selectedUser2Info = $("#userNameSelect2 option:selected").data("user-info");

	        console.log("Selected User Info:", selectedUser2Info); // 디버깅을 위해 출력

	     // 이미 선택된 사용자인지 확인
	        if (!selectedUser2) {
	            // 새로운 사용자 추가
	            selectedUser2 = {
	                userName: selectedUser2Info.uName,
	                uidx: selectedUserId2,
	                department: getDepartmentNameByDidx(selectedUser2Info.didx)
	            };

	            // 사용자 목록 갱신
	            displaySelectedUser2();
	        } else {
	            // 이미 선택된 사용자일 경우 알림
	        	Swal.fire({
	                title: "선택 완료",
	                text: "이미 선택된 사용자가 있습니다.",
	                icon: 'info',
	                showConfirmButton: false,
	                timer: 1500
	            });
	        }
	    }


	    function displaySelectedUser2() {
	        var addResult2 = $("#addResult2");
	        addResult2.empty(); // 기존 사용자 목록 제거

	        // 선택된 사용자 목록을 addResult에 추가
	        if (selectedUser2) {
	            var userContainer = $('<div>').addClass('user-container');

	            // 사용자 정보 텍스트 추가
	            var userText = $('<div>').text(selectedUser2.department + ' ' + selectedUser2.userName);

	            // 삭제 버튼 추가
	            var deleteButton = $('<button>').text('삭제').click(function () {
	                // 삭제 함수 호출
	                removeSelectedUser();
	            });

	            // userContainer에 uidx 값 추가
	            userContainer.data('uidx', selectedUser2.uidx);

	            // 사용자 정보와 삭제 버튼을 사용자 컨테이너에 추가
	            userContainer.append(userText).append(deleteButton);

	            // 사용자 컨테이너를 addResult에 추가
	            addResult2.append(userContainer);
	        }
	    }

	    function removeSelectedUser() {
	        // 선택된 사용자 초기화
	        selectedUser2 = null;

	        // 사용자 목록 갱신
	        displaySelectedUser2();
	    }

	    // 이벤트 핸들러 등록
	    $("#addEaBtn2").click(function () {
	        addSelectedUser2();
	    });

	    // 초기화
	    function initialize() {
	        // 선택된 사용자 초기화
	        selectedUser1 = null;

	        // 사용자 목록 초기화
	        displaySelectedUser();
	        
	        selectedUser2 = null;

	        // 사용자 목록 초기화
	        displaySelectedUser2();
	    }

	   
	   


	    
	    
	    
	    //----------------------------------참조자-----------------------------
	    function loadRefUserName() {
	    var refDidx = $("#refDepartmentSelect").val();
	    if (!refDidx) {
	        // "전체"가 선택되었을 때 loadAllUsers 호출
	        loadAllUsers3();
	        return;
	    }
	
	    $.ajax({
	        type: "GET",
	        url: "<%=request.getContextPath()%>/user/userDepartmentSelect?didx=" + refDidx,
	        success: function (data) {
	            // 받아온 데이터를 이용하여 두 번째 셀렉트 옵션 업데이트
	        	  var refUserNameSelect = $("#refUserNameSelect");
	              refUserNameSelect.empty();

	              for (var i = 0; i < data.length; i++) {
	                  var option = $("<option>")
	                      .val(data[i].uidx)
	                      .text(data[i].uName)
	                      .data("user-info", data[i]); // 사용자 정보 저장
	                  refUserNameSelect.append(option);
	                  console.log("User Info for " + data[i].uName + ":", data[i]);
	              }
	          },
	        error: function () {
	            console.error("Failed to load reference users");
	        }
	    });
	}
	
	$("#refDepartmentSelect").change(function () {
	    loadRefUserName();
	});
	
	var selectedRefUsers = [];
	
	function addSelectedRefUser() {
	    var selectedRefUserId = $("#refUserNameSelect").val();
	
	    // 사용자를 선택하지 않은 경우
	    if (!selectedRefUserId) {
	    	 Swal.fire({
	    	        title: "선택 오류",
	    	        text: "사용자를 선택해주세요.",
	    	        icon: 'error',
	    	        showConfirmButton: false,
	    	        timer: 1500
	    	    });
	        return;
	    }
	
	    var selectedRefUserInfo = $("#refUserNameSelect option:selected").data("user-info");
	    console.log("Selected User Info for refUserNameSelect:", selectedRefUserInfo);
	    var selectedRefUserName = $("#refUserNameSelect option:selected").text();
	
	    // 이미 선택된 사용자인지 확인
	    var isAlreadySelected = selectedRefUsers.some(function (user) {
	        return user.userId === selectedRefUserId && user.uidx === selectedRefUserId;
	    });
	
	    // 중복 선택 방지
	    if (!isAlreadySelected) {
	        // 새로운 사용자 추가
	        selectedRefUsers.push({
	            userId: selectedRefUserId,
	            userName: selectedRefUserName,
	            department: getDepartmentNameByDidx(selectedRefUserInfo.didx),
	            uidx: selectedRefUserId // 여기에 uidx 추가
	        });
	
	        // 사용자 목록 갱신
	        displaySelectedRefUsers();
	    } else {
	        // 이미 선택된 사용자일 경우 알림
	    	Swal.fire({
	            title: "선택 완료",
	            text: "이미 선택된 사용자입니다.",
	            icon: 'info',
	            showConfirmButton: false,
	            timer: 1500
	        });
	    }
	}
	
	function displaySelectedRefUsers() {
	    var addRefResult = $("#addRefResult");
	    addRefResult.empty(); // 기존 사용자 목록 제거
	
	    // 선택된 사용자 목록을 addRefResult에 추가
	    for (var i = 0; i < selectedRefUsers.length; i++) {
	        var userContainer = $('<div>').addClass('user-container');
	
	        // 사용자 정보 텍스트 추가
	        var userText = $('<div>').text(selectedRefUsers[i].department + ' ' + selectedRefUsers[i].userName);
	
	        // 삭제 버튼 추가
	        var deleteButton = $('<button>').text('삭제').click(function() {
	            // 클릭한 버튼이 속한 사용자 컨테이너
	            var userContainer = $(this).closest('.user-container');
	
	            // 삭제 함수 호출
	            removeSelectedRefUser(userContainer);
	        });
	
	        // userContainer에 uidx 값 추가
	        userContainer.data('uidx', selectedRefUsers[i].uidx);
	
	        // 사용자 정보와 삭제 버튼을 사용자 컨테이너에 추가
	        userContainer.append(userText).append(deleteButton);
	
	        // 사용자 컨테이너를 addRefResult에 추가
	        addRefResult.append(userContainer);
	    }
	}
	
	function removeSelectedRefUser(userContainer) {
	    // 삭제 버튼을 클릭한 사용자의 uidx 값 가져오기
	    var uidxToRemove = userContainer.data('uidx');
	
	    // 선택된 사용자 목록에서 해당 사용자 제거
	    selectedRefUsers = selectedRefUsers.filter(function(user) {
	        return user.userId !== uidxToRemove;
	    });
	
	    // 사용자 목록 갱신
	    displaySelectedRefUsers();
	}
	
	// 이벤트 핸들러 등록
	$("#addRefEaBtn").click(function () {
	    addSelectedRefUser();
	});
	    
	 // 페이지 로드 시 초기화
    $(document).ready(function () {
    	  // 처음에 페이지 로드될 때 두 번째 셀렉트박스에 전체 사원이름을 추가
	    loadAllUsers();
	    loadAllUsers2();
	    loadAllUsers3();
        initialize();
        
     // 제출 버튼 클릭 시 이벤트 처리
        $("#modiBtn").click(function () {
            submitForm();
        });
    });
	</script>
	
	<script>
	
	function submitForm() {
	    // 각 입력 폼에서 데이터 수집
	    
	    // 파일 첨부 관련 코드도 추가해야 함

	    // 선택된 결재자 및 참조자 목록 수집
	    var approvalUsers = [];
	    if (selectedUser1) {
	        approvalUsers.push({
	            uidx: selectedUser1.uidx,
	            uApprovalLevel: 1
	        });
	    }
	    if (selectedUser2) {
	        approvalUsers.push({
	            uidx: selectedUser2.uidx,
	            uApprovalLevel: 2
	        });
	    }
	
	    // 참조자 목록도 추가해야 함
/* 	    for (var i = 0; i < selectedRefUsers.length; i++) {
	        approvalUsers.push({
	            uidx: selectedRefUsers[i].uidx,

	            type: "reference"
	        });
	    } */
	 // AJAX를 사용하여 서버에 데이터 전송
	  $.ajax({
	        type: "POST",
	        url: "<%=request.getContextPath()%>/ea/submitElectronicApproval.do",
	        contentType: "application/json", // JSON 데이터 전송 시에는 Content-Type을 명시
	        data: JSON.stringify({
	        	approvalStatus:"W",
	            approvalUidx1: selectedUser1 ? selectedUser1.uidx : null,
	            approvalUidx2: selectedUser2 ? selectedUser2.uidx : null
	        }),
	        success: function (response) {
	            Swal.fire({
	                title: "전자결재 제출 성공",
	                text: "전자결재가 제출되었습니다.",
	                icon: 'success',
	                showConfirmButton: false,
	                timer: 1500
	            });

	            // 성공적으로 전송되었을 때의 처리
	            console.log("Form submitted successfully:", response);
	            var aidx = response.aidx;
	            submitLeave(aidx);
	        },
	        error: function () {
	            // 전송 실패 시의 처리
	            console.error("Failed to submit form data");
	        }
	    });
	 
	 
	 
	}
	 
	 
	function submitLeave(aidx) {
		
		var startDate = $("#startDate").val();
	    var endDate = $("#endDate").val();
	    var lReason = $("#lReason").val();
	    var lType= $("#lType").val();
	    $.ajax({
	        type: "POST",
	        url: "<%=request.getContextPath()%>/leave/submitLeave.do",
	        data: {
	        	  lStart: startDate,
	              lEnd: endDate,
	              lState:"W",
	              lAcpYn:"N",
	              lType: lType,
	              lReason: lReason,
	              aidx: aidx
	        },
	        success: function (response) {

	        },
	        error: function () {
	            // 전송 실패 시의 처리
	            console.error("Failed to submit form data");
	        }
	    });
	 
	}
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	   
	</script>
	</main>
</body>
</html>
