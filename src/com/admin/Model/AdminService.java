package com.admin.Model;

import java.util.List;

public class AdminService {
	private AdminDAO_interface dao;
	
	public AdminService() {
		dao = new AdminDAO();
	}
	
	public AdminVO addadmin(String AdminName, String AdminAcc, String AdminPswd) {
		AdminVO adminVO = new AdminVO();
		
		return adminVO;
	}
	
	public AdminVO update(Integer AdminId, String AdminName, String AdminAcc, String AdminPswd) {
		AdminVO adminVO = new AdminVO();
		
		return adminVO;
	}
	
	public void delete(Integer AdminId) {
		dao.delete(AdminId);
	}
	
	public AdminVO getAdmin(Integer AdminId) {
		return dao.findByPrimaryKey(AdminId);
	}
	
	public List<AdminVO> getAll() {
		return dao.getAll();
	}
	
}
