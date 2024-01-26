 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
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
    <link rel="stylesheet" href="${path }/resources/css/electronic_approvals/electronic_approvals_admin_agree.css"/>
    <!-- SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.2/dist/sweetalert2.min.css" />

    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.2/dist/sweetalert2.all.min.js"></script>
    <title>결재승인</title>
  </head>
  <body>
	<%@include file="../include/header.jsp"%> 

    <!-- 사이드바 시작 -->
    <button onclick="toggleSidebar()" id="sideBtn">
      <i class="xi-bars"></i>
   </button>

   <div class="sidebar" id="sidebar">
      <ul>
         <li><a class="side_link" href="<%=request.getContextPath() %>/ea/eaWrite.do" >새전자결재</a></li>
         <li><a class="side_link" href="<%=request.getContextPath()%>/ea/eaList.do">전자결재목록</a></li>
         <li><a class="side_link" href="<%=request.getContextPath()%>/ea/eaAdminList.do" style="color:#fff; background-color: #4682B4;" >전자결재승인</a></li>
         <li><a class="side_link" href="#">임시저장함</a></li>
      </ul>
   </div>
    <!-- //.sidebar -->
    <!-- 사이드바종료 -->

    <main>
      <h2>결재승인</h2>
      <div id="main_zone">
        <form name="frm" id="frm">
          <div id="input_zone">
          	<div id="uidx_zone">
          		 <span class="check">✔︎</span><label>기안자</label>
          		 <p id="luidx">${uv3.uName}</p>
          	</div>
            <div id="date_zone">
              <span class="check">✔︎</span><label>기간</label>
              <p id="startDate">${lv.lStart}</p>
              <span> ~ </span>
              <p id="endDate">${lv.lEnd}</p>
            </div><!-- //#date_zone -->
            <div id="type_zone">
              <span class="check">✔︎</span><label>종류</label>
              <p>${lv.lType}</p>
            </div><!-- //type_zone -->
          </div>  <!-- //#input_zone-->
          <div id="reason_file">
            <span class="check">✔︎</span><label>사유</label>
            <p id="lReason">
              ${lv.lReason}
            </p>
          </div> <!-- //#reason_file-->
          <div id="file_zone">
            <span class="check">✔︎</span><label>증빙서류</label>
            <p>파일명.hwp</p>
          </div><!-- //#file_zone-->
          <div id="person_zone">
            <div id="person1">
              <label>1차결재자</label>
              <div class="ea_person">
                <p id="departmentSelect1" onchange="loadFirstApproverName()">
                 ${uv1.didx}
                </p>
                <p id="userNameSelect1"> ${uv1.uName}</p>
                <div id="addResult"></div>
              </div> <!-- //.ea_person-->
            </div><!-- //#person1 -->
            <div id="person2">
              <label>2차결재자</label>
              <div class="ea_person">
                <p id="departmentSelect2" onchange="loadSecondApproverName()">
                   ${uv2.didx}
                </p>
                <p id="userNameSelect2">${uv2.uName}</p>
                <div id="addResult2"></div>
              </div> <!-- //.ea_person-->
            </div><!-- //#person2 -->
            <div id="person3">
              <label>참조자</label>
              <div class="ea_person">
                <p id="refDepartmentSelect" onchange="loadRefUserName()">
                  준비중
                </p>
                <p id="refUserNameSelect">입니다.</p>
                <div id="addRefResult"></div>
              </div>
              <!-- //.ea_person-->
            </div>
            <!-- //#person2 -->
          </div>
          <!-- //#person_zone-->

          <div id="button_zone">
        
            <button type="button" id="admBtn" onclick="submitApproval()">승인</button>
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
     document.addEventListener('DOMContentLoaded', function () {
    // 부서 번호에 따라 한글 부서명으로 변환하는 함수
    function getDepartmentName(departmentNumber) {
        switch (departmentNumber) {
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
                return "알 수 없음";
        }
    }

    // 첫 번째 결재자 부서 번호 변환
    var departmentSelect1 = document.getElementById('departmentSelect1');
    if (departmentSelect1) {
        var departmentNumber1 = parseInt(departmentSelect1.innerText);
        departmentSelect1.innerText = getDepartmentName(departmentNumber1);
    }

    // 두 번째 결재자 부서 번호 변환
    var departmentSelect2 = document.getElementById('departmentSelect2');
    if (departmentSelect2) {
        var departmentNumber2 = parseInt(departmentSelect2.innerText);
        departmentSelect2.innerText = getDepartmentName(departmentNumber2);
    }

    function formatDate(dateString) {
        const parts = dateString.split(' ');
        return parts[0];
    }

    // 시작일 표시
    var startDateElement = document.getElementById('startDate');
    if (startDateElement) {
        var startDateText = startDateElement.innerText.trim();
        startDateElement.innerText = formatDate(startDateText);
        console.log("변환된 시작일:", startDateElement.innerText);
    }

    // 종료일 표시
    var endDateElement = document.getElementById('endDate');
    if (endDateElement) {
        var endDateText = endDateElement.innerText.trim();
        endDateElement.innerText = formatDate(endDateText);
        console.log("변환된 종료일:", endDateElement.innerText);
    }
});
      
     function submitApproval() {
    	 var aidx = ${lv.aidx};
    	 $.ajax({
    		    type: "POST",
    		    url: "<%=request.getContextPath()%>/ea/agreeApproval.do",
    		    contentType: "application/json",
    		    data: JSON.stringify({ aidx: aidx }),
    		    dataType: "text", // 데이터 타입을 명시적으로 text로 지정
    		    success: function(response) {
    		        if (response === "success") {
    		            alert("승인이 완료되었습니다.");
    		            // 성공했을 때의 동작 추가
    		        } else {
    		            alert("오류가 발생하였습니다. 오류 메시지: " + response);
    		            // 기타 오류 처리
    		        }
    		    },
    		    error: function(error) {
    		        console.error("AJAX 오류:", error);
    		    }
    		});
     }
    
    
    
    
    
    
    
    
      
   </script> 
    </main>
  </body>
</html>