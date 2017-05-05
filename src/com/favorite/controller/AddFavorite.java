package com.favorite.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
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

import com.favorite.Model.FavoriteService;
import com.favorite.Model.FavoriteVO;
import com.member.Model.MemberListVO;
import com.order.Model.OrderService;
import com.order.Model.OrderVO;
import com.rest.Model.RestVO;
import com.search.Model.SearchService;
import com.shop.Model.ShopService;

import message.Model.MessageService;

@WebServlet("/favorite.do")
public class AddFavorite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		Map<String, String> errorMsgs = new HashMap<String, String>();
		//MemId
		MemberListVO mb = (MemberListVO) session.getAttribute("LoginOK");
		Integer memId = mb.getMemId();
		
		//RestId
		String restId = request.getParameter("restId");
		
		//AddTime
		Timestamp addTime = new Timestamp(System.currentTimeMillis());
		
		try {			
			FavoriteService fSvc = new FavoriteService();
			fSvc.addFavorite(memId, new Integer(restId), addTime);
			Integer mid = mb.getMemId();
			FavoriteService fsvc =new FavoriteService();
			List<FavoriteVO> favoritelist = fsvc.getOneOrder(mid);
			session.setAttribute("favoritelist", favoritelist);
			return;
		} catch (SQLException ex) {
			errorMsgs.put("無法取得資料", ex.getMessage());
			RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
			ex.printStackTrace();
		}			 
	}
}
