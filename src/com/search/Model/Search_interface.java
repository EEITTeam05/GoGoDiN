package com.search.Model;

import java.sql.SQLException;
import java.util.Map;

import com.rest.Model.RestVO;

public interface Search_interface {
	public void populateRestList() throws SQLException;
	public Map<String,RestVO> getRestMap();
	public void addNewRest(RestVO mb);
}
