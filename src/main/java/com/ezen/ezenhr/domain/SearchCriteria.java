package com.ezen.ezenhr.domain;

public class SearchCriteria {
	private int page;          // 현재 페이지 번호
    private int perPageNum;    // 페이지당 보여줄 항목 수

    private int year;           // 검색 조건: 년도
    private int month;          // 검색 조건: 월
    private int day;            // 검색 조건: 일
    private String departmentName;  // 검색 조건: 부서명

    public SearchCriteria() {
        this.page = 1;         // 기본값으로 1페이지를 보여줌
        this.perPageNum = 13;   // 페이지당 13개 항목을 보여줌
    }
    
    public int getPageStart() {
        return (this.page - 1) * this.perPageNum;
    }

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		this.perPageNum = perPageNum;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	
	@Override
	public String toString() {
	    return "SearchCriteria [page=" + page + ", perPageNum=" + perPageNum + ", year=" + year
	            + ", month=" + month + ", day=" + day + ", departmentName=" + departmentName + "]";
	}
}
