package com.ezen.ezenhr.domain;

public class ElectronicApprovalsVo {
	private int aidx;
	private String approvalStatus;
	private String aDate;
	private int uidx;
	private int approvalUidx1;
	private int approvalUidx2;
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
	
	public int getApprovalUidx1() {
		return approvalUidx1;
	}
	public void setApprovalUidx1(int approvalUidx1) {
		this.approvalUidx1 = approvalUidx1;
	}
	public int getApprovalUidx2() {
		return approvalUidx2;
	}
	public void setApprovalUidx2(int approvalUidx2) {
		this.approvalUidx2 = approvalUidx2;
	}
	public int getDidx() {
		return didx;
	}
	public void setDidx(int didx) {
		this.didx = didx;
	}
}
