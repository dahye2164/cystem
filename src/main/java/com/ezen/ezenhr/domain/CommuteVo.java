package com.ezen.ezenhr.domain;

import java.time.LocalDateTime;

public class CommuteVo {
	private int cidx;
	private LocalDateTime cInTime;
	private LocalDateTime cOutTime;
	private int uidx;
	private int didx;
	private String departmentName;
	private String ctype;
	private String actionType;
	
	public String getActionType() {
		return actionType;
	}
	public void setActionType(String actionType) {
		this.actionType = actionType;
	}
	public String getCtype() {
		return ctype;
	}
	public void setCtype(String ctype) {
		this.ctype = ctype;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public int getCidx() {
		return cidx;
	}
	public void setCidx(int cidx) {
		this.cidx = cidx;
	}
	public LocalDateTime getcInTime() {
		return cInTime;
	}
	public void setcInTime(LocalDateTime cInTime) {
		this.cInTime = cInTime;
	}
	
	public LocalDateTime getcOutTime() {
		return cOutTime;
	}
	public void setcOutTime(LocalDateTime cOutTime) {
		this.cOutTime = cOutTime;
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
