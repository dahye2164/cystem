package com.ezen.ezenhr.domain;

public class PageMaker {
	private SearchCriteria searchCriteria;
	private int page;
    private int perPageNum;
    private int totalCount;
    private int startPage;
    private int endPage;
    private boolean prev;
    private boolean next;
    
    public int getYear() {
        return searchCriteria.getYear();
    }

    public int getMonth() {
        return searchCriteria.getMonth();
    }

    public int getDay() {
        return searchCriteria.getDay();
    }
    
    public String getDepartmentName() {
        return searchCriteria.getDepartmentName();
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
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	
	public int getPageStart() {
        return (searchCriteria.getPage() - 1) * searchCriteria.getPerPageNum();
    }
	
	public PageMaker(SearchCriteria searchCriteria, int totalCount) {
        this.searchCriteria = searchCriteria; 
        this.totalCount = totalCount;

        this.endPage = (int) (Math.ceil(searchCriteria.getPage() / 10.0)) * 10;
        this.startPage = this.endPage - 9;

        int realEnd = (int) (Math.ceil((totalCount * 1.0) / searchCriteria.getPerPageNum()));

        if (realEnd < this.endPage) {
            this.endPage = realEnd;
        }

        this.prev = this.startPage > 1;
        this.next = this.endPage < realEnd;
    }
}
