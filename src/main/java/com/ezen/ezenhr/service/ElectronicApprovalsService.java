package com.ezen.ezenhr.service;

import java.util.List;
import java.util.Map;

import com.ezen.ezenhr.domain.ElectronicApprovalsVo;

public interface ElectronicApprovalsService {
	public int insertElectronicApproval(ElectronicApprovalsVo eav);
	

	public List<Map<String, Object>> getEAListByApproverUidxWithAdate(int uidx);

}
