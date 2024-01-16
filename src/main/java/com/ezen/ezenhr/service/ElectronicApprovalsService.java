package com.ezen.ezenhr.service;

import java.util.List;

import com.ezen.ezenhr.domain.ElectronicApprovalsVo;

public interface ElectronicApprovalsService {
	public int insertElectronicApproval(ElectronicApprovalsVo eav);
	
	public List<ElectronicApprovalsVo> getEAListByApproverUidx(int uidx);

}
