package com.favorite.Model;

import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.List;


import com.member.Model.MemberListVO;
import com.rest.Model.RestVO;

public class FavoriteService {

	private FavoriteDAO_interface dao;

	public FavoriteService() {
		dao = new FavoriteDAO();
	}

	// 1.新增
	public FavoriteVO addFavorite(Integer memId, Integer restId, Timestamp addTime) throws SQLException {

		FavoriteVO frtVO = new FavoriteVO();
		
		MemberListVO memVO = new MemberListVO();
		memVO.setMemId(memId);
		
		RestVO restVO = new RestVO();		
		restVO.setRestId(restId);
		
		frtVO.setMemVO(memVO);		
		frtVO.setRestVO(restVO);		
		frtVO.setAddTime(addTime);
		
		dao.insert(frtVO);

		return frtVO;
	}

	// 2.修改
	public FavoriteVO update(Integer favoriteId, Integer memId, Integer restId, Timestamp addTime) throws SQLException {

		FavoriteVO frtVO = new FavoriteVO();
		
		MemberListVO memVO = new MemberListVO();
		memVO.setMemId(memId);
		
		RestVO restVO = new RestVO();
		restVO.setRestId(restId);
		
		frtVO.setFavoriteId(favoriteId);
		frtVO.setMemVO(memVO);
		frtVO.setRestVO(restVO);		
		frtVO.setAddTime(addTime);
		
		dao.update(frtVO);

		return dao.findByPrimaryKey(favoriteId);
	}

	// 3.單一查詢
	public FavoriteVO getOneFavorite(Integer favoriteId) {
		return dao.findByPrimaryKey(favoriteId);
	}

	// 4.全部查詢
	public List<FavoriteVO> getAll() {
		return dao.getAll();
	}

	// 5.刪除
	public void delete(Integer OrderNum) {
		dao.delete(OrderNum);
	}	
	public void delete(Integer restId,Integer MemId){
		dao.delete(restId,MemId);
	}
	// 6.用MemberId查收藏
	public List<FavoriteVO> getOneOrder(Integer MemberId) {
		return dao.findByMidFavorite(MemberId);
	}
	
	
//	public List<OrderVO> findByRestId(Integer restId) {
//		return dao.findByRestId(restId);
//	}
//	public List<Object[]> findByShopId(Integer shopId) {
//		return dao.findByShopId(shopId);
//	}
	
	
	public static void main(String args[]) throws SQLException {
		//新增
		FavoriteService dao = new FavoriteService();
		long d = System.currentTimeMillis();
		Timestamp date = new Timestamp(d);
		dao.addFavorite(1,1,date);
		
		//刪除
//		dao.delete(4);
		
//		ShopVO shopVO = dao.getoneshop(3);
//		System.out.println(shopVO.getShopId());
		
		//更新
//		dao.update(3, "ttt429", "ttt446", "測試2", "0123456789", "23618524", "AAA@yahoo.com.tw", "cba");
		
		
		
		List<FavoriteVO> list = dao.getAll();
		for (FavoriteVO aEmp : list) {

			System.out.print(aEmp.getFavoriteId() + ",");
			System.out.print(aEmp.getMemVO().getMlineId() + ",");
			System.out.print(aEmp.getRestVO().getRestName() + ",");
			System.out.print(aEmp.getAddTime() + ",");
			System.out.println();
		}		
	}
	
	
	
}
