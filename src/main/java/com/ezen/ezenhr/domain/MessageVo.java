package com.ezen.ezenhr.domain;

public class MessageVo {
	private int midx;
	private int mSender;
	private int mReceiver;
	private String mContents;
	private String mSendTime;
	private int mReadStatus;
	private int uidx;
	
	public int getMidx() {
		return midx;
	}
	public void setMidx(int midx) {
		this.midx = midx;
	}
	public int getmSender() {
		return mSender;
	}
	public void setmSender(int mSender) {
		this.mSender = mSender;
	}
	public int getmReceiver() {
		return mReceiver;
	}
	public void setmReceiver(int mReceiver) {
		this.mReceiver = mReceiver;
	}
	public String getmContents() {
		return mContents;
	}
	public void setmContents(String mContents) {
		this.mContents = mContents;
	}
	public String getmSendTime() {
		return mSendTime;
	}
	public void setmSendTime(String mSendTime) {
		this.mSendTime = mSendTime;
	}
	public int getmReadStatus() {
		return mReadStatus;
	}
	public void setmReadStatus(int mReadStatus) {
		this.mReadStatus = mReadStatus;
	}
	public int getUidx() {
		return uidx;
	}
	public void setUidx(int uidx) {
		this.uidx = uidx;
	}
}
