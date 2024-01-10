package com.ezen.ezenhr.service;

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
}
