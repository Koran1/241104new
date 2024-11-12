package com.ict.mytravellist.vo;

import org.springframework.web.multipart.MultipartFile;

public class TourTalkVO {
	private String tourTalkIdx, userId, tourTalkContent, tourTalkReg, f_name, hit, active, old_f_name, travelIdx, trrsrtNm;
	private MultipartFile file_name;
	
	public String getTrrsrtNm() {
		return trrsrtNm;
	}
	public void setTrrsrtNm(String trrsrtNm) {
		this.trrsrtNm = trrsrtNm;
	}
	public String getTravelIdx() {
		return travelIdx;
	}
	public void setTravelIdx(String travelIdx) {
		this.travelIdx = travelIdx;
	}
	public String getTourTalkIdx() {
		return tourTalkIdx;
	}
	public void setTourTalkIdx(String tourTalkIdx) {
		this.tourTalkIdx = tourTalkIdx;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getTourTalkContent() {
		return tourTalkContent;
	}
	public void setTourTalkContent(String tourTalkContent) {
		this.tourTalkContent = tourTalkContent;
	}
	public String getTourTalkReg() {
		return tourTalkReg;
	}
	public void setTourTalkReg(String tourTalkReg) {
		this.tourTalkReg = tourTalkReg;
	}
	public String getF_name() {
		return f_name;
	}
	public void setF_name(String f_name) {
		this.f_name = f_name;
	}
	public String getHit() {
		return hit;
	}
	public void setHit(String hit) {
		this.hit = hit;
	}
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
	public String getOld_f_name() {
		return old_f_name;
	}
	public void setOld_f_name(String old_f_name) {
		this.old_f_name = old_f_name;
	}
	public MultipartFile getFile_name() {
		return file_name;
	}
	public void setFile_name(MultipartFile file_name) {
		this.file_name = file_name;
	}
	

}
