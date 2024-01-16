package com.ezen.ezenhr.persistance;

import java.util.List;
import java.util.Map;

import com.ezen.ezenhr.domain.ElectronicApprovalsVo;

public interface ElectronicApprovalsService_Mapper {
	
	public int insertElectronicApproval(ElectronicApprovalsVo eav);
	
	public List<Map<String, Object>> getEAListByApproverUidxWithAdate(int uidx) ;
	
	

}
