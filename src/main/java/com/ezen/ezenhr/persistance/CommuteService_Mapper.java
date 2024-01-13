package com.ezen.ezenhr.persistance;

import java.time.LocalDateTime;

import com.ezen.ezenhr.domain.CommuteVo;

public interface CommuteService_Mapper {
	
	public CommuteVo saveSignInTime(CommuteVo cv);

    public CommuteVo saveSignOutTime(int uidx, LocalDateTime signOutTime);

	
}
