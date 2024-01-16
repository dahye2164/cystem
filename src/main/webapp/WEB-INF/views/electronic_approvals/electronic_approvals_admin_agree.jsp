<!-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> -->
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- 파비콘연결 -->
    <link rel="shortcut icon" href="images/favicon.png" />
    <!-- 아이콘 연결 -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css"
    />
    <!-- 제이쿼리 연결 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <!-- 폰트 연결 -->
    <link
      rel="stylesheet"
      as="style"
      crossorigin
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css"
    />
    <!-- css연결 -->
    <link rel="stylesheet" href="${path }/resources/css/reset.css" />
    <link
      rel="stylesheet"
      href="${path }/resources/css/electronic_approvals/electronic_approvals_write.css"
    />
    <link rel="stylesheet" href="결재승인.css" />
    <!-- SweetAlert2 CSS -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.2/dist/sweetalert2.min.css"
    />

    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.2/dist/sweetalert2.all.min.js"></script>
    <title>결재승인</title>
  </head>
  <body>
    <!-- <%@include file="../include/header.jsp"%> -->

    <!-- 사이드바 시작 -->
    <!-- <button onclick="toggleSidebar()" id="sideBtn">
      <i class="xi-bars"></i>
   </button>

   <div class="sidebar" id="sidebar">
      <ul>
         <li><a class="side_link" href="<%=request.getContextPath() %>/ea/eaWrite.do" style="color:#fff; background-color: #4682B4;">새전자결재</a></li>
         <li><a class="side_link" href="<%=request.getContextPath()%>/ea/eaList.do">전자결재목록</a></li>
            <li><a class="side_link" href="<%=request.getContextPath()%>/ea/eaAdminList.do" >전자결재승인</a></li>
         <li><a class="side_link" href="#">임시저장함</a></li>
      </ul>
   </div> -->
    <!-- //.sidebar -->
    <!-- 사이드바종료 -->

    <main>
      <h2>결재승인</h2>
      <div id="main_zone">
        <form name="frm" id="frm">
          <div id="input_zone">
            <div id="date_zone">
              <span class="check">✔︎</span><label>기간</label>
              <p id="startDate">2024-01-17</p>
              <span> ~ </span>
              <p id="endDate">2024-01-18</p>
            </div>
            <!-- //#date_zone -->
            <div id="type_zone">
              <span class="check">✔︎</span><label>종류</label>
              <p>연차</p>
            </div>
            <!-- //type_zone -->
          </div>
          <!-- //#input_zone-->
          <div id="reason_file">
            <span class="check">✔︎</span><label>사유</label>
            <p id="lReason">
              안녕하세요 저는 김 사원입니다. 다름이 아니고 제가 독감에 걸려 열이
              너무 많이 올라 도저히 업무를 하기 어려운 상황입니다. 내일 하루만
              쉬고 다음날 감쪽같이 나아서 열심히 일을 해보도록 하겠습니다. 제
              업무에 대신 힘 써주실 과장님, 부장님, 대리님 모두 화이팅입니다 ^^
              하하하하하하!!!!!!!!!!!!
            </p>
          </div>
          <!-- //#reason_file-->
          <div id="file_zone">
            <span class="check">✔︎</span><label>증빙서류</label>
            <p>파일명.hwp</p>
          </div>
          <!-- //#file_zone-->
          <div id="person_zone">
            <div id="person1">
              <label>1차결재자</label>
              <div class="ea_person">
                <p id="departmentSelect1" onchange="loadFirstApproverName()">
                  기획부
                </p>
                <p id="userNameSelect1">조승완</p>
                <div id="addResult"></div>
              </div>
              <!-- //.ea_person-->
            </div>
            <!-- //#person1 -->
            <div id="person2">
              <label>2차결재자</label>
              <div class="ea_person">
                <p id="departmentSelect2" onchange="loadSecondApproverName()">
                  재정부
                </p>
                <p id="userNameSelect2">송정미</p>
                <div id="addResult2"></div>
              </div>
              <!-- //.ea_person-->
            </div>
            <!-- //#person2 -->
            <div id="person3">
              <label>참조자</label>
              <div class="ea_person">
                <p id="refDepartmentSelect" onchange="loadRefUserName()">
                  홍보부
                </p>
                <p id="refUserNameSelect">양우림</p>
                <div id="addRefResult"></div>
              </div>
              <!-- //.ea_person-->
            </div>
            <!-- //#person2 -->
          </div>
          <!-- //#person_zone-->

          <div id="button_zone">
            <button type="submit" id="admBtn">승인</button>
            <button type="button" id="rejBtn">거절</button>
            <button type="button" id="backBtn" onclick="history.back">
              목록
            </button>
          </div>
          <!-- //#button_zone-->
        </form>
      </div>
      <!-- //#main_zone -->
      
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
       
   function validateForm() {
      var startDate = $("#startDate").val();
       var endDate = $("#endDate").val();

       // 입력값이 없는 경우 에러 메시지 출력
       if (!startDate || !endDate) {
           Swal.fire({
               title: "입력 오류",
               text: "기간을 모두 입력해주세요.",
               icon: 'error',
               showConfirmButton: false,
               timer: 1500
           });
           return false;
       }

       // 날짜 형식으로 변환
       var startDateObj = new Date(startDate);
       var endDateObj = new Date(endDate);

       // 시작일자가 종료일자보다 늦으면 에러 메시지 출력
       if (startDateObj > endDateObj) {
           Swal.fire({
               title: "입력 오류",
               text: "시작 일자는 종료 일자보다 이전이어야 합니다.",
               icon: 'error',
               showConfirmButton: false,
               timer: 1500
           });
           return false;
       }


       // 종류 선택 확인
       var lType = $("#lType").val();
       if (!lType || lType === "전체") {
           Swal.fire({
               title: "입력 오류",
               text: "종류를 선택해주세요.",
               icon: 'error',
               showConfirmButton: false,
               timer: 1500
           });
           return false;
       }

       // 사유 입력 확인
       var lReason = $("#lReason").val();
       if (!lReason) {
           Swal.fire({
               title: "입력 오류",
               text: "사유를 입력해주세요.",
               icon: 'error',
               showConfirmButton: false,
               timer: 1500
           });
           return false;
       }

    // 1차 결재자 선택 확인
       if (!selectedUser1) {
        Swal.fire({
            title: "입력 오류",
            text: "1차 결재자를 선택해주세요.",
            icon: 'error',
            showConfirmButton: false,
            timer: 1500
           });
        return false;
       }

       // 2차 결재자 선택 확인
     if (!selectedUser2) {
        Swal.fire({
            title: "입력 오류",
            text: "2차 결재자를 선택해주세요.",
            icon: 'error',
            showConfirmButton: false,
            timer: 1500
           });
        return false;
       }

       return true; // 모든 유효성 검사를 통과하면 true 반환
   }

   
    // 페이지 로드 시 초기화
    $(document).ready(function () {
         // 처음에 페이지 로드될 때 두 번째 셀렉트박스에 전체 사원이름을 추가
       loadAllUsers();
       loadAllUsers2();
       loadAllUsers3();
        initialize();
        
     // 제출 버튼 클릭 시 유효성 검사 후 제출
        $("#modiBtn").click(function () {
            if (validateForm()) {
                submitForm();
            }
        });
    });
   </script>
   
   <script>
   
   function submitForm() {
       // 각 입력 폼에서 데이터 수집
       
       // 파일 첨부 관련 코드도 추가해야 함

       // 선택된 결재자 및 참조자 목록 수집

   
       // 참조자 목록도 추가해야 함
/*        for (var i = 0; i < selectedRefUsers.length; i++) {
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
    
    
    
    
    
    
    
    
    
    
      
   </script> —>
    </main>
  </body>
</html>