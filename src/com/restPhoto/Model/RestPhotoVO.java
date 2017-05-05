package com.restPhoto.Model;

import java.io.Serializable;

public class RestPhotoVO implements Serializable {
	private Integer RePhotoId;
	private Integer RestId;
	
	private byte[] RestImage1;
	private String fileName1;
	
	private byte[] RestImage2;
	private String fileName2;
	
	private byte[] RestImage3;
	private String fileName3;
	
	
	public Integer getRePhotoId() {
		return RePhotoId;
	}
	public void setRePhotoId(Integer rePhotoId) {
		RePhotoId = rePhotoId;
	}
	public Integer getRestId() {
		return RestId;
	}
	public void setRestId(Integer restId) {
		RestId = restId;
	}
	public byte[] getRestImage1() {
		return RestImage1;
	}
	public void setRestImage1(byte[] restImage1) {
		RestImage1 = restImage1;
	}
	public String getFileName1() {
		return fileName1;
	}
	public void setFileName1(String fileName1) {
		this.fileName1 = fileName1;
	}
	public byte[] getRestImage2() {
		return RestImage2;
	}
	public void setRestImage2(byte[] restImage2) {
		RestImage2 = restImage2;
	}
	public String getFileName2() {
		return fileName2;
	}
	public void setFileName2(String fileName2) {
		this.fileName2 = fileName2;
	}
	public byte[] getRestImage3() {
		return RestImage3;
	}
	public void setRestImage3(byte[] restImage3) {
		RestImage3 = restImage3;
	}
	public String getFileName3() {
		return fileName3;
	}
	public void setFileName3(String fileName3) {
		this.fileName3 = fileName3;
	}
}
