package com.ezen.ezenhr.persistance;

import java.time.LocalDateTime;
import java.util.List;

import com.ezen.ezenhr.domain.CommuteInfoVo;
import com.ezen.ezenhr.domain.CommuteVo;
import com.ezen.ezenhr.domain.SearchCriteria;

import org.apache.ibatis.annotations.Param; // 반드시 추가해야 합니다.



public interface CommuteService_Mapper {
	
	public int saveSignInTime(CommuteVo cv); 
	
	/* public int saveCommuteInfo(CommuteInfoVo civ); */

    public int saveSignOutTime(CommuteVo cv);

	public CommuteVo getCommuteInfo(int uidx);

	public List<CommuteVo> getCommuteList(int uidx);

	public int updateSignInTime(CommuteVo cv);

	public int updateSignOutTime(CommuteVo cv);

	public List<CommuteVo> getDayCommuteListByDate(@Param("year") int year, @Param("month") int month, @Param("day") int day);

	public List<CommuteVo> getDayCommuteListByDateAndDepartment(
		    @Param("year") int year, 
		    @Param("month") int month, 
		    @Param("day") int day, 
		    @Param("departmentName") String departmentName
		);

	public int getDayCommuteListCount(SearchCriteria scri);

	public List<CommuteVo> getDayCommuteListByDateAndDepartmentWithPaging(SearchCriteria scri);

	
}
