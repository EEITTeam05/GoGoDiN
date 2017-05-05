package com.favorite.controller;

import java.io.IOException;
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


@WebServlet("/Member/DeleteFavorite.do")
public class DelFavorite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		
		Map<String, String> errorMsgs = new HashMap<String, String>();
		
		String action = request.getParameter("action");
		
		//MemId
		MemberListVO mb = (MemberListVO) session.getAttribute("LoginOK");
		Integer mid = mb.getMemId();
		//RestId
		Integer RestId;
		if ("DeleteOneFavorite".equals(action)) {
			try {
				// 接收請求
				RestId = new Integer(request.getParameter("restId"));
				// 開始刪除收藏資料
				FavoriteService fsvc = new FavoriteService();
				fsvc.delete(RestId,mid);
				// 刪除完成後再查詢一次並轉交				
				List<FavoriteVO> favo = fsvc.getOneOrder(mid);						
				session.setAttribute("favoritelist", favo);
				String url = "/Member/MemberList.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);
			} catch (Exception e) {
				errorMsgs.put("無法取得資料" , e.getMessage());
				RequestDispatcher rd = request.getRequestDispatcher("/Member/MemberList.jsp");
				rd.forward(request, response);
			}
		}else if("DeleteFromSearch".equals(action)){
			try {
				RestId = new Integer(request.getParameter("restId"));
				// 開始刪除收藏資料
				FavoriteService fsvc = new FavoriteService();
				fsvc.delete(RestId,mid);
				// 刪除完成後再查詢一次並轉交				
				List<FavoriteVO> favoritelist = fsvc.getOneOrder(mid);						
				session.setAttribute("favoritelist", favoritelist);
			} catch (Exception e) {
				errorMsgs.put("無法取得資料" , e.getMessage());
				RequestDispatcher rd = request.getRequestDispatcher("/Member/MemberList.jsp");
				rd.forward(request, response);
			}
		}
	}
}
