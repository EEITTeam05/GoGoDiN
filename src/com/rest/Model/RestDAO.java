package com.rest.Model;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import hibernate.util.BigImportentHibernate;

public class RestDAO implements Rest_interface {
	@Override
	public void insert(RestVO restVO) {
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(restVO);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
	}

	@Override
	public void update(RestVO restVO) {
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(restVO);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
	}

	@Override
	public void delete(Integer restId) {
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try{
			session.beginTransaction();
			Query query = session.createQuery("delete RestVO where restId = ?");
			query.setParameter(0, restId);
			System.out.println("刪除的筆數="+query.executeUpdate());
			session.getTransaction().commit();
		}catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
	}
	@Override
	public RestVO findByPrimaryKey(Integer restId) {
		RestVO restVO = null;
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try{
			session.beginTransaction();
			restVO = (RestVO) session.get(RestVO.class, restId);
			session.getTransaction().commit();
		}catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e ;
		}
		return restVO;
	}

	@Override
	public List<RestVO> selectAll() {
		List<RestVO> list = null;
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from RestVO");
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}
	@Override
	public List<RestVO> findByShopId(Integer shopId) {
		List<RestVO> list = null;
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("FROM RestVO WHERE shopId = ?");
			query.setParameter(0, shopId);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}

	public RestVO updateRestRate(Integer RestId,Integer RestRate) {
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		RestVO restVO = null;
		try {
			session.beginTransaction();
			restVO = (RestVO) session.get(RestVO.class, RestId);
			restVO.setRestRate(RestRate);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return restVO;
	}
}
