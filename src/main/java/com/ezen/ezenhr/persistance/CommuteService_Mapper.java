package com.ezen.ezenhr.persistance;

import java.time.LocalDateTime;

import com.ezen.ezenhr.domain.CommuteInfoVo;
import com.ezen.ezenhr.domain.CommuteVo;

public interface CommuteService_Mapper {
	
	public int saveSignInTime(CommuteVo cv); 
	
	public int saveCommuteInfo(CommuteInfoVo civ);

    public CommuteVo saveSignOutTime(int uidx, LocalDateTime signOutTime);

	
}
