function login() {
            alert("로그인 버튼 클릭");
            let uId = document.getElementById('uId').value;
            alert("입력된 아이디는?" + uId);

            let fm = document.getElementById('loginForm');
			
            if (fm.uId.value == "") {
                alert("아이디를 입력해주세요.");
                fm.uId.focus();
                return;
            } else if (fm.uPwd.value == "") {
                alert("비밀번호를 입력해주세요");
                fm.uPwd.focus();
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

                loginBtn.onclick = function () {
                    loginModal.style.display = "block";
                };

                function closeModal() {
                   	document.getElementById("modalBackground").style.display = "none";
                    document.getElementById("loginModal").style.display = "none";
                }

                window.onclick = function (event) {
                    if (event.target == loginModal) {
                        loginModal.style.display = "none";
                    }
                };
        