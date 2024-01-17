<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ezen.ezenhr.domain.UserVo" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" href="images/favicon.png" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <link rel="stylesheet" href="${path }/resources/css/reset.css"/>
    <link rel="stylesheet" href="${path }/resources/css/employee_management/employee_day_manage2.css"/>
    <link rel="stylesheet" href="${path }/resources/css/employee_management/employee_info_management.css"/>
    <title>사원정보관리</title>
</head>
<body>
   
   <%@include file="../include/header.jsp"%>
   <button onclick="toggleSidebar()" id="sideBtn"><i class="xi-bars"></i></button>
   
   <div class="sidebar" id="sidebar">
        <ul>
            <li><a class="side_link" href="<%=request.getContextPath() %>/commute/dayCommuteManagement.do">일일근태조회</a></li>
            <li><a class="side_link" href="<%=request.getContextPath()%>/ea/eaList.do">상세근태조회</a></li>
            <li><a class="side_link" href="<%=request.getContextPath()%>/ea/eaAdminList.do" >전체휴가조회</a></li>
            <li><a class="side_link" href="#">상세휴가조회</a></li>
            <li><a class="side_link" href="/user/userInfoManage.do" style="color:#fff; background-color: #4682B4;">사원정보관리</a></li>
        </ul>
    </div>
	<main>
		<h2>사원정보관리</h2>
        <div id="info">
            <p>해당 사원의 부서, 직급, 사원번호, 결재권한 수정 후 변경하기 버튼을 누르면 수정됩니다.<br/>
                체크박스 체크 후, 삭제하기 버튼을 누르면 해당 사원 아이디가 영구 삭제됩니다.</p>
            <button class="delete">삭제하기</button>
        </div>
        <div id="main_zone">
            <div id="hign_zone">
                <table id="main_table">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="checkAll"></th>
                            <th>부서</th>
                            <th>직급</th>
                            <th>직원명</th>
                            <th>아이디</th>
                            <th>사원번호</th>
                            <th>입사일</th>
                            <th>결재권한</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 사용자 데이터를 반복해서 출력 -->
                        <c:forEach var="user" items="${userList}" varStatus="loop">
                             <tr data-user-id="${user.uId}">
                                <td><input type="checkbox" class="checkbox"></td>
                                <td>
                                    <select class="departmentSelect" data-rowindex="${loop.index}">
                                        <option value="" disabled="disabled" selected="selected">선택하세요</option>
                                        <option value="1" selected>기획부</option>
                                        <option value="2">개발부</option>
                                        <option value="3">영업부</option>
                                        <option value="4">인사부</option>
                                        <option value="5">총무부</option>
                                    </select>
                                </td>
                                <td>
                                    <select class="positionSelect" data-rowindex="${loop.index}">
                                        <option value="" disabled="disabled" selected="selected">선택하세요</option>
				                        <option value="신입사원">신입사원</option>
				                        <option value="대리">대리</option>
				                        <option value="과장">과장</option>
				                        <option value="차장">차장</option>
				                        <option value="부장">부장</option>
                                    </select>
                                </td>
                                <td>${user.uName}</td>
                                <td>${user.uId}</td>
                                <td>${user.uidx}</td>
                                <td>${user.uHireDate.substring(0, 10)}</td>
                                <td>
                                    <select class="approvalSelect" data-rowindex="${loop.index}">
                                        <option value="" disabled="disabled" selected="selected">선택하세요</option>
                                        <option value="0" selected>0</option>
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                    </select>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div id="bottomButton">
                    <button class="edit" onclick="editUser()">수정하기</button>
                    <a href="${path }"><button class="cancel">돌아가기</button></a>  
                </div>
            </div>
        </div>
	</main>
	<script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('active');
        }

        function editUser() {
            const selectedRows = document.querySelectorAll('.checkbox:checked');

            // 선택된 행이 없으면 아무것도 하지 않음
            if (selectedRows.length === 0) {
                alert('수정할 행을 선택하세요.');
                return;
            }

            // 선택된 행의 데이터를 가져와 서버로 전송
            const userUpdateRequests = [];

            selectedRows.forEach(function (row) {
                const userId = row.getAttribute('data-user-id');
                const department = document.querySelector('tr[data-user-id="${userId}"] .departmentSelect').value;
                const position = document.querySelector('tr[data-user-id="${userId}"] .positionSelect').value;
                const approval = document.querySelector('tr[data-user-id="${userId}"] .approvalSelect').value;

                userUpdateRequests.push({
                    userId: userId,
                    department: department,
                    position: position,
                    approval: approval
                });
            });

            // 서버로 데이터를 전송하는 Ajax 요청
            $.ajax({
                type: 'POST',
                url: '<%=request.getContextPath()%>/user/updateUsers',
                contentType: 'application/json',
                data: JSON.stringify(userUpdateRequests),
                success: function(data) {
                    // 성공 시 메시지를 SweetAlert2로 변경
                    Swal.fire({
                        title: '수정 성공',
                        text: '데이터 수정이 성공적으로 완료되었습니다.',
                        icon: 'success',
                        showConfirmButton: false,
                        timer: 1500
                    });
                },
                error: function(error) {
                    // 서버 오류 메시지를 SweetAlert2로 변경
                    Swal.fire({
                        title: '서버 오류',
                        text: '서버 오류가 발생했습니다.',
                        icon: 'error',
                        showConfirmButton: false,
                        timer: 1500
                    });
                    console.error('Error:', error);
                }
            });
        }
        
        document.getElementById('checkAll').addEventListener('change', function () {
            const checkboxes = document.querySelectorAll('.checkbox');
            checkboxes.forEach(function (checkbox) {
                checkbox.checked = this.checked;
            }.bind(this));
        });
    </script>
</body>
</html>