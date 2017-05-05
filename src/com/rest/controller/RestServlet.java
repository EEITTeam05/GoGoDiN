package com.rest.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.img.Io.ImagesIo;
import com.rest.Model.RestService;
import com.rest.Model.RestVO;
import com.restPhoto.Model.RestPhotoService;
import com.search.Model.SearchService;

import register.controller.RegisterServlet;

@MultipartConfig(location = "", fileSizeThreshold = 1024 * 1024, // 超過file-size-threshold的檔案request將會以臨時暫存的方式存到硬碟中，預設為0
maxFileSize = 1024 * 1024 * 50, maxRequestSize = 1024 * 1024 * 50 * 5)

@WebServlet("/Shop/publish.do")
public class RestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");

		Map<String, String> errorMsg = new HashMap<String, String>();

		Map<String, String> msgOK = new HashMap<String, String>();

		HttpSession session = request.getSession();

		request.setAttribute("MsgMap", errorMsg);

		session.setAttribute("MsgOK", msgOK);
		Integer ShopId = 0;
		String RestName = "";
		String RestTel = "";
		String RestAddr = "";
		Integer Ein = 0;
		Time RestStartDay = new Time(System.currentTimeMillis());
		Time RestEndDay = new Time(System.currentTimeMillis());
		Integer RestNum = 0;
		String fileName0 = "";
		String fileName1 = "";
		String fileName2 = "";
		String fileName3 = "";
		String brief = "尚無簡介";
		Integer status = 0;
		Integer money = 0;
		InputStream is0 = null;
		InputStream is1 = null;
		InputStream is2 = null;
		InputStream is3 = null;
		
		
		Collection<Part> parts = request.getParts();
		if(parts!=null){
			for(Part p :parts){
				String fldName = p.getName();
				String value = request.getParameter(fldName);
				if(p.getContentType() == null){
					if(fldName.equals("RestName")){
						RestName = value;
					}else if(fldName.equals("RestTel")){
						RestTel  = value;
					}else if(fldName.equals("RestAddr")){
						RestAddr = value;
					}else if(fldName.equals("ShopId")){
						ShopId = Integer.parseInt(value);
					}else if(fldName.equals("Ein")){
						try{
							Ein = Integer.parseInt(value);
						}catch (Exception e) {
							errorMsg.put("errorEinEmpty", "統一編號欄格式錯誤");
						}
					}else if(fldName.equals("StartDay")){
						try{
							RestStartDay = Time.valueOf(value+":00");
						}catch (Exception e) {
							errorMsg.put("errorStartDay", "刊登日期欄格式錯誤");
						}
					}else if(fldName.equals("EndDay")){
						try{
						RestEndDay = Time.valueOf(value+":00");
						}catch (Exception e) {
							errorMsg.put("errorEndDay", "截止日期欄格式錯誤");
						}
					}else if(fldName.equals("RestNum")){
						try{
						RestNum = Integer.parseInt(value);
						}catch (Exception e) {
							errorMsg.put("errorRestNum", "刊登人數欄格式錯誤");
						}
					}else if(fldName.equals("brief") && fldName!= null){
						try{
							brief = value;
						}catch (Exception e) {
							errorMsg.put("errorBrief", "刊登簡介欄格式錯誤");
						}
					}else if(fldName.equals("money") && fldName!= null){
						try{
							money = Integer.parseInt(value);
						}catch (Exception e) {
							errorMsg.put("errorMoney", "價錢欄格式錯誤");
						}
					}
				}else if(fldName.equals("file0")){
					fileName0 = RegisterServlet.getFileName(p);
					if(fileName0 !=null && fileName0.trim().length() > 0){						
						is0 = p.getInputStream();
					}else{
						errorMsg.put("errPicture", "必須挑選圖片檔");// 顯示要使用者挑選圖片檔
					}
					
				}else if(fldName.equals("file1")){
					fileName1 = RegisterServlet.getFileName(p);
					if(fileName1 !=null && fileName1.trim().length() > 0){						
						is1 = p.getInputStream();
					}else{
						errorMsg.put("errPicture", "必須挑選圖片檔");// 顯示要使用者挑選圖片檔
					}
					
				}else if(fldName.equals("file2")){
					fileName2 = RegisterServlet.getFileName(p);
					if(fileName2 !=null && fileName2.trim().length() > 0){						
						is2 = p.getInputStream();
					}else{
						errorMsg.put("errPicture", "必須挑選圖片檔");// 顯示要使用者挑選圖片檔
					}
					
				}else if(fldName.equals("file3")){
					fileName3 = RegisterServlet.getFileName(p);
					if(fileName3 !=null && fileName3.trim().length() > 0){						
						is3 = p.getInputStream();
					}else{
						errorMsg.put("errPicture", "必須挑選圖片檔");// 顯示要使用者挑選圖片檔
					}
					
				}
			}
			
			SearchService srv = null;
			try {
				srv = new SearchService();
				if(srv.getRestMap().containsKey(RestName)){
					errorMsg.put("errorRestNameEmpty", "餐廳名稱欄已存在");
				};
			} catch (SQLException e) {
				e.printStackTrace();
			}
			if(RestName == null || RestName.trim().length()==0)
				errorMsg.put("errorRestNameEmpty", "餐廳名稱欄必須輸入");
			
			if(RestTel==null||RestTel.trim().length()==0)
				errorMsg.put("errorRestTel", "餐廳電話欄必須輸入");
			if(RestAddr==null||RestAddr.trim().length()==0)
				errorMsg.put("errorRestAddr", "餐廳地址欄必須輸入");
			if(brief==null||brief.trim().length()==0)
				errorMsg.put("errorBrief", "餐廳簡介欄必須輸入");
			if(!errorMsg.isEmpty()){
				RequestDispatcher rd = request.getRequestDispatcher("Publish.jsp");
				rd.forward(request, response);
				return;
			}
			
		}
		try{
			ImagesIo io = new ImagesIo();
			
			RestService rserv = new RestService();			
			
			byte [] data0 = io.isToByte(is0);
			
			RestVO restVO = rserv.addRest(ShopId,RestName, RestTel, RestAddr, Ein, RestStartDay, RestEndDay, 80, RestNum, data0 , fileName0, brief,0,money);
			SearchService srv = new SearchService();
			srv.addNewRest(restVO);
			Integer restId = restVO.getRestId();
			
			RestPhotoService rpsc = new RestPhotoService();
			
			byte [] data1 = io.isToByte(is1);
			
			byte [] data2 = io.isToByte(is2);
			
			byte [] data3 = io.isToByte(is3);
			
			rpsc.addRestPhoto(restId, data1, fileName1, data2, fileName2, data3, fileName3);			
			
			response.sendRedirect("../index.jsp");// 並請導向首頁!
			return;
		}catch (Exception e) {
			e.printStackTrace();
			errorMsg.put("errorIDDup", e.getMessage());
			RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
			rd.forward(request, response);
			return;
		}
		finally {
			try {
				Thread.sleep(1500);
			} catch (InterruptedException e) {			
				e.printStackTrace();
			}
			is3.close();
			is2.close();
			is1.close();
			is0.close();
		}
	}

}
