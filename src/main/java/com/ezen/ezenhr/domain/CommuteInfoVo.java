package com.ezen.ezenhr.domain;

import java.sql.Date;
import java.time.LocalDate;

public class CommuteInfoVo {
	
	private int ciidx;
	private int uidx;
	private int cidx;
	private String cType;
	private LocalDate cDate;
	
	
	public int getCiidx() {
		return ciidx;
	}
	public void setCiidx(int ciidx) {
		this.ciidx = ciidx;
	}
	public int getUidx() {
		return uidx;
	}
	public void setUidx(int uidx) {
		this.uidx = uidx;
	}
	public int getCidx() {
		return cidx;
	}
	public void setCidx(int cidx) {
		this.cidx = cidx;
	}
	public String getcType() {
		return cType;
	}
	public void setcType(String cType) {
		this.cType = cType;
	}
	public LocalDate getcDate() {
		return cDate;
	}
	public void setcDate(LocalDate cDate) {
		this.cDate = cDate;
	}


}
