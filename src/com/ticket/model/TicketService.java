package com.ticket.model;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.List;

import com.img.Io.ImagesIo;
import com.member.Model.MemberListVO;
import com.rest.Model.RestVO;

public class TicketService {

	private Ticket_interface dao;

	public TicketService() {
		dao = new TicketDAO();
	}

	// 1.新增
	public TicketVO addTicket(Integer RestId, String ProductName, String Detailed, Integer TktMoney, byte[] data, String fileName) throws SQLException {

		TicketVO tktVO = new TicketVO();
		
		RestVO restVO = new RestVO();		
		restVO.setRestId(RestId);
		
		tktVO.setRestVO(restVO);
		tktVO.setProductName(ProductName);
		tktVO.setDetailed(Detailed);
		tktVO.setTktMoney(TktMoney);
		tktVO.setTktImage(data);
		tktVO.setFileName(fileName);		
		
		dao.insert(tktVO);

		return tktVO;
	}

	// 2.修改
	public TicketVO update(Integer TktId, Integer RestId, String ProductName, String Detailed, Integer TktMoney, byte[] data, String fileName) throws SQLException {
		
		TicketVO tktVO = new TicketVO();
		
		RestVO restVO = new RestVO();		
		restVO.setRestId(RestId);
		
		tktVO.setTktId(TktId);
		tktVO.setRestVO(restVO);
		tktVO.setProductName(ProductName);
		tktVO.setDetailed(Detailed);
		tktVO.setTktMoney(TktMoney);
		tktVO.setTktImage(data);
		tktVO.setFileName(fileName);		
		
		dao.insert(tktVO);

		return dao.findByPrimaryKey(TktId);
	}

	// 3.單一查詢
	public TicketVO getOrder(Integer TktId) {
		return dao.findByPrimaryKey(TktId);
	}

	// 4.全部查詢
	public List<TicketVO> getAll() {
		return dao.getAll();
	}

	// 5.刪除
	public void delete(Integer TktId) {
		dao.delete(TktId);
	}
	
	/*
	public List<TicketVO> findByRestId(Integer restId) {
		return dao.findByRestId(restId);
	}	
	public List<TicketVO> getOneOrder(Integer MemberId) {
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
	public List<Object[]> getSeat(Date orderDate, Integer restId){
		return dao.getSeat(orderDate, restId);
	}// 取得尚餘位置	
	public void addRate(Integer OrderNum,Integer Rate){
		dao.addRate(OrderNum, Rate);
	}	
	public Double getRestRate(Integer restId){
		return dao.getAvgRate(restId);
	}
	*/
	
	public static void main(String args[]) throws SQLException{
		
		TicketService tktdao = new TicketService();

		
		File imageFile = new File("WebContent/images/members/didi.jpg");
		String fileName = imageFile.getName();
		InputStream is = null;
		byte[] data = null;
		
		
		try {
			is = new FileInputStream(imageFile);
		} catch (FileNotFoundException e) {		
			e.printStackTrace();
		}
		ImagesIo io = new ImagesIo();
		data = io.isToByte(is);	
		
		tktdao.addTicket(1, "教父牛排", "教父開的牛排店", 399, data, fileName);
		
		
		
		File imageFile1 = new File("WebContent/images/members/kitty.jpg");
		String fileName1 = imageFile1.getName();
		InputStream is1 = null;
		try {
			is1 = new FileInputStream(imageFile1);
		} catch (FileNotFoundException e) {		
			e.printStackTrace();
		}
		ImagesIo io1 = new ImagesIo();
		data = io1.isToByte(is1);	
		
		tktdao.addTicket(2, "123牛排", "123開的牛排店", 599, data, fileName1);
	}
}
