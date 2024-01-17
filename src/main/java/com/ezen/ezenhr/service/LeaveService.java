package com.ezen.ezenhr.service;

import java.util.HashMap;

import com.ezen.ezenhr.domain.LeaveVo;

public interface LeaveService {
	
	public int leaveInsert(LeaveVo lv);
	
	public HashMap<String, Object> getLeaveDataWithUsernameByAidx(int aidx);
	
	public LeaveVo selectLeaveByAidx(int aidx);
	
	public int updateLeaveStatus(LeaveVo lv);

}
