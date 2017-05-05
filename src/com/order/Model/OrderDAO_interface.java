package com.order.Model;

import java.sql.Date;
import java.util.List;


public interface OrderDAO_interface {
	public void insert(OrderVO orderVO);
	public void update(OrderVO orderVO);
	public void delete(Integer orderNum);
	public OrderVO findByPrimaryKey(Integer OrderNum);
	public List<OrderVO> findByMidForOrder(Integer MemberId);
	public List<Object[]> findByShopId(Integer shopId);
	public List<OrderVO> getAll();
	public List<Object[]> getSeat(Date orderDate,Integer restId);
	public List<OrderVO> findByRestId(Integer restId);
	public void addRate(Integer OrderNum,Integer Rate);
	public Double getAvgRate(Integer restId);
	public List<Object[]> findByDate(Integer shopId, Date date);
	public List<Object[]> getOrderCount(Integer shopId);
}
