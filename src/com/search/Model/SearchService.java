package com.search.Model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.rest.Model.RestService;
import com.rest.Model.RestVO;

public class SearchService implements Search_interface{
	
	private static Map<String, RestVO> restmap = new HashMap<>();
	
	public SearchService() throws SQLException {
		if(restmap.isEmpty()){
			populateRestList();
		}
	}

	
	@Override
	public void populateRestList() throws SQLException {
		RestService dao = new RestService();
		for(RestVO restVO:dao.getAllRest()){
			restmap.put(restVO.getRestName(), restVO);
		}
	}
	
	public RestVO getOneRest(String RestName){
		return restmap.get(RestName);
	}
	
	@Override
	public Map<String, RestVO> getRestMap() {
		return restmap;
	}

	@Override
	public void addNewRest(RestVO restVO) {
		restmap.put(restVO.getRestName(), restVO);
	}
	
	public void updateRest(RestVO restVO){
		restmap.replace(restVO.getRestName(), restVO);
	}
	
}
