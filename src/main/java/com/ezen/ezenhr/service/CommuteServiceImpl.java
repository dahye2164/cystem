package com.ezen.ezenhr.service;

import java.time.LocalDateTime;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.ezenhr.domain.CommuteVo;
import com.ezen.ezenhr.persistance.CommuteService_Mapper;

@Service
public class CommuteServiceImpl implements CommuteService {

	private CommuteService_Mapper csm;
	
	@Autowired
	public CommuteServiceImpl(SqlSession sqlSession) {
		this.csm = sqlSession.getMapper(CommuteService_Mapper.class);
	}
	
	@Override
	public CommuteVo saveSignInTime(int uidx, LocalDateTime signInTime) {
		CommuteVo cv = new CommuteVo();
		cv.setUidx(uidx);
		cv.setcInTime(signInTime);
		
		cv = csm.saveSignInTime(cv);
		
		return cv;
		
	}

}
