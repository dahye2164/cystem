package com.ezen.ezenhr.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.ezenhr.domain.LeaveVo;
import com.ezen.ezenhr.persistance.LeaveService_Mapper;

@Service
public class LeaveServiceImpl implements LeaveService {
	
	private LeaveService_Mapper lsm;

	@Autowired
	public LeaveServiceImpl(SqlSession sqlSession) {
		this.lsm=sqlSession.getMapper(LeaveService_Mapper.class);
	}
	
	
	@Override
	public int leaveInsert(LeaveVo lv) {
		int value = lsm.leaveInsert(lv);
		return value;
	}

}
