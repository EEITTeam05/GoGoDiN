package com.restPhoto.Model;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import hibernate.util.BigImportentHibernate;

public class RestPhotoDAO implements RestPhoto_interface {
	@Override
	public void insert(RestPhotoVO restPhotoVO) {
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(restPhotoVO);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
	}

	@Override
	public void update(RestPhotoVO restPhotoVO) {
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(restPhotoVO);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
	}

	@Override
	public void delete(Integer RePhotoId) {
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try{
			session.beginTransaction();
			Query query = session.createQuery("delete RestPhotoVO where RePohtoId = ?");
			query.setParameter(0, RePhotoId);
			System.out.println("刪除的筆數="+query.executeUpdate());
			session.getTransaction().commit();
		}catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
	}
	@Override
	public RestPhotoVO findByPrimaryKey(Integer RePhotoId) {
		RestPhotoVO restVO = null;
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try{
			session.beginTransaction();
			restVO = (RestPhotoVO) session.get(RestPhotoVO.class, RePhotoId);
			session.getTransaction().commit();
		}catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e ;
		}
		return restVO;
	}
	
	public RestPhotoVO findByRestId(Integer RestId){
		List<RestPhotoVO> list = null;
		RestPhotoVO restPhotoVO = new RestPhotoVO();
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try{
			session.beginTransaction();
			Query query = session.createQuery("from RestPhotoVO where RestId="+RestId);
			restPhotoVO = (RestPhotoVO) query.list().get(0);
			session.getTransaction().commit();
		}catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e ;
		}
		return restPhotoVO;
	}
	
	
	@Override
	public List<RestPhotoVO> selectAll() {
		List<RestPhotoVO> list = null;
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from RestPhotoVO");
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}
	
	public long PhotoCount(){
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		long count = 0;
		try{
			session.beginTransaction();
			Query query = session.createQuery("select count(*) as count from RestPhotoVO");
			count = (long) query.list().get(0);
			session.getTransaction().commit();
		}catch (Exception e) {
			session.getTransaction().rollback();
			throw e;
		}
		return count;
	}
}
