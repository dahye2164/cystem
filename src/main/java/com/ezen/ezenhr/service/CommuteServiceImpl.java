package com.ezen.ezenhr.service;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.ezenhr.domain.CommuteInfoVo;
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
	public int saveSignInTime(CommuteVo cv) {
		int value = csm.saveSignInTime(cv);
		
		return value;
		
	}

	@Override
	public int saveSignOutTime(CommuteVo cv) {
		int value = csm.saveSignOutTime(cv);
		
		return value;
	}

	@Override
	public CommuteVo getCommuteInfo(int uidx) {
		CommuteVo cv = csm.getCommuteInfo(uidx);
		
		return cv;
	}

	@Override
	public List<CommuteVo> getCommuteList(int uidx) {
		List<CommuteVo> commuteList = csm.getCommuteList(uidx);
		return commuteList;
	}

	/*
	 * @Override public int saveCommuteInfo(CommuteInfoVo civ) { int value2 =
	 * csm.saveCommuteInfo(civ);
	 * 
	 * return value2; }
	 */

	

}
