package com.cart.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CartService
 */
@WebServlet("/ticket/CartService")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;



	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(false);
		if (session == null) { // 使用逾時
			request.setAttribute("Errors", "使用逾時，請重新登入(BuyBookServlet:SessionTimeOut)");
			RequestDispatcher rd = request.getRequestDispatcher("../index.jsp");
			rd.forward(request, response);
			return;
		}

		String qtyStr = request.getParameter("qty");
		String ProductName = request.getParameter("ProductName");
		String Detailed = request.getParameter("Detailed");
		String TktMoneyStr = request.getParameter("TktMoney");
		String TktIdStr = request.getParameter("TktId");

		int qty = 0;
		int TktMoney = 0;
		int TktId = 0;
		try {
			// 進行資料型態的轉換
			qty = Integer.parseInt(qtyStr.trim());
			TktMoney = Integer.parseInt(TktMoneyStr.trim());
			TktId = Integer.parseInt(TktIdStr.trim());
		} catch (NumberFormatException e) {
			throw new ServletException(e);
		}

		// 將訂單資料封裝到OrderItemBean內
		CartBean cartbean = new CartBean(qty, ProductName, Detailed, TktMoney, TktId);

		CartMap cart = (CartMap) session.getAttribute("ShoppingCart");
		// 如果找不到ShoppingCart物件
		if (cart == null) {
			// 就新建ShoppingCart物件
			cart = new CartMap();
			// 將此新建ShoppingCart的物件放到session物件內
			session.setAttribute("ShoppingCart", cart);
		}
		
		cart.addToCart(TktId, cartbean);
		
		// cart.getItemName(TktId);
		RequestDispatcher rd = request.getRequestDispatcher("ticket.jsp");
		rd.forward(request, response);

	}

}
