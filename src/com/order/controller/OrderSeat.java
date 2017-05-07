package com.order.controller;

import java.io.IOException;
import java.sql.Date;
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

import com.member.Model.MemberListVO;
import com.order.Model.OrderService;
import com.order.Model.OrderVO;
import com.rest.Model.RestVO;
import com.search.Model.SearchService;
import com.shop.Model.ShopService;

import message.Model.MessageService;

@WebServlet("/OrderSeat.do")
public class OrderSeat extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		Map<String, String> errorMsgs = new HashMap<String, String>();
		String restName = request.getParameter("restName");
		MemberListVO mb = (MemberListVO) session.getAttribute("LoginOK");
		Integer memId = null;
		Integer restId = null;
		Integer shopId = null;
		try {
			SearchService searchsrv = new SearchService();
			RestVO restVO = searchsrv.getOneRest(restName);
			restId = restVO.getRestId();
			shopId = restVO.getShopId();
		} catch (Exception e) {
			e.printStackTrace();
		}
		String date1 = request.getParameter("orderdate");
		String time1 = request.getParameter("ordertime");
		String pNum = request.getParameter("pNum");
		String action = request.getParameter("action");
		Timestamp bidtime = new Timestamp(System.currentTimeMillis());

		if (action.equals("add")) {
			
			memId = mb.getMemId();

			try { // 從form表單取得使用者輸入的日期只是個字串所以這邊才要轉型唷!

				// 新增訂位資訊至SQL
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				java.util.Date date2 = sdf.parse(date1);
				long londay = date2.getTime();
				SimpleDateFormat sdftime = new SimpleDateFormat("HH:mm");
				Date tsday = new Date(londay);
				Time time2 = new Time(sdftime.parse(time1).getTime());
				OrderService oSvc = new OrderService();
				oSvc.addOrder(memId, shopId, restId, tsday, time2, Integer.parseInt(pNum), bidtime, false, 0);

				/* 寄送訂位成功通知 */
				RestVO restVO = new SearchService().getRestMap().get(restName);
				String Title = "訂位成功-通知";
				StringBuffer message = new StringBuffer();
				message.append("恭喜您在[" + restVO.getRestName() + "] 餐廳訂位成功"+(char)13)
						.append("預位時間:" + date1 + "  " + time1 + (char)13).append("訂位人數:" + pNum + "人");
				/*
				 * 
				 * 
				 * 
				 * mailType 1= 一般寄信     2= 訂位通知(業主寄給會員)  3= 系統通知(管理者寄給業主)  
				 *            ********     *********************     **********************
				 *
				 *
				 */ 
				
				String MemAccount = mb.getMemAccount();
				String ShopAccount = new ShopService().getoneshop(shopId).getShopAccount();
				MessageService msgsrv = new MessageService();
				// 收信者 寄件者
				msgsrv.addMessage(MemAccount, ShopAccount, Title,message.toString(), false,2,
						new Timestamp(System.currentTimeMillis()));

				message.delete(0, message.length());// 清空內容

				message.append(mb.getMemName() + "在你的  [" + restVO.getRestName() + "] 餐廳訂位成功 " +(char)13)
						.append("訂單人姓名:" + mb.getMemName() + (char)13).append("訂單時間:" + date1 + "  " + time1 + (char)13)
						.append("訂位人數:" + pNum + "人");
				// 收信者 寄件者
				msgsrv.addMessage(ShopAccount,MemAccount, Title, message.toString(), false, 2 ,
						new Timestamp(System.currentTimeMillis()));

				return;
			} catch (Exception e) {
				errorMsgs.put("無法取得資料", e.getMessage());
				RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
				rd.forward(request, response);
				e.printStackTrace();
			}
		}
		
		
		
		
		
		if (action.equals("update")) {
			
			OrderVO odVO =(OrderVO)session.getAttribute("OrderVO");
			
			Integer OrderNum = odVO.getOrderNum();
			memId  = odVO.getMemVO().getMemId();
			shopId = odVO.getShopId();
			restId = odVO.getRestVO().getRestId();

			try { // 從form表單取得使用者輸入的日期只是個字串所以這邊才要轉型唷!

				// 新增訂位資訊至SQL
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				java.util.Date date2 = sdf.parse(date1);
				long londay = date2.getTime();
				SimpleDateFormat sdftime = new SimpleDateFormat("HH:mm");
				Date tsday = new Date(londay);
				Time time2 = new Time(sdftime.parse(time1).getTime());
				OrderService oSvc = new OrderService();
				oSvc.update(OrderNum, memId, shopId, restId, tsday, time2, Integer.parseInt(pNum), bidtime, false, 0);
				
				//更新session裡的listOrderDetail
				List<OrderVO> listOrderDetail = oSvc.findByRestId(restId);
				session.setAttribute("listOrderDetail",listOrderDetail);
				
				/*
				 * 
				 * 
				 * 
				 * mailType 1= 一般寄信     2= 訂位通知(業主寄給會員)  3= 系統通知(管理者寄給業主)  
				 *            ********     *********************     **********************
				 *
				 *
				 */ 
				
				/* 寄送訂位成功通知 */
				RestVO restVO = new SearchService().getRestMap().get(restName);
				String Title = "修改訂位-通知";
				StringBuffer message = new StringBuffer();
				message.append("您在[" + restVO.getRestName() + "] 餐廳訂位資料已修改成功"+(char)10)
						.append("預位時間:" + date1 + "  " + time1 + (char)13).append("訂位人數:" + pNum + "人");
					
				String MemAccount = odVO.getMemVO().getMemAccount();
				String ShopAccount = new ShopService().getoneshop(shopId).getShopAccount();
				MessageService msgsrv = new MessageService();
				// 收信者 寄件者
				msgsrv.addMessage(MemAccount, "系統通知", Title ,message.toString(), false, 3,
						new Timestamp(System.currentTimeMillis()));

				message.delete(0, message.length());// 清空內容

				message.append("您剛剛已修改 [" + restVO.getRestName() + "] 餐廳訂位資料"+(char)13)
						.append("訂單人姓名:" + odVO.getMemVO().getMemName() + (char)13).append("訂單時間:" + date1 + "  " + time1 + (char)13)
						.append("訂位人數:" + pNum + "人");
				// 收信者 寄件者
				msgsrv.addMessage(ShopAccount, "系統通知" , Title ,message.toString(), false,3,
						new Timestamp(System.currentTimeMillis()));

				return;
			} catch (Exception e) {
				errorMsgs.put("無法取得資料", e.getMessage());
				RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
				rd.forward(request, response);
				e.printStackTrace();
			}
		}
	}

}
