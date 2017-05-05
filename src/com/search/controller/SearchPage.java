package com.search.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONValue;
import com.rest.Model.RestVO;
import com.restPhoto.Model.RestPhotoService;
import com.restPhoto.Model.RestPhotoVO;
import com.search.Model.SearchService;

@WebServlet("/SearchPage.do")
public class SearchPage extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		String search = request.getParameter("search");
		try {
			SearchService searchsrv = new SearchService();
			RestVO restVO = searchsrv.getOneRest(search);
			Map<String, String> m1 = new HashMap<>();
				m1.put("RestId", restVO.getRestId().toString());
				m1.put("RestName", restVO.getRestName());
				m1.put("RestTel", restVO.getRestTel());
				m1.put("RestAddr", restVO.getRestaddr());
				m1.put("RestRate", restVO.getRestRate().toString());
				m1.put("RestStart", restVO.getRestStart().toString());
				m1.put("RestEnd", restVO.getRestEnd().toString());
				m1.put("RestNum", restVO.getRestNum().toString());
				m1.put("RestBrief", restVO.getBrief());
			request.setAttribute("restdetail", m1);
			RequestDispatcher rd = request.getRequestDispatcher("/restdetail.jsp");
			rd.forward(request, response);
		}catch (Exception e) {
			out.println("Error:" + e.getMessage());
		} 
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
