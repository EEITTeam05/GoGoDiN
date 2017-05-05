package com.admin.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.util.Base64;
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

import org.hibernate.Hibernate;
import org.json.simple.JSONValue;

import com.login_Model.loginService;
import com.member.Model.MemberListVO;
import com.member.Model.MemberService;
import com.order.Model.OrderService;
import com.order.Model.OrderVO;
import com.rest.Model.RestService;
import com.rest.Model.RestVO;
import com.shop.Model.ShopService;
import com.shop.Model.ShopVO;

@WebServlet("/Admin/AdminServlet")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public AdminServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request, response);
		String action = request.getParameter("action");
		
		if ("getImg".equals(action)) {
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			Integer restId = new Integer(request.getParameter("restId").trim());
			
			try {
				RestService rSvc = new RestService();
				RestVO restVO = rSvc.getOneRest(restId);
				Map<String,String> m1 = new HashMap<String,String>();
				
				m1.put("RestImg", Base64.getEncoder().encodeToString(restVO.getRestImage()));
				
				String jsonString = JSONValue.toJSONString(m1);
				out.print(jsonString);
			} catch (Exception e) {
				out.println("Error:" + e.getMessage());
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		
		//接收更新請求
		if ("getShopUpdate".equals(action)) {
			Map<String,String> errorMsgs = new HashMap<String,String>();
			request.setAttribute("errorMsgs", errorMsgs);
			HttpSession session = request.getSession();
			
			try {
				//接收請求
				Integer shopId = new Integer(request.getParameter("shopId"));
				
				//開始查詢資料
				ShopService sSvc = new ShopService();
				ShopVO shopVO = sSvc.getoneshop(shopId);
				
				//查詢完成，準備轉交
				session.setAttribute("shopVO", shopVO);
				String url = "/Admin/update_shop_input.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);
				return;
			} catch (Exception e) {
				errorMsgs.put("error","無法取得資料");
				RequestDispatcher rd = request.getRequestDispatcher("/Admin/listAll.jsp");
				rd.forward(request, response);
				return;
			}
		}
		
		
		
		//確認更新，準備寫入資料庫
		if ("updateShop".equals(action)) {
			Map<String,String> errorMsgs = new HashMap<String,String>();
			request.setAttribute("errorMsgs", errorMsgs);
			HttpSession session = request.getSession();
			
			Integer shopId = new Integer(request.getParameter("shopId").trim());
			String shopAcc = request.getParameter("shopAcc").trim();
			String shopPswd = request.getParameter("shopPswd").trim();
			String shopName = request.getParameter("shopName");
			String shopIdd = request.getParameter("shopIdd").trim();
			String shopTel = request.getParameter("shopTel");
			String shopMail = request.getParameter("shopMail");
			String shopLine = request.getParameter("shopLine");
			Integer status = new Integer(request.getParameter("status"));
			
			if (shopName == null || shopName.trim().length() == 0 || shopName.trim().length() > 4)
				errorMsgs.put("Name", "姓名格式錯誤，不得為零或大於4個國字");
			
			if (shopTel == null || shopTel.trim().length() == 0 || shopTel.trim().length() > 10)
				errorMsgs.put("Tel", "電話格式錯誤，不得為零或大於10");
			
			if (shopMail == null || shopMail.trim().length() == 0)
				errorMsgs.put("Mail", "信箱格式錯誤，不得為零");
			
			if (shopLine == null || shopLine.trim().length() == 0)
				errorMsgs.put("Line", "Line格式錯誤，不得為零");
			
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher rd = request.getRequestDispatcher("/Admin/update_shop_input.jsp");
				rd.forward(request, response);
				return;
			}
			
			try {
				shopName = request.getParameter("shopName").trim();
				shopTel = request.getParameter("shopTel").trim();
				shopMail = request.getParameter("shopMail").trim();
				shopLine = request.getParameter("shopLine").trim();
				
				ShopVO shopVO = new ShopVO();
				shopVO.setShopId(shopId);
				shopVO.setShopAccount(shopAcc);
				shopVO.setShopPswd(shopPswd);
				shopVO.setShopName(shopName);
				shopVO.setShopIdd(shopIdd);
				shopVO.setShopTel(shopTel);
				shopVO.setShopEmail(shopMail);
				shopVO.setSlineId(shopLine);
				shopVO.setStatus(status);
				if (!errorMsgs.isEmpty()) {
					errorMsgs.put("error", "更新失敗");
					session.setAttribute("shopVO", shopVO);
					RequestDispatcher rd = request.getRequestDispatcher("/Admin/update_shop_input.jsp");
					rd.forward(request, response);
					return;
				}
				ShopService sSvc = new ShopService();
				shopVO = sSvc.update(shopId, shopAcc, shopPswd, shopName, shopIdd, shopTel, shopMail, shopLine,status);
				
				//修改完成，準備轉交
				List<ShopVO> listShop = sSvc.getAll();
				session.setAttribute("listShop", listShop);
				
				loginService lSvc = new loginService();
				lSvc.updateShop(shopVO);
				
				String url = "/Admin/listAll.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);
				return;
			} catch (Exception e) {
				errorMsgs.put("error","更新失敗");
				RequestDispatcher rd = request.getRequestDispatcher("/Admin/update_shop_input.jsp");
				rd.forward(request, response);
				return;
			}
		}
		
		if ("getMemUpdate".equals(action)) {
			Map<String,String> errorMsgs = new HashMap<String,String>();
			request.setAttribute("errorMsgs", errorMsgs);
			HttpSession session = request.getSession();
			
			try {
				//接收請求
				Integer memId = new Integer(request.getParameter("memId"));
				
				//開始查詢資料
				MemberService mSvc = new MemberService();
				MemberListVO memVO = mSvc.getOneEmp(memId);
				
				//查詢完成，準備轉交
				session.setAttribute("memVO", memVO);
				String url = "/Admin/update_mem_input.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);
				return;
			} catch (Exception e) {
				errorMsgs.put("error","無法取得資料");
				RequestDispatcher rd = request.getRequestDispatcher("/Admin/listAll.jsp");
				rd.forward(request, response);
				return;
			}
		}
		
		if ("updateMem".equals(action)) {
			Map<String,String> errorMsgs = new HashMap<String,String>();
			request.setAttribute("errorMsgs", errorMsgs);
			HttpSession session = request.getSession();
			byte[] data = null;
			
			Integer memId = new Integer(request.getParameter("memId").trim());
			String memAcc = request.getParameter("memAcc").trim();
			String memPswd = request.getParameter("memPswd").trim();
			Integer memSex = new Integer(request.getParameter("memSex").trim());
			java.sql.Date memBirth = java.sql.Date.valueOf(request.getParameter("memBirth").trim());
			String memAddr = request.getParameter("memAddr").trim();
			String fileName = request.getParameter("fileName").trim();
			String memName = request.getParameter("memName");
			String memTel = request.getParameter("memTel");
			String memMail = request.getParameter("memMail");
			String memLine = request.getParameter("memLine");
			Integer status = new Integer(request.getParameter("status"));
			
			
			if (memName == null || memName.trim().length() == 0 || memName.trim().length() > 4)
				errorMsgs.put("Name", "姓名格式錯誤，不得為零或大於4個國字");
			
			if (memTel == null || memTel.trim().length() == 0 || memTel.trim().length() > 10)
				errorMsgs.put("Tel", "電話格式錯誤，不得為零或大於10");
			
			if (memMail == null || memMail.trim().length() == 0)
				errorMsgs.put("Mail", "信箱格式錯誤，不得為零");
			
			if (memLine == null || memLine.trim().length() == 0)
				errorMsgs.put("Line", "Line格式錯誤，不得為零");
			
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher rd = request.getRequestDispatcher("/Admin/update_mem_input.jsp");
				rd.forward(request, response);
				return;
			}
			
			
			try {
				memName = request.getParameter("memName").trim();
				memMail = request.getParameter("memMail").trim();
				memLine = request.getParameter("memLine").trim();
				memTel = request.getParameter("memTel").trim();
				
				
				MemberService mSvc = new MemberService();
				MemberListVO mmmVO = mSvc.getOneEmp(memId);
				
				data = mmmVO.getMemberImage();
				
				MemberListVO memVO = new MemberListVO();		
				memVO.setMemId(memId);
				memVO.setMemAccount(memAcc);
				memVO.setMemPswd(memPswd);
				memVO.setMemName(memName);
				memVO.setSex(memSex);
				memVO.setBirthday(memBirth);
				memVO.setEmail(memMail);
				memVO.setMlineId(memLine);
				memVO.setMemTel(memTel);
				memVO.setMemAddr(memAddr);
				memVO.setMemberImage(data);
				memVO.setFileName(fileName);
				memVO.setStatus(status);
				
				if (!errorMsgs.isEmpty()) {
					errorMsgs.put("error", "更新失敗");
					session.setAttribute("memVO", memVO);
					RequestDispatcher rd = request.getRequestDispatcher("/Admin/update_mem_input.jsp");
					rd.forward(request, response);
					return;
				}
				memVO = mSvc.update(memId, memAcc, memPswd, memName, memSex, memBirth, memMail, memLine, memTel, memAddr, data, fileName,status);
				
				//修改完成，準備轉交
				loginService lgsrv = new loginService();
				lgsrv.updateMember(memVO);
				List<MemberListVO> listMem = mSvc.getAll();
				session.setAttribute("listMem", listMem);
				
				String url = "/Admin/listAll.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);
				return;
			} catch (Exception e) {
				errorMsgs.put("error","更新失敗");
				RequestDispatcher rd = request.getRequestDispatcher("/Admin/update_mem_input.jsp");
				rd.forward(request, response);
				return;
			}
		}
		if ("listAll".equals(action)) {
			Map<String,String> errorMsgs = new HashMap<String,String>();
			request.setAttribute("errorMsgs", errorMsgs);
			HttpSession session = request.getSession();
			
			try {
			
			ShopService sSvc = new ShopService();
			List<ShopVO> listShop = sSvc.getAll();
			session.setAttribute("listShop", listShop);
				
			MemberService mSvc = new MemberService();
			List<MemberListVO> listMem = mSvc.getAll();
			session.setAttribute("listMem",listMem);
			
			String url = "/Admin/listAll.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(url);
			rd.forward(request, response);
			return;
			} catch (Exception e) {
				errorMsgs.put("error", "取得資料失敗");
				String url = "/Admin/listAll.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);
				return;
			}
		}
		
		if ("listAllOrder".equals(action)) {
			Map<String,String> errorMsgs = new HashMap<String,String>();
			request.setAttribute("errorMsgs", errorMsgs);
			HttpSession session = request.getSession();
			
			try {
			
			
			OrderService oSvc = new OrderService();
			List<OrderVO> listAllOrder = oSvc.getAll();
			session.setAttribute("listAllOrder",listAllOrder);
			
			String url = "/Admin/listAllOrder.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(url);
			rd.forward(request, response);
			return;
			} catch (Exception e) {
				errorMsgs.put("error", "取得資料失敗");
				String url = "/Admin/listAllOrder.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);
				return;
			}
		}
		
		if ("listAllRest".equals(action)) {
			Map<String,String> errorMsgs = new HashMap<String,String>();
			request.setAttribute("errorMsgs", errorMsgs);
			HttpSession session = request.getSession();
			
			try {
			
			RestService rSvc = new RestService();
			
			List<RestVO> listAllRest = rSvc.getAllRest();
			
			session.setAttribute("listAllRest", listAllRest);
			
			String url = "/Admin/listAllRest.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(url);
			rd.forward(request, response);
			return;
			} catch (Exception e) {
				errorMsgs.put("error", "取得資料失敗");
				RequestDispatcher rd = request.getRequestDispatcher("/Admin/listAllRest.jsp");
				rd.forward(request, response);
				return;
			}
		}
		
		if ("getShopRest".equals(action)) {
			Map<String,String> errorMsgs = new HashMap<String,String>();
			Integer shopId = new Integer(request.getParameter("shopId").trim());
			HttpSession session = request.getSession();
			
			try {
				RestService rSvc = new RestService();
				List<RestVO> list = rSvc.findByShopId(shopId);
				
				session.setAttribute("list", list);
				
				String url="/Admin/AdminlistOneRest.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);
				return;
			} catch (Exception e) {
				errorMsgs.put("error", "無法顯示資料");
				RequestDispatcher rd = request.getRequestDispatcher("/Admin/listAll.jsp");
				rd.forward(request, response);
				return;
			}
		}
		
	}
}
