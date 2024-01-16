package com.ezen.ezenhr.service;

import java.time.LocalDateTime;
import java.util.List;

import com.ezen.ezenhr.domain.CommuteInfoVo;
import com.ezen.ezenhr.domain.CommuteVo;
import com.ezen.ezenhr.domain.SearchCriteria;

public interface CommuteService {
	
	public int saveSignInTime(CommuteVo cv);
	
	public int saveSignOutTime(CommuteVo cv);

	public CommuteVo getCommuteInfo(int uidx);

	public List<CommuteVo> getCommuteList(int uidx);

	public int updateCommuteTime(CommuteVo cv);

	public List<CommuteVo> getDayCommuteListByDate(int year, int month, int day);

	public List<CommuteVo> getDayCommuteListByDateAndDepartment(int year, int month, int day, String department);

	public List<CommuteVo> getDayCommuteListByDateAndDepartmentWithPaging(SearchCriteria scri);

	public int getDayCommuteListCount(SearchCriteria scri);


}
