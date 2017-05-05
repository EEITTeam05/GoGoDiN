package com.order.Model;

import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.List;


import com.member.Model.MemberListVO;
import com.rest.Model.RestVO;

public class OrderService {

	private OrderDAO_interface dao;

	public OrderService() {
		dao = new OrderDAO();
	}

	// 1.新增
	public OrderVO addOrder(Integer MemberId, Integer ShopId, Integer RestId, Date OrderDate , Time OrderTime, Integer PNum,
			Timestamp BidTime,Boolean isRate,Integer Rate) throws SQLException {

		OrderVO odrVO = new OrderVO();
		
		MemberListVO mb = new MemberListVO();
		mb.setMemId(MemberId);
		
		odrVO.setMemVO(mb);
		odrVO.setShopId(ShopId);
		
		RestVO restVO = new RestVO();
		restVO.setRestId(RestId);
		odrVO.setRestVO(restVO);
		
		odrVO.setOrderDate(OrderDate);
		odrVO.setOrderTime(OrderTime);
		odrVO.setPnum(PNum);
		odrVO.setBidTime(BidTime);
		odrVO.setIsRate(isRate);
		odrVO.setRate(Rate);
		dao.insert(odrVO);

		return odrVO;
	}

	// 2.修改
	public OrderVO update(Integer OrderNum, Integer MemberId, Integer ShopId, Integer RestId, Date OrderDate , Time OrderTime,
			Integer PNum, Timestamp BidTime,Boolean isRate,Integer Rate) throws SQLException {
		OrderVO odrVO = new OrderVO();
		odrVO.setOrderNum(OrderNum);
		MemberListVO mb = new MemberListVO();
		mb.setMemId(MemberId);
		odrVO.setMemVO(mb);
		odrVO.setShopId(ShopId);
		RestVO restVO = new RestVO();
		restVO.setRestId(RestId);
		odrVO.setRestVO(restVO);
		odrVO.setOrderDate(OrderDate);
		odrVO.setOrderTime(OrderTime);
		odrVO.setPnum(PNum);
		odrVO.setBidTime(BidTime);
		odrVO.setIsRate(isRate);
		odrVO.setRate(Rate);
		dao.update(odrVO);

		return dao.findByPrimaryKey(OrderNum);
	}

	// 3.單一查詢
	public OrderVO getOrder(Integer orderNum) {
		return dao.findByPrimaryKey(orderNum);
	}

	// 4.全部查詢
	public List<OrderVO> getAll() {
		return dao.getAll();
	}

	// 5.刪除
	public void delete(Integer OrderNum) {
		dao.delete(OrderNum);
	}
	public List<OrderVO> findByRestId(Integer restId) {
		return dao.findByRestId(restId);
	}
	
	// 用MemberId查訂單
	public List<OrderVO> getOneOrder(Integer MemberId) {
		return dao.findByMidForOrder(MemberId);
	}
	public List<Object[]> findByShopId(Integer shopId) {
		return dao.findByShopId(shopId);
	}
	public List<Object[]> findByDate(Integer shopId, Date date) {
		return dao.findByDate(shopId,date);
	}
	
	public List<Object[]> getOrderCount(Integer shopId) {
		return dao.getOrderCount(shopId);
	}
	// 取得尚餘位置
	public List<Object[]> getSeat(Date orderDate, Integer restId){
		return dao.getSeat(orderDate, restId);
	}
	
	public void addRate(Integer OrderNum,Integer Rate){
		dao.addRate(OrderNum, Rate);
	}
	
	public Double getRestRate(Integer restId){
		return dao.getAvgRate(restId);
	}
}
