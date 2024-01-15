package com.ezen.ezenhr.service;

import java.util.List;

import com.ezen.ezenhr.domain.UserVo;

public interface UserService {
	
	public int userInsert(UserVo uv);
	
	public int userIdCheck(String uId);
	
	public UserVo userLogin(String uId, String uPwd);
	
	public UserVo userLogin(String uId);
	
	public UserVo getUserInfo(int uidx);
	
	public String getDepartmentName(int didx);
	
	public int getUserDepartmentId(int uidx);
	
	public List<UserVo> getUidxByDidx(int didx);
	
	public List<UserVo> getAllUsers();
}
