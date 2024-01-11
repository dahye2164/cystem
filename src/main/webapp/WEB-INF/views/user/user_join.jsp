<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
    <head>

        <meta charset="UTF-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link rel="shortcut icon" href="images/favicon.png"/>
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css"/>
        <link rel="stylesheet" href="${path }/resources/css/reset.css"/>
        <link rel="stylesheet" href="${path }/resources/css/join_form.css"/>
        <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
        <!--swiper plugin connect-->
        <script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
        <title>Ezen HR</title>

        <script type="text/javascript">
        function check() {
            let uId = document.signupForm.uId.value;
            alert("입력된 아이디는?" + uId);

            var fm = document.signupForm;

            if (fm.uId.value == "") {
                alert("아이디를 입력하세요");
                fm.uId.focus();
                return;
            } else if (fm.uPwd.value == "") {
                alert("비밀번호를 입력해주세요");
                fm.uPwd.focus();
                return;
            } else if (fm.uPwdConfirm.value == "") {
                alert("비밀번호 확인을 입력해주세요");
                fm.uPwdConfirm.focus();
                return;
            } else if (fm.uPwd.value != fm.uPwdConfirm.value) {
                alert("비밀번호가 일치하지 않습니다.");
                fm.uPwd.value = "";
                fm.uPwdConfirm.value = "";
                fm.uPwd.focus();
                return;
            } else if (fm.uName.value == "") {
                alert("사용자 이름을 입력해주세요");
                fm.uName.focus();
                return;
            } else if (fm.uGrade.selectedIndex === 0) {
                alert("직급을 선택하세요");
                fm.uGrade.focus();
                return;
            } else if (fm.didx.selectedIndex === 0) {
                alert("부서를 선택하세요");
                fm.didx.focus();
                return;
            } else if (fm.uHireDate.value == "") {
                alert("입사일을 입력해주세요");
                fm.uHireDate.focus();
                return;
            } else if (fm.uPhone.value == "") {
                alert("핸드폰 번호를 입력해주세요");
                fm.uPhone.focus();
                return;
            }

            // 아이디 중복 체크
            if (checkDupl() != true) {
            	alert("아이디 중복체크를 해주세요.");
            	obj = fm.uId.value();
            	var flag = blurId(obj);
            	if (flag == false) {
            		alert("");
            		return;
            	}
            }

            alert("회원가입이 완료 되었습니다. 로그인 해주세요!");
            fm.action = "<%=request.getContextPath()%>/user/userJoinAction.do";
            fm.method = "post";
            fm.submit();
            
            return;
        }
        
        var validationFlag = false;
        var validationIdVal = "";

        function validation() {
            var uId = $("#uId").val();
            console.log(uId);

              $.ajax({
                    type: "post",
                    url: "<%=request.getContextPath()%>/user/userIdCheck.do",
                    data: {uId: uId},
                    dataType: "json",  // 데이터 타입을 JSON으로 명시
                    success : function(data) {
                    	console.log(data + "<---data 값"); // 데이터 출력
                    	if(uId != "") {
                    		if(data.value == "1") { // data.value로 json형식의 값에대해 접근했음 - 건
                    			alert("사용중인 아이디 입니다.");
                    			validationFlag = false;
                    			validationIdval = "";
                    		} else {
                    			alert("사용 가능한 아이디 입니다.");
                    			validationFlag = true;
                    			validationIdval = uId;
                    		}
                    	} else {
                    		alert("아이디는 공백일 수 없습니다");
                    	}
                    }
                });
        }
       
      
        function checkDupl(){
    		if(validationFlag == false) { // 위 함수의 validationFlag 변수를 기준으로 조건식을 세움. 위에서 false값이면 아이디가 있다는 뜻이니까?
    			return false; //false로 막는다.
    		} else if($("#uId").val() == "") { // name이 id인 값을 불러와 공백이라면 
    			return false; //false로 막는다.
    		} else {
    			return true; //위의 두 경우가 모두 조건에 성립하지 않으면 통과.
    		}
    	}
    	
    	function blurId(obj) { //blurId(obj), 여기서 obj는 사용자가 입력한 id값(this)
    		var val = obj.value; //사용자가 입력한 id값을 val 변수에 할당
    		
    		
    		//기준점. false
    		if(validationFlag && val != validationIdVal) { //블러를 했을때 중복확인을 했는지 안했는지 처리해주는 부분.
    			//해석 : validationFlag가 true 이면서(엔드) val의 값이 기존에 입력했던 값과 일치하는가?
    			validationFlag = false; //일치하지 않는다면 역시나 false.
    		}
    	}
        
    	function chkCharCode(event) {
    		  const regExp = /[^0-9a-zA-Z]/g;
    		  const ele = event.target;
    		  if (regExp.test(ele.value)) {
    		    ele.value = ele.value.replace(regExp, '');
    		  }
    		};
    	
    	    document.addEventListener("DOMContentLoaded", function () {
                document.getElementById("uPhone").addEventListener("input", function (event) {
                    var inputValue = event.target.value;
                    var filteredValue = filterSpecialCharacters(inputValue);
                    event.target.value = filteredValue;
                });
            });

            function filterSpecialCharacters(input) {
                // 원하는 문자 패턴으로 정규식을 수정할 수 있습니다.
                const regex = /[^0-9]/g;
                return input.replace(regex, '');
            }
		
         // 비밀번호 숨김/보이기 토글 함수
            function togglePassword(id) {
			    const passwordInput = document.getElementById(id);
				
			    console.log(passwordInput + "현재 passwordInput");
			    // type 속성을 변경하여 숨김에서 보이기로, 또는 그 반대로 전환
			    passwordInput.type = (passwordInput.type === 'password') ? 'text' : 'password';
				console.log(passwordInput.type + "<---- 패스워드 input type (현재 상태)")
			    // 이미지를 번갈아가면서 변경
			    //const imgElement = passwordInput.nextElementSibling.querySelector('.toggle-password');
				const imgElement = document.getElementById('toggle-password');
				console.log(imgElement + "<--- 이미지 element 값")
				
			    imgElement.src = (passwordInput.type === 'password') ? '../resources/images/close_eyes.PNG' : '../resources/images/open_eyes.PNG';
				
				console.log(imgElement.src + "이미지 엘리먼트 src");
			}
         
            document.addEventListener('DOMContentLoaded', function () {
                // 이곳에 JavaScript 코드를 넣으세요.
            
         // 비밀번호 확인 input 요소
            const passwordConfirmInput = document.getElementById('uPwdConfirm');
         	console.log(passwordConfirmInput + "<-- 패스워드 확인")
            // 비밀번호 일치 상태를 보여줄 이미지를 넣을 요소
            const passwordMatchStatus = document.getElementById('passwordMatchStatus');
         	console.log(passwordMatchStatus + "<-- 패스워드 일치?")

            // 비밀번호 확인 input이 변경될 때마다 호출되는 함수
            passwordConfirmInput.addEventListener('input', function () {
                const passwordInput = document.getElementById('uPwd');
                const passwordMatch = passwordInput.value === passwordConfirmInput.value;

                // 비밀번호 일치 여부에 따라 이미지를 추가하거나 제거
                if (passwordMatch) {
                    showPasswordMatchStatus(true);
                } else {
                    showPasswordMatchStatus(false);
                }
            });

            // 비밀번호 일치 여부에 따라 이미지를 추가하거나 제거하는 함수
            function showPasswordMatchStatus(match) {
            	if (match) {
                    passwordMatchStatus.innerHTML = '<i class="xi-check"></i>';
                } else {
                    passwordMatchStatus.innerHTML = '<i class="xi-close"></i>';
                }
            }
           });
        
        </script>
    </head>
    <body>
    	<%@include file="../include/header.jsp"%>
        
        <div class="container">
            <h2>ezenHR 회원가입</h2>
            <form name="signupForm">
            
                <div class="form-group">
			        <label for="username">아이디</label>
			        <div class="input-with-button">
			            <input type="text" id="uId" name="uId" placeholder="영어와 숫자만 입력가능합니다." onkeyup="chkCharCode(event)" required>
			            <input type="button" name="btn" id="btn" value="중복체크" onclick="validation();">
			        </div>
			    </div>
			
			    <!-- 비밀번호 입력 폼 -->
				<div class="form-group password-container">
				    <label class="password-label" for="uPwd">비밀번호</label>
				    <div class="input-container">
				        <input type="password" id="uPwd" name="uPwd" placeholder="비밀번호를 입력해주세요." required> 
				        <img class="toggle-password" id="toggle-password" src="../resources/images/close_eyes.PNG" alt="Toggle Password" onclick="togglePassword('uPwd')">
				    </div>
				</div>

				<!-- 비밀번호 확인 입력 폼 -->
			    <div class="form-group">
			        <label for="confirmPassword">비밀번호 확인</label>
			        <div class="input-container">
			        <input type="password" id="uPwdConfirm" name="uPwdConfirm" placeholder="비밀번호를 다시한번 더 입력해주세요." required>
			        <div class="password-match-status" id="passwordMatchStatus"></div>
			        </div>
			    </div>
			
			    <div class="form-group">
			        <label for="name">이름</label>
			        <input type="text" id="uName" name="uName" placeholder="이름을 입력해주세요." required>
			    </div>
			
			    <!-- 핸드폰번호 유효성 검사 진행중 -->
			    <div class="form-group">
			        <label for="uPhone">핸드폰번호</label>
			        <input type="text" id="uPhone" name="uPhone" placeholder="숫자만 입력가능합니다." required>
			    </div>
			    
				<div class="form-group">
					<label for="uHireDate">입사일</label>
						<input type="date" id="uHireDate" name="uHireDate" required="required">
				</div>

			<div class="form-group">
                    <label for="position">직급</label>
                    <select id="position" name="uGrade" required="required">
                        <option value="" disabled="disabled" selected="selected">선택하세요</option>
                        <option value="신입사원">신입사원</option>
                        <option value="대리">대리</option>
                        <option value="과장">과장</option>
                        <option value="차장">차장</option>
                        <option value="부장">부장</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="didx">부서</label>
                    <select id="didx" name="didx" required="required">
                        <option value="" disabled="disabled" selected="selected">선택하세요</option>
                        <option value="1">기획부</option>
                        <option value="2">개발부</option>
                        <option value="3">영업부</option>
                        <option value="4">인사부</option>
                        <option value="5">총무부</option>
                    </select>
                </div>

                <div class="form-buttons">
                    <input type="button" name="btn" id = "submitBtn" class="submitBtn" value="가입하기" onclick="check();">
                    <button type="reset">취소</button>
                </div>
            </form>
        </div>
		
    </body>
</html>