package com.admin.Model;

import java.util.List;

public interface AdminDAO_interface {
	public void insert(AdminVO adminVO);
	
	public void update(AdminVO adminVO);
	
	public void delete(Integer AdminId);
	
	public AdminVO findByPrimaryKey(Integer adminId);
	
	public List<AdminVO> getAll();
}
