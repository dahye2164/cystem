function login() {
            alert("로그인 버튼 클릭");
            let userId = document.getElementById('userId').value;
            alert("입력된 아이디는?" + userId);

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
			fm.action = loginActionUrl;
			fm.method = "post";
            fm.submit();

            return;
        }
        
        	
                var loginModal = document.getElementById("loginModal");

          
                var loginBtn = document.getElementById("loginBtn");

            
                var closeLoginModal = document.getElementById("closeLoginModal");
                
                var closeModalBtn = document.getElementById("closeModalBtn");

                loginBtn.onclick = function () {
                    loginModal.style.display = "block";
                };

                function closeModal() {
                   	document.getElementById("modalBackground").style.display = "none";
                    document.getElementById("loginModal").style.display = "none";
                }

                 closeModalBtn.onclick = function() {
		            document.getElementById("modalBackground").style.display = "none";
		            document.getElementById("loginModal").style.display = "none";
		        }
        