package com.order.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.order.Model.OrderService;
import com.rest.Model.RestService;
import com.rest.Model.RestVO;
import com.search.Model.SearchService;

@WebServlet("/OrderRateServlet.do")
public class OrderRateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		if(session.getAttribute("LoginOK")!=null){
			Integer Rate = Integer.parseInt(request.getParameter("rate"));
			Integer OrderNum = Integer.parseInt(request.getParameter("orderNum"));
			String restName = request.getParameter("restName");
		    OrderService restRateSrv = new OrderService();
		    restRateSrv.addRate(OrderNum, Rate);
		    SearchService srchSrv;
		    RestVO restVO;
			try {
				srchSrv = new SearchService();
			    restVO = srchSrv.getOneRest(restName);
			    OrderService oderSrv = new OrderService();
			    RestService restSrv = new RestService();
			    Integer newRate = oderSrv.getRestRate(restVO.getRestId()).intValue();
			    if(newRate != restVO.getRestRate()){
			    	restVO = restSrv.updateRate(restVO.getRestId(), newRate);
			    	srchSrv.updateRest(restVO);
			    }
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
