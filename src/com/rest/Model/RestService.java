package com.rest.Model;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;


public class RestService {
	private Rest_interface dao;
	
	public RestService(){
		dao = new RestDAO();
	}
	
	public RestVO addRest(Integer ShopId,String RestName,String RestTel,String RestAddr,Integer Ein,Time RestStart,Time RestEnd,
			Integer RestRate,Integer RestNum,byte[] data,String fileName,String brief,Integer status,Integer money) throws IOException{
		
		RestVO restVO = new RestVO();
		restVO.setShopId(ShopId);
	    restVO.setRestName(RestName);
		restVO.setRestTel(RestTel);
		restVO.setRestaddr(RestAddr);
		restVO.setEin(Ein);
		restVO.setRestStart(RestStart);
		restVO.setRestEnd(RestEnd);
		restVO.setRestRate(RestRate);
		restVO.setRestNum(RestNum);
		restVO.setRestImage(data);
		restVO.setFileName(fileName);
		restVO.setBrief(brief);
		restVO.setStatus(status);
		restVO.setMoney(money);
		dao.insert(restVO);
		return restVO;
	}
	
	public RestVO update(Integer RestId,Integer ShopId , String RestName,String RestTel,String RestAddr,Integer Ein,Time RestStart,Time RestEnd,
			Integer RestRate,Integer RestNum,byte[] data,String fileName,String brief,Integer status,Integer money){
		
		RestVO restVO = new RestVO();
		
		restVO.setRestId(RestId);
		restVO.setShopId(ShopId);
		restVO.setRestName(RestName);
		restVO.setRestTel(RestTel);
		restVO.setRestaddr(RestAddr);
		restVO.setEin(Ein);
		restVO.setRestStart(RestStart);
		restVO.setRestEnd(RestEnd);
		restVO.setRestRate(RestRate);
		restVO.setRestNum(RestNum);
		restVO.setRestImage(data);
		restVO.setFileName(fileName);
		restVO.setBrief(brief);
		restVO.setStatus(status);
		restVO.setMoney(money);
		dao.update(restVO);
		
		return dao.findByPrimaryKey(RestId);
	}
	
	public void delete(Integer RestId){
		dao.delete(RestId);
	}
	
	public RestVO getOneRest(Integer RestId){
		return dao.findByPrimaryKey(RestId);
	}
	
	public List<RestVO> getAllRest(){
		return dao.selectAll();
	}
	public List<RestVO> findByShopId(Integer ShopId) {
		return dao.findByShopId(ShopId);
	}
	public RestVO updateRate(Integer RestId,Integer RestRate){
		return dao.updateRestRate(RestId, RestRate);
	}
}

