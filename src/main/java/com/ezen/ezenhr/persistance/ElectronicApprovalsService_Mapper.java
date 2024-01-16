package com.ezen.ezenhr.persistance;

import java.util.List;

import com.ezen.ezenhr.domain.ElectronicApprovalsVo;

public interface ElectronicApprovalsService_Mapper {
	
	public int insertElectronicApproval(ElectronicApprovalsVo eav);
	
	public List<ElectronicApprovalsVo> getEAListByApproverUidx(int uidx);
	
	

}
