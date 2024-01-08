package com.ezen.ezenhr.domain;

public class CommuteVo {
	private int cidx;
	private String cInOutTime;
	private String cInOrOut;
	private String cDate;
	private int uidx;
	private int didx;
	
	public int getCidx() {
		return cidx;
	}
	public void setCidx(int cidx) {
		this.cidx = cidx;
	}
	public String getcInOutTime() {
		return cInOutTime;
	}
	public void setcInOutTime(String cInOutTime) {
		this.cInOutTime = cInOutTime;
	}
	public String getcInOrOut() {
		return cInOrOut;
	}
	public void setcInOrOut(String cInOrOut) {
		this.cInOrOut = cInOrOut;
	}
	public String getcDate() {
		return cDate;
	}
	public void setcDate(String cDate) {
		this.cDate = cDate;
	}
	public int getUidx() {
		return uidx;
	}
	public void setUidx(int uidx) {
		this.uidx = uidx;
	}
	public int getDidx() {
		return didx;
	}
	public void setDidx(int didx) {
		this.didx = didx;
	}
}
