package com.ticket.model;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.classic.Session;


import hibernate.util.BigImportentHibernate;

public class TicketDAO implements Ticket_interface{
	@Override
	public void insert(TicketVO ticketVO) {
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try{
			session.beginTransaction();
			session.saveOrUpdate(ticketVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}
	
	@Override
	public void update(TicketVO ticketVO) {
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(ticketVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		
	}

	@Override
	public void delete(Integer TktId) {
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();

			// 【此時多方(宜)可採用HQL刪除】-我比較喜歡的方法XD
			Query query = session.createQuery("delete TicketVO where TktId=?");
			query.setParameter(0, TktId);
			System.out.println("刪除的筆數=" + query.executeUpdate());

			// 【或此時多方(也)可採用去除關聯關係後，再刪除的方式】
			// MemberListVO memVO = new MemberListVO();
			// memVO.setMemId(memId);
			// session.delete(memVO);

			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		
	}

	@Override
	public TicketVO findByPrimaryKey(Integer TktId) {
		TicketVO odrVO = null;
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			odrVO = (TicketVO) session.get(TicketVO.class, TktId);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return odrVO;
	}
	
	

	@Override
	public List<TicketVO> getAll() {
		List<TicketVO> list = null;
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from TicketVO");
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}
	
	
//	@Override
//	public List<TicketVO> findByMidForOrder(Integer MemberId) {
//		List<TicketVO> list = null;
//		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
//		try {
//			session.beginTransaction();
//			Query query = session.createQuery("from TicketVO where MemberId=? order by bidtime desc");
//			query.setParameter(0, MemberId);
//			list = query.list();
//			session.getTransaction().commit();
//		} catch (RuntimeException ex) {
//			session.getTransaction().rollback();
//			throw ex;
//		}
//		return list;
//	}
//	
//	//取得尚餘位置
//	@Override
//	public List<Object[]> getSeat(Date orderDate, Integer restId) {
//		List<Object[]> list = null;
//		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
//		try{
//			session.beginTransaction();
//			Query query = session.createQuery(
//					"select SUM(Pnum) , OrderTime from TicketVO where OrderDate = ? and restId = ? group by OrderTime");
//			query.setParameter(0, orderDate);
//			query.setParameter(1, restId);
//			list = query.list();
//			session.getTransaction().commit();
//		}catch (RuntimeException ex) {
//			session.getTransaction().rollback();
//			throw ex;
//		}
//		return list;
//	}
//	@Override
//	public List<Object[]> findByShopId(Integer shopId) {
//		List<Object[]> list = null;
//		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
//		try {
//			session.beginTransaction();
//			Query query = session.createSQLQuery("SELECT ShopId, restId ,SUM(PNum) FROM OrderTable WHERE ShopId = ? GROUP BY ShopId,RestId");
//			query.setParameter(0, shopId);
//			list = query.list();
//			session.getTransaction().commit();
//		} catch (RuntimeException e) {
//			session.getTransaction().rollback();
//			throw e;
//		}
//		return list;
//	}
//	
//	@Override
//	public List<TicketVO> findByRestId(Integer restId) {
//		List<TicketVO> list = null;
//		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
//		try {
//			session.beginTransaction();
//			SQLQuery query = session.createSQLQuery("SELECT OrderNum, MemberId, ShopId, RestId, OrderDate, OrderTime, SUM(Pnum), BidTime FROM OrderTable WHERE RestId = ? GROUP BY OrderNum, MemberId, ShopId, RestId, OrderDate, OrderTime, BidTime");
//			query.setParameter(0, restId);
//			list = query.list();
//			session.getTransaction().commit();
//		} catch (RuntimeException e) {
//			session.getTransaction().rollback();
//			throw e;
//		}
//		return list;
//	}
//	
//	public void addRate(Integer OrderNum,Integer Rate){
//		Session session =BigImportentHibernate.getSessionFactory().getCurrentSession();
//		try {
//			session.beginTransaction();
//			TicketVO ticketVO = (TicketVO) session.get(TicketVO.class, OrderNum);
//			ticketVO.setIsRate(true);
//			ticketVO.setRate(Rate);
//			session.getTransaction().commit();
//		} catch (RuntimeException e) {
//			session.getTransaction().rollback();
//			throw e;
//			// TODO: handle exception
//		}
//	}
//
//	@Override
//	public Double getAvgRate(Integer restId) {
//		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
//		Double rate = 80d;
//		try {
//			session.beginTransaction();
//			Query query = session.createQuery("select avg(Rate) from TicketVO where isRate = 1 and RestId=?");
//			query.setParameter(0, restId);
//			rate = (Double) query.list().get(0);
//			session.getTransaction().commit();
//		} catch (RuntimeException e) {
//			session.getTransaction().rollback();
//			throw e;
//		}
//		return rate;
//	}
//	@Override
//	public List<Object[]> findByDate(Integer shopId, Date date) {
//		List<Object[]> list = null;
//		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
//		try {
//			session.beginTransaction();
//			SQLQuery query = session.createSQLQuery("SELECT MemberId, RestId, OrderTime, Pnum, BidTime FROM OrderTable WHERE ShopId = ? AND OrderDate = ? GROUP BY MemberId, RestId, OrderTime, Pnum, BidTime");
//			query.setParameter(0, shopId);
//			query.setParameter(1, date);
//			list = query.list();
//			session.getTransaction().commit();
//		} catch (RuntimeException e) {
//			session.getTransaction().rollback();
//			throw e;
//		}
//		return list;
//	}
//	
//	@Override
//	public List<Object[]> getOrderCount(Integer shopId) {
//		List<Object[]> list = null;
//		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
//		try {
//			session.beginTransaction();
//			SQLQuery query = session.createSQLQuery("SELECT OrderDate, COUNT(*) FROM OrderTable WHERE ShopId = ? GROUP BY OrderDate");
//			query.setParameter(0, shopId);
//			list = query.list();
//			session.getTransaction().commit();
//		} catch (RuntimeException e) {
//			session.getTransaction().rollback();
//			throw e;
//		}
//		return list;
//	}
}
