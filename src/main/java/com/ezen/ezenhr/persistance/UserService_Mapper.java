package com.ezen.ezenhr.persistance;

import java.util.HashMap;

import com.ezen.ezenhr.domain.UserVo;

public interface UserService_Mapper {
	
	public int userInsert(UserVo uv);

	public int userIdCheck(String uId);
	
	public UserVo userLogin(HashMap hm);
	
	public UserVo userLogin2(String uId);
	
	public UserVo getUserInfo(int uidx);
	
	public String getDepartmentName(int didx);
	
}
