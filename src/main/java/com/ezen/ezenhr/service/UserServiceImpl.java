package com.ezen.ezenhr.service;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.ezenhr.domain.UserVo;
import com.ezen.ezenhr.persistance.UserService_Mapper;

@Service
public class UserServiceImpl implements UserService {

	private UserService_Mapper usm;
	
	@Autowired
	public UserServiceImpl(SqlSession sqlSession) {
		this.usm = sqlSession.getMapper(UserService_Mapper.class);
	}
	
	@Override
	public int userInsert(UserVo uv) {
		int value = usm.userInsert(uv);
		return value;
	}
	
	@Override
	public int userIdCheck(String uId) {
		int value = 0;
		value = usm.userIdCheck(uId);
		System.out.println(value+"<---- serviceImpl value");
		return value;
		
	}

	@Override
	public UserVo userLogin(String uId, String uPwd) {
		UserVo uv = null;
		
		HashMap<String,String> hm = new HashMap<String,String>();
		hm.put("uId", uId);
		hm.put("uPwd",uPwd);
		
		uv = usm.userLogin(hm);
		return uv;
	}

	@Override
	public UserVo userLogin(String uId) {
		UserVo uv = null;
		uv = usm.userLogin2(uId);
		
		return uv;
	}

	@Override
	public UserVo getUserInfo(int uidx) {
		UserVo uv = null;
		uv = usm.getUserInfo(uidx);
		
		return uv;
	}

	@Override
	public String getDepartmentName(int didx) {
		String value = "";
		value = usm.getDepartmentName(didx);
		
		return value;
	}
}
