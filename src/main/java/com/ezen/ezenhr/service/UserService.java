package com.ezen.ezenhr.service;

import com.ezen.ezenhr.domain.UserVo;

public interface UserService {
	
	public int userInsert(UserVo uv);
	
	public int userIdCheck(String uId);
	
	public UserVo userLogin(String uId, String uPwd);
	
	public UserVo userLogin(String uId);
}
