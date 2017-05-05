package com.login_Model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.admin.Model.AdminService;
import com.admin.Model.AdminVO;
import com.member.Model.MemberListVO;
import com.member.Model.MemberService;
import com.shop.Model.ShopService;
import com.shop.Model.ShopVO;

public class loginService implements login_interface {

	private static Map<String, MemberListVO> membermap = new HashMap<>();
	private static Map<String, ShopVO> shopmap = new HashMap<>();
	private static Map<String, AdminVO> adminmap = new HashMap<>();
	
	// 建構子
	public loginService() throws SQLException {
		if (membermap.isEmpty()) {
			if(shopmap.isEmpty()){
				if (adminmap.isEmpty()) {
					this.populateAdminList();
				}
				this.populateShopList();
			}
			this.populateMemberList();
		}
	}

	@Override
	public void populateMemberList() throws SQLException {
		MemberService dao = new MemberService();
		for(MemberListVO mbvo : dao.getAll()){
			membermap.put(mbvo.getMemAccount().toLowerCase(), mbvo);
		}
	}

	public void populateShopList() throws SQLException {
		ShopService dao = new ShopService();
		for(ShopVO spvo : dao.getAll()){
			shopmap.put(spvo.getShopAccount().toLowerCase(), spvo);
		}
	}

	public void populateAdminList() throws SQLException {
		AdminService dao = new AdminService();
		for(AdminVO advo:dao.getAll()){
			adminmap.put(advo.getAdminAcc().toLowerCase(), advo);
		}
	}
	
	@Override
	public MemberListVO checkIDPassword(String userId, String password) {
		if(membermap.containsKey(userId.toLowerCase())
				&& password.equals(membermap.get(userId.toLowerCase()).getMemPswd())){
					return membermap.get(userId.toLowerCase());
				}

		return null;
	}

	public ShopVO checkShopIDPassword(String userId, String password) {
		if(shopmap.containsKey(userId.toLowerCase()) 
				&& password.equals(shopmap.get(userId.toLowerCase()).getShopPswd())){
					return shopmap.get(userId.toLowerCase());
			}
		return null;
	}

	public AdminVO checkAdminIdPassword(String userId, String password) {
		if(adminmap.containsKey(userId.toLowerCase())
			&& password.equals(adminmap.get(userId.toLowerCase()).getAdminPswd())){
				return adminmap.get(userId.toLowerCase());
		}
		
		return null;
	}
	
	@Override
	public Map<String,MemberListVO> getMemberList() {
		return membermap;
	}

	public Map<String,ShopVO> getShopList() {
		return shopmap;
	}

	public Map<String,AdminVO> getAdminList() {
		return adminmap;
	}
	
	@Override
	public void addNewMember(MemberListVO mb) {
		membermap.put(mb.getMemAccount().toLowerCase(), mb);
	}

	public void addNewShop(ShopVO sb) {
		shopmap.put(sb.getShopAccount().toLowerCase(), sb);
	}

	public void updateMember(MemberListVO mb){
		membermap.replace(mb.getMemAccount().toLowerCase(), mb);
	}
	
	public void updateShop(ShopVO sb){
		shopmap.replace(sb.getShopAccount().toLowerCase(), sb);
	}
}
