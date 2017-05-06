package com.ticket.model;

import com.rest.Model.RestVO;

public class TicketVO {
	private Integer TktId;
	private RestVO restVO;
	private String ProductName;	
	private String Detailed;	
	private Integer TktMoney;
	private byte[] TktImage;
	private String FileName;
	
	public Integer getTktId() {
		return TktId;
	}
	public void setTktId(Integer tktId) {
		TktId = tktId;
	}
	public RestVO getRestVO() {
		return restVO;
	}
	public void setRestVO(RestVO restVO) {
		this.restVO = restVO;
	}
	public String getProductName() {
		return ProductName;
	}
	public void setProductName(String productName) {
		ProductName = productName;
	}
	public String getDetailed() {
		return Detailed;
	}
	public void setDetailed(String detailed) {
		Detailed = detailed;
	}
	public Integer getTktMoney() {
		return TktMoney;
	}
	public void setTktMoney(Integer tktMoney) {
		TktMoney = tktMoney;
	}
	public byte[] getTktImage() {
		return TktImage;
	}
	public void setTktImage(byte[] tktImage) {
		TktImage = tktImage;
	}
	public String getFileName() {
		return FileName;
	}
	public void setFileName(String fileName) {
		this.FileName = fileName;
	}
	
	
	
	
}
