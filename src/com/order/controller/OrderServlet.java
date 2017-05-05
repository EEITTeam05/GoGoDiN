package com.order.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
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

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import com.member.Model.MemberListVO;
import com.member.Model.MemberService;
import com.order.Model.OrderService;
import com.order.Model.OrderVO;
import com.rest.Model.RestService;
import com.rest.Model.RestVO;
import com.search.Model.SearchService;

@WebServlet("/OrderServlet.do")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
		String restName = request.getParameter("restName");
		String pickdate = request.getParameter("orderdate");
		Integer pNum = new Integer(request.getParameter("pNum"));
		String action = request.getParameter("action");
		
		Integer restId = null;
		RestVO restVO = null;
		
		if(action.equals("add")){
			try{
				SearchService searchsrv = new SearchService();
				 restVO  = searchsrv.getOneRest(restName);
				 restId = restVO.getRestId();
			}catch (Exception e) {			
				e.printStackTrace();
			}
			
			try{
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				SimpleDateFormat timesdf = new SimpleDateFormat("HH:mm:ss");
				java.util.Date date = sdf.parse(pickdate);
				OrderService orderService = new OrderService();
				List<Object[]> orderlist = orderService.getSeat(new Date(date.getTime()), restId);
				//抓出訂單中[總人數,時間]的陣列
				/* 例如
				 * 傳入參數 (日期=2017-04-24 , restId=3)
				 *  
				 * 回傳List裡面裝
				 * [[28,19:00:00],[12,20:00:00],[20,23:00:00]]
				 * 
				 * 意思是在2017-04-24 這天 restId=3這個餐廳的訂單中已經有
				 * 28個人在19:00的時候預約
				 * 12個人在20:00的時候預約
				 * 20個人在23:00的時候預約
				 */
				
				List<List<String>> timelist = new ArrayList<>();
				for(Object[] list : orderlist){
					/* 
					 * 如果 (訂單中該時間的總人數   + 表單選擇的人數)  > 餐廳能容納的人數 
					 * 傳出一個 list 
					 * 例如.[["19:00:00","19:59:00"],["23:00:00","23:59:00"]]
					 * 以上代表 19點 及23點  都 "無法"在預約
					 * 
					 */
					if(((long) list[0]) + pNum > restVO.getRestNum()){
						List<String> timelist2 = new ArrayList<>();
						Calendar cal = Calendar.getInstance();
						cal.setTime(new Date(timesdf.parse((list[1].toString())).getTime()));
						
						timelist2.add(new Time(cal.getTime().getTime()).toString());
						cal.add(Calendar.MINUTE, +59);
					    timelist2.add(new Time(cal.getTime().getTime()).toString());
					    
					    timelist.add(timelist2);
					}
				}
				JSONObject jsob = new JSONObject();
				jsob.put("array", timelist);
				out.print(jsob);
			}catch (Exception se) {
				se.printStackTrace();
				System.out.println(123);
			}
		}
		
		if(action.equals("update")){
			try{
				SearchService searchsrv = new SearchService();
				 restVO  = searchsrv.getOneRest(restName);
				 restId = restVO.getRestId();
			}catch (Exception e) {			
				e.printStackTrace();
			}
			
			try{
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				SimpleDateFormat timesdf = new SimpleDateFormat("HH:mm:ss");
				java.util.Date date = sdf.parse(pickdate);
				OrderService orderService = new OrderService();
				List<Object[]> orderlist = orderService.getSeat(new Date(date.getTime()), restId);
				//抓出訂單中[總人數,時間]的陣列
				/* 例如
				 * 傳入參數 (日期=2017-04-24 , restId=3)
				 *  
				 * 回傳List裡面裝
				 * [[28,19:00:00],[12,20:00:00],[20,23:00:00]]
				 * 
				 * 意思是在2017-04-24 這天 restId=3這個餐廳的訂單中已經有
				 * 28個人在19:00的時候預約
				 * 12個人在20:00的時候預約
				 * 20個人在23:00的時候預約
				 */
				
				List<List<String>> timelist = new ArrayList<>();
				for(Object[] list : orderlist){
					/* 
					 * 如果 (訂單中該時間的總人數   + 表單選擇的人數)  > 餐廳能容納的人數 
					 * 傳出一個 list 
					 * 例如.[["19:00:00","19:59:00"],["23:00:00","23:59:00"]]
					 * 以上代表 19點 及23點  都 "無法"在預約
					 * 
					 */
					if(((long) list[0]) + pNum > restVO.getRestNum()){
						List<String> timelist2 = new ArrayList<>();
						Calendar cal = Calendar.getInstance();
						cal.setTime(new Date(timesdf.parse((list[1].toString())).getTime()));
						
						timelist2.add(new Time(cal.getTime().getTime()).toString());
						cal.add(Calendar.MINUTE, +59);
					    timelist2.add(new Time(cal.getTime().getTime()).toString());
					    
					    timelist.add(timelist2);
					}
				}
				JSONObject jsob = new JSONObject();
				jsob.put("array", timelist);
				out.print(jsob);
			}catch (Exception se) {
				se.printStackTrace();
				System.out.println(123);
			}
		}
		
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
