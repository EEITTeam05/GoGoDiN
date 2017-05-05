package message.Model;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import com.order.Model.OrderVO;

import hibernate.util.BigImportentHibernate;


public class MessageDAO implements Message_interface {
	@Override
	public void insert(MessageVO MessageVO) {
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(MessageVO);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
	}

	@Override
	public void update(MessageVO MessageVO) {
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(MessageVO);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
	}
	public void updateIsRead(Integer MesId){
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try{
			session.beginTransaction();
			MessageVO messageVO = (MessageVO) session.get(MessageVO.class, MesId);
			messageVO.setIsRead(true);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
	}
	@Override
	public void delete(Integer MesId) {
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try{
			session.beginTransaction();
			Query query = session.createQuery("delete MessageVO where MesId = ?");
			query.setParameter(0, MesId);
			System.out.println("刪除筆數 ="+query.executeUpdate());
			session.getTransaction().commit();
		}catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
	}
	@Override
	public MessageVO findByPrimaryKey(Integer MesId) {
		MessageVO MessageVO = null;
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try{
			session.beginTransaction();
			MessageVO = (MessageVO) session.get(MessageVO.class, MesId);
			session.getTransaction().commit();
		}catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e ;
		}
		return MessageVO;
	}

	@Override
	public List<MessageVO> selectAll() {
		List<MessageVO> list = null;
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from MessageVO");
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}
	
	public List<MessageVO> findByReceived(String ReceivedAccount) {
		List<MessageVO> list = null;
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from MessageVO where ReceivedAccount=? order by sendtime desc");
			query.setParameter(0, ReceivedAccount);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}

	@Override
	public Long getIsNotReadCount(String ReceivedAccount) {
		Session session = BigImportentHibernate.getSessionFactory().getCurrentSession();
		Long count = 0l;
		try {
			session.beginTransaction();
			Query query = session.createQuery("select count(*) from MessageVO where ReceivedAccount=? and isRead = ?");
			query.setParameter(0, ReceivedAccount);
			query.setParameter(1, false);
			count = (Long) query.list().get(0);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
			return count;
	}
}
