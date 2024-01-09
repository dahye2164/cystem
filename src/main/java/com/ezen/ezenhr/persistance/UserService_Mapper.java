package com.ezen.ezenhr.persistance;

import com.ezen.ezenhr.domain.UserVo;

public interface UserService_Mapper {
	
	public int userInsert(UserVo uv);

	public int userIdCheck(String userId);
	
}
