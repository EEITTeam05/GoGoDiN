package com.order.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Base64;
import java.util.Calendar;
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

import com.member.Model.MemberListVO;
import com.member.Model.MemberService;
import com.order.Model.OrderService;
import com.order.Model.OrderVO;
import com.rest.Model.RestService;
import com.rest.Model.RestVO;
import com.search.Model.SearchService;

@WebServlet("/Member/MemOrderServlet")
public class MemOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String action = request.getParameter("action");

		HttpSession session = request.getSession();
		if("getOrderList".equals(action)){
			if (session.getAttribute("LoginOK") != null) {
				Map<String, String> errorMsgs = new HashMap<String, String>();
				MemberListVO memVO = (MemberListVO) session.getAttribute("LoginOK");
				Integer memId = memVO.getMemId();
				try {
					OrderService osc = new OrderService();
					List<OrderVO> listOrder = osc.getOneOrder(memId);
					session.setAttribute("listOrder_ByMemid", listOrder);
					String url = "/Orders/MemberOrders.jsp";
					RequestDispatcher rd = request.getRequestDispatcher(url);
					rd.forward(request, response);
				} catch (Exception e) {
					errorMsgs.put("無法取得資料", e.getMessage());
					RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
					rd.forward(request, response);
				}
			} else {			
				RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
				rd.forward(request, response);
			}	
		}
	}

	Integer MemId;
	Integer RestId;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String action = request.getParameter("action");

		HttpSession session = request.getSession();
		
		if ("getOneOrder".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();

			request.setAttribute("errorMsgs", errorMsgs);

			try {
				// 接收請求
				MemId = new Integer(request.getParameter("memId"));

				// 開始查詢訂單資料
				OrderService osc = new OrderService();
				List<OrderVO> listOrder = osc.getOneOrder(MemId);

				// 查詢完成，準備轉交
				session.setAttribute("listOrder_ByMemid", listOrder);
				String url = "/Orders/MemberOrders.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);

			} catch (Exception e) {
				errorMsgs.add("無法取得資料" + e.getMessage());
				RequestDispatcher rd = request.getRequestDispatcher("/Member/MemberList.jsp");
				rd.forward(request, response);
			}
		}

		if ("getOneRest".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();

			request.setAttribute("errorMsgs", errorMsgs);

			try {
				// 接收請求
				RestId = new Integer(request.getParameter("restId"));

				// 開始查詢餐廳資料
				RestService rsc = new RestService();
				RestVO restVO = rsc.getOneRest(RestId);

				// 查詢完成，準備轉交
				request.setAttribute("restVO", restVO);
				String url = "/Orders/MemOrderRest.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);

			} catch (Exception e) {
				errorMsgs.add("無法取得資料" + e.getMessage());
				e.printStackTrace();
				RequestDispatcher rd = request.getRequestDispatcher("/Orders/MemOrderRest.jsp");
				rd.forward(request, response);
			}
		}

		if ("back".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();

			request.setAttribute("errorMsgs", errorMsgs);

			try {
				String url = "/Member/MemberList.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);

			} catch (Exception e) {
				errorMsgs.add("無法取得資料" + e.getMessage());
				RequestDispatcher rd = request.getRequestDispatcher("/Member/MemberList.jsp");
				rd.forward(request, response);
			}
		}

		if ("back2".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();

			request.setAttribute("errorMsgs", errorMsgs);

			try {
				String url = "/Orders/MemberOrders.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);

			} catch (Exception e) {
				errorMsgs.add("無法取得資料" + e.getMessage());
				RequestDispatcher rd = request.getRequestDispatcher("/Member/MemberList.jsp");
				rd.forward(request, response);
			}
		}
	}

}
