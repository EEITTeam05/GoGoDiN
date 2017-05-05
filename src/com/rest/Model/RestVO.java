package com.rest.Model;

import java.io.Serializable;
import java.sql.Blob;
import java.sql.Date;
import java.sql.Time;

public class RestVO implements Serializable{
	private Integer RestId;
	private Integer ShopId;
	private String RestName;
	private String RestTel;
	private String Restaddr;
	private Integer Ein;
	private Time RestStart;
	private Time RestEnd;
	private Integer RestRate;
	private Integer RestNum;
	private byte[] RestImage;
	private String fileName;
	private String brief;
	private Integer status;
	private Integer money;
	
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getMoney() {
		return money;
	}
	public void setMoney(Integer money) {
		this.money = money;
	}
	public Integer getRestId() {
		return RestId;
	}
	public void setRestId(Integer restId) {
		RestId = restId;
	}
	public Integer getShopId() {
		return ShopId;
	}
	public void setShopId(Integer shopId) {
		ShopId = shopId;
	}
	public String getRestName() {
		return RestName;
	}
	public void setRestName(String restName) {
		RestName = restName;
	}
	public String getRestTel() {
		return RestTel;
	}
	public void setRestTel(String restTel) {
		RestTel = restTel;
	}
	public String getRestaddr() {
		return Restaddr;
	}
	public void setRestaddr(String restaddr) {
		Restaddr = restaddr;
	}
	public Integer getEin() {
		return Ein;
	}
	public void setEin(Integer ein) {
		Ein = ein;
	}
	public Time getRestStart() {
		return RestStart;
	}
	public void setRestStart(Time restStart) {
		RestStart = restStart;
	}
	public Time getRestEnd() {
		return RestEnd;
	}
	public void setRestEnd(Time restEnd) {
		RestEnd = restEnd;
	}
	public Integer getRestRate() {
		return RestRate;
	}
	public void setRestRate(Integer restRate) {
		RestRate = restRate;
	}
	public Integer getRestNum() {
		return RestNum;
	}
	public void setRestNum(Integer restNum) {
		RestNum = restNum;
	}
	public byte[] getRestImage() {
		return RestImage;
	}
	public void setRestImage(byte[] restImage) {
		RestImage = restImage;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getBrief() {
		return brief;
	}
	public void setBrief(String brief) {
		this.brief = brief;
	}
}
