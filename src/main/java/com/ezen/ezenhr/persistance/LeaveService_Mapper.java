package com.ezen.ezenhr.persistance;

import java.util.HashMap;

import com.ezen.ezenhr.domain.LeaveVo;

public interface LeaveService_Mapper {
	
	public int leaveInsert(LeaveVo lv);
	
	public HashMap<String, Object> getLeaveDataWithUsernameByAidx(int aidx);

}
