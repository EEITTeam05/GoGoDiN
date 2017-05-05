package com.favorite.Model;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.classic.Session;


import hibernate.util.BigImportentHibernate;

public class FavoriteDAO implements FavoriteDAO_interface{
	
	
	
	@Override
	public void insert(FavoriteVO favoriteVO) {
		
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		
		try{
			session.beginTransaction();
			session.saveOrUpdate(favoriteVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}
	
	@Override
	public void update(FavoriteVO favoriteVO) {
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(favoriteVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		
	}

	@Override
	public void delete(Integer favoriteId) {
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();

			// 【此時多方(宜)可採用HQL刪除】-我比較喜歡的方法XD
			Query query = session.createQuery("delete FavoriteVO where restId=?");
			query.setParameter(0, favoriteId);
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
	public void delete(Integer restId,Integer MemId) {
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			// 【此時多方(宜)可採用HQL刪除】-我比較喜歡的方法XD
			Query query = session.createQuery("delete FavoriteVO where restId=? and memId=?");
			query.setParameter(0, restId);
			query.setParameter(1, MemId);
			System.out.println("刪除的筆數=" + query.executeUpdate());
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}
	@Override
	public FavoriteVO findByPrimaryKey(Integer favoriteId) {
		FavoriteVO frtVO = null;
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			frtVO = (FavoriteVO) session.get(FavoriteVO.class, favoriteId);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return frtVO;
	}
	
	@Override
	public List<FavoriteVO> getAll() {
		List<FavoriteVO> list = null;
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from FavoriteVO");
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}
	

	public List<FavoriteVO> findByMidFavorite(Integer MemId) {
		List<FavoriteVO> list = null;
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from FavoriteVO where MemId=? order by AddTime desc");
			query.setParameter(0, MemId);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}
	
	/*
	public List<Object[]> findByShopId(Integer shopId) {
		List<Object[]> list = null;
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createSQLQuery("SELECT ShopId, restId ,SUM(PNum) FROM OrderTable WHERE ShopId = ? GROUP BY ShopId,RestId");
			query.setParameter(0, shopId);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}
	@Override
	public List<OrderVO> findByRestId(Integer restId) {
		List<OrderVO> list = null;
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			SQLQuery query = session.createSQLQuery("SELECT MemberId, ShopId, RestId, OrderDate, OrderTime, SUM(Pnum), BidTime FROM OrderTable WHERE RestId = ? GROUP BY MemberId, ShopId, RestId, OrderDate, OrderTime, BidTime");
			query.setParameter(0, restId);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}
	*/
}
