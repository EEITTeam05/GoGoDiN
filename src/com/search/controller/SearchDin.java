package com.search.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONValue;

import com.rest.Model.RestService;
import com.rest.Model.RestVO;
import com.search.Model.SearchService;

@WebServlet("/SearchDin.do")
public class SearchDin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String restId = request.getParameter("restName");
		try {
			SearchService srsv = new SearchService();
			RestVO restVO = srsv.getOneRest(restId);
			Map<String, String> m1 = new HashMap<>();
			m1.put("RestId", restVO.getRestId().toString());
			m1.put("RestName", restVO.getRestName());
			m1.put("RestTel", restVO.getRestTel());
			m1.put("RestAddr", restVO.getRestaddr());
			m1.put("RestRate", restVO.getRestRate().toString());
			m1.put("RestNum", restVO.getRestNum().toString());
			m1.put("RestImg", Base64.getEncoder().encodeToString(restVO.getRestImage()));
			String jsonString = JSONValue.toJSONString(m1);
			out.print(jsonString);
		}catch (Exception e) {
			out.println("Error:" + e.getMessage());
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
