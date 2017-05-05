package com.order.Model;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Calendar;

import com.member.Model.MemberListVO;
import com.rest.Model.RestVO;

public class OrderVO {
	private Integer OrderNum;
	private MemberListVO memVO;
	private Integer ShopId;
	private RestVO restVO;
	private Date OrderDate;
	private Time OrderTime;
	private Integer Pnum;
	private Timestamp BidTime;
	private Boolean isRate;
	private Integer Rate;

	public Integer getRate() {
		return Rate;
	}
	public void setRate(Integer rate) {
		Rate = rate;
	}
	public Boolean getIsRate() {
		return isRate;
	}
	public void setIsRate(Boolean isRate) {
		this.isRate = isRate;
	}
	public Integer getOrderNum() {
		return OrderNum;
	}
	public void setOrderNum(Integer orderNum) {
		OrderNum = orderNum;
	}
	public Integer getShopId() {
		return ShopId;
	}
	public void setShopId(Integer shopId) {
		ShopId = shopId;
	}

	public Date getOrderDate() {
		return OrderDate;
	}
	public MemberListVO getMemVO() {
		return memVO;
	}
	public void setMemVO(MemberListVO memVO) {
		this.memVO = memVO;
	}
	public RestVO getRestVO() {
		return restVO;
	}
	public void setRestVO(RestVO restVO) {
		this.restVO = restVO;
	}
	public void setOrderDate(Date orderDate) {
		OrderDate = orderDate;
	}
	public Time getOrderTime() {
		return OrderTime;
	}
	public void setOrderTime(Time orderTime) {
		OrderTime = orderTime;
	}
	public Integer getPnum() {
		return Pnum;
	}
	public void setPnum(Integer pnum) {
		Pnum = pnum;
	}
	public Timestamp getBidTime() {
		return BidTime;
	}
	public void setBidTime(Timestamp bidTime) {
		BidTime = bidTime;
	}
	
	
}
