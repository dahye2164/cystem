package com.ezen.ezenhr.service;

import java.time.LocalDateTime;

import com.ezen.ezenhr.domain.CommuteVo;

public interface CommuteService {
	
	public CommuteVo saveSignInTime(int uidx, LocalDateTime signInTime); 

}
