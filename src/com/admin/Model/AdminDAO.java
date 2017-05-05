package com.admin.Model;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import hibernate.util.BigImportentHibernate;

public class AdminDAO implements AdminDAO_interface {

	@Override
	public void insert(AdminVO adminVO) {
		
	}

	@Override
	public void update(AdminVO adminVO) {
		
	}

	@Override
	public void delete(Integer AdminId) {
		
	}

	@Override
	public AdminVO findByPrimaryKey(Integer adminId) {
		AdminVO adminVO = null;
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		
		try {
			session.beginTransaction();
			adminVO = (AdminVO)session.get(AdminVO.class, adminId);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return adminVO;
	}

	@Override
	public List<AdminVO> getAll() {
		List<AdminVO> list = null;
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		
		try {
			session.beginTransaction();
			Query query = session.createQuery("FROM AdminVO");
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}

}
