package com.shop.Model;

public class ShopVO {
	private Integer ShopId;
	private String ShopAccount;
	private String ShopPswd;
	private String ShopName;
	private String ShopIdd;
	private String ShopTel;
	private String ShopEmail;
	private String SlineId;
	private byte[] ShopImage;
	private String fileName;
	private Integer Status;
	

	public byte[] getShopImage() {
		return ShopImage;
	}

	public void setShopImage(byte[] shopImage) {
		ShopImage = shopImage;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Integer getShopId() {
		return ShopId;
	}

	public void setShopId(Integer shopId) {
		ShopId = shopId;
	}

	public String getShopAccount() {
		return ShopAccount;
	}


	public Integer getStatus() {
		return Status;
	}

	public void setStatus(Integer status) {
		Status = status;
	}

	public void setShopAccount(String shopAccount) {
		ShopAccount = shopAccount;
	}

	public String getShopPswd() {
		return ShopPswd;
	}

	public void setShopPswd(String shopPswd) {
		ShopPswd = shopPswd;
	}

	public String getShopName() {
		return ShopName;
	}

	public void setShopName(String shopName) {
		ShopName = shopName;
	}

	public String getShopIdd() {
		return ShopIdd;
	}
	
	public void setShopIdd(String shopIdd) {
		ShopIdd = shopIdd;
	}
	
	public String getShopTel() {
		return ShopTel;
	}

	public void setShopTel(String shopTel) {
		ShopTel = shopTel;
	}

	public String getShopEmail() {
		return ShopEmail;
	}

	public void setShopEmail(String shopEmail) {
		ShopEmail = shopEmail;
	}

	public String getSlineId() {
		return SlineId;
	}

	public void setSlineId(String slineId) {
		SlineId = slineId;
	}

}
