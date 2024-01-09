package com.ezen.ezenhr.service;

import com.ezen.ezenhr.domain.UserVo;

public interface UserService {
	
	public int userInsert(UserVo uv);
	
	public int userIdCheck(String userId);
}
