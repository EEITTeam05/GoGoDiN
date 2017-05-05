package com.search.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;
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

import com.favorite.Model.FavoriteDAO;
import com.favorite.Model.FavoriteService;
import com.favorite.Model.FavoriteVO;
import com.member.Model.MemberListVO;
import com.rest.Model.RestVO;
import com.search.Model.SearchService;

@WebServlet("/SearchBar.do")
public class SearchBar extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		String search = request.getParameter("search");
		try {
			SearchService srv = new SearchService();
			Map<String, RestVO> restmap = srv.getRestMap();
			List<Map<String,String>> list1 = new LinkedList<>();
			RestVO restVO = new RestVO();
			for(String restname : restmap.keySet()){
				restVO = restmap.get(restname);
				if(search.length()!=0&&restVO.getStatus()==0){
					if(restname.lastIndexOf(search)!=-1
							|| restVO.getRestaddr().lastIndexOf(search)!=-1){
						Map<String, String> m1 = new HashMap<>();
						m1.put("RestId", restVO.getRestId().toString());
						m1.put("RestName", restVO.getRestName());
						m1.put("RestTel", restVO.getRestTel());
						m1.put("RestAddr", restVO.getRestaddr());
						m1.put("RestRate", restVO.getRestRate().toString());
						m1.put("RestNum", restVO.getRestNum().toString());
						//m1.put("RestImg", Base64.getEncoder().encodeToString(restmap.get(restname).getRestImage()));
						list1.add(m1);
					}
				}
			}
			MemberListVO mb = (MemberListVO) session.getAttribute("LoginOK");
			if(mb!=null){
				FavoriteService favsrv = new FavoriteService();
				List<FavoriteVO> favoritelist = favsrv.getOneOrder(mb.getMemId());
				session.setAttribute("favoritelist", favoritelist);
			}
			String jsonString = JSONValue.toJSONString(list1);
//			request.setAttribute("searchlist", list1);
//			RequestDispatcher rd = request.getRequestDispatcher("/SearchList.jsp");
//			rd.forward(request, response);
			out.print(jsonString);
		}catch (Exception e) {
			out.println("Error:" + e.getMessage());
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
