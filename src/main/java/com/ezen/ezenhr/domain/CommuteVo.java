package com.ezen.ezenhr.domain;

import java.time.LocalDateTime;

public class CommuteVo {
	private int cidx;
	private LocalDateTime cInTime;
	private LocalDateTime cInOutTime;
	private String cInOrOut;
	private int uidx;
	private int didx;
	private String departmentName;
	private String ctype;
	
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
	public LocalDateTime getcInOutTime() {
		return cInOutTime;
	}
	public void setcInOutTime(LocalDateTime cInOutTime) {
		this.cInOutTime = cInOutTime;
	}
	public String getcInOrOut() {
		return cInOrOut;
	}
	public void setcInOrOut(String cInOrOut) {
		this.cInOrOut = cInOrOut;
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
