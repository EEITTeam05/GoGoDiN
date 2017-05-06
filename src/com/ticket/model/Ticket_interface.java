package com.ticket.model;

import java.util.List;


public interface Ticket_interface {
	public void insert(TicketVO ticketVO);
	public void update(TicketVO ticketVO);
	public void delete(Integer TktId);
	public TicketVO findByPrimaryKey(Integer TktId);
	public List<TicketVO> getAll();
	
//	public List<TicketVO> findByMidForOrder(Integer MemberId);
//	public List<Object[]> findByShopId(Integer shopId);	
//	public List<Object[]> getSeat(Date orderDate,Integer restId);
//	public List<TicketVO> findByRestId(Integer restId);
//	public void addRate(Integer OrderNum,Integer Rate);
//	public Double getAvgRate(Integer restId);
//	public List<Object[]> findByDate(Integer shopId, Date date);
//	public List<Object[]> getOrderCount(Integer shopId);
}
