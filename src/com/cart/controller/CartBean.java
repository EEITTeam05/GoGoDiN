package com.cart.controller;

public class CartBean {
	private Integer qty;
	private String ProductName;
	private String Detailed;
	private Integer TktMoney;
	private Integer TktId;

	public Integer getQty() {
		return qty;
	}

	public void setQty(Integer qty) {
		this.qty = qty;
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

	public Integer getTktId() {
		return TktId;
	}

	public void setTktId(Integer tktId) {
		TktId = tktId;
	}

	public CartBean(int qty, String ProductName, String Detailed, int TktMoney, int TktId) {
		this.qty = qty;
		this.ProductName = ProductName;
		this.Detailed = Detailed;
		this.TktMoney = TktMoney;
		this.TktId = TktId;

	}

}