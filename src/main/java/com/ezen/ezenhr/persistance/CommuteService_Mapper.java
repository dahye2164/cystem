package com.ezen.ezenhr.persistance;

import java.time.LocalDateTime;
import java.util.List;

import com.ezen.ezenhr.domain.CommuteInfoVo;
import com.ezen.ezenhr.domain.CommuteVo;

public interface CommuteService_Mapper {
	
	public int saveSignInTime(CommuteVo cv); 
	
	/* public int saveCommuteInfo(CommuteInfoVo civ); */

    public int saveSignOutTime(CommuteVo cv);

	public CommuteVo getCommuteInfo(int uidx);

	public List<CommuteVo> getCommuteList(int uidx);

	public int updateSignInTime(CommuteVo cv);

	public int updateSignOutTime(CommuteVo cv);

	
}
