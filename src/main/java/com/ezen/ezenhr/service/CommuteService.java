package com.ezen.ezenhr.service;

import java.time.LocalDateTime;

import com.ezen.ezenhr.domain.CommuteInfoVo;
import com.ezen.ezenhr.domain.CommuteVo;

public interface CommuteService {
	
	public int saveSignInTime(CommuteVo cv);
	
	public int saveSignOutTime(CommuteVo cv);

	

}
