package com.ict.mytravellist.vo;

import java.time.LocalDateTime;

public class ReportVO {
    private String reportIdx;
    private String reporter;
    private String writer;
    private String reportContent;
    private String tourTalkIdx;
    private LocalDateTime reportreg;

    public ReportVO() {}

    public ReportVO(String reporter, String writer, String reportContent, String tourTalkIdx) {
        this.reporter = reporter;
        this.writer = writer;
        this.reportContent = reportContent;
        this.tourTalkIdx = tourTalkIdx;
        this.reportreg = LocalDateTime.now();
    }

	public String getReportIdx() {
		return reportIdx;
	}

	public void setReportIdx(String reportIdx) {
		this.reportIdx = reportIdx;
	}

	public String getReporter() {
		return reporter;
	}

	public void setReporter(String reporter) {
		this.reporter = reporter;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getReportContent() {
		return reportContent;
	}

	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}

	public String getTourTalkIdx() {
		return tourTalkIdx;
	}

	public void setTourTalkIdx(String tourTalkIdx) {
		this.tourTalkIdx = tourTalkIdx;
	}

	public LocalDateTime getReportreg() {
		return reportreg;
	}

	public void setReportreg(LocalDateTime reportreg) {
		this.reportreg = reportreg;
	}

    
    
}
