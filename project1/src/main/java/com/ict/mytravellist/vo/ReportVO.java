package com.ict.mytravellist.vo;

import java.time.LocalDateTime;

public class ReportVO {
    private int reportIdx;
    private String reporter;
    private String reportedUser;
    private String reportContent;
    private int tourTalkIdx;
    private LocalDateTime reportreg;

    public ReportVO() {}

    public ReportVO(String reporter, String reportedUser, String reportContent, int tourTalkIdx) {
        this.reporter = reporter;
        this.reportedUser = reportedUser;
        this.reportContent = reportContent;
        this.tourTalkIdx = tourTalkIdx;
        this.reportreg = LocalDateTime.now();
    }

	public int getReportIdx() {
		return reportIdx;
	}

	public void setReportIdx(int reportIdx) {
		this.reportIdx = reportIdx;
	}

	public String getReporter() {
		return reporter;
	}

	public void setReporter(String reporter) {
		this.reporter = reporter;
	}

	public String getReportedUser() {
		return reportedUser;
	}

	public void setReportedUser(String reportedUser) {
		this.reportedUser = reportedUser;
	}

	public String getReportContent() {
		return reportContent;
	}

	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}

	public int getTourTalkIdx() {
		return tourTalkIdx;
	}

	public void setTourTalkIdx(int tourTalkIdx) {
		this.tourTalkIdx = tourTalkIdx;
	}

	public LocalDateTime getReportreg() {
		return reportreg;
	}

	public void setReportreg(LocalDateTime reportreg) {
		this.reportreg = reportreg;
	}

    
    
}
