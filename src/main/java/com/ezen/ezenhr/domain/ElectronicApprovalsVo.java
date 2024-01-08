package com.ezen.ezenhr.domain;

public class ElectronicApprovalsVo {
	private int aidx;
	private String approvalStatus;
	private String aDate;
	private int uidx;
	private int approvalUidx;
	private int didx;
	
	public int getAidx() {
		return aidx;
	}
	public void setAidx(int aidx) {
		this.aidx = aidx;
	}
	public String getApprovalStatus() {
		return approvalStatus;
	}
	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}
	public String getaDate() {
		return aDate;
	}
	public void setaDate(String aDate) {
		this.aDate = aDate;
	}
	public int getUidx() {
		return uidx;
	}
	public void setUidx(int uidx) {
		this.uidx = uidx;
	}
	public int getApprovalUidx() {
		return approvalUidx;
	}
	public void setApprovalUidx(int approvalUidx) {
		this.approvalUidx = approvalUidx;
	}
	public int getDidx() {
		return didx;
	}
	public void setDidx(int didx) {
		this.didx = didx;
	}
}
