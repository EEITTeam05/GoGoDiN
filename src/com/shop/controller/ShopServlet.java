package com.shop.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
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

import org.json.simple.JSONObject;

import com.admin.Model.AdminVO;
import com.img.Io.ImagesIo;
import com.login_Model.loginService;
import com.member.Model.MemberListVO;
import com.member.Model.MemberService;
import com.member.controller.MemberServlet;
import com.order.Model.OrderService;
import com.order.Model.OrderVO;
import com.rest.Model.RestService;
import com.rest.Model.RestVO;
import com.restPhoto.Model.RestPhotoService;
import com.restPhoto.Model.RestPhotoVO;
import com.search.Model.SearchService;
import com.shop.Model.ShopService;
import com.shop.Model.ShopVO;

import register.controller.RegisterServlet;

@MultipartConfig(location = "", fileSizeThreshold = 1024 * 1024, // 超過file-size-threshold的檔案request將會以臨時暫存的方式存到硬碟中，預設為0
		maxFileSize = 1024 * 1024 * 50, maxRequestSize = 1024 * 1024 * 50 * 5)
@WebServlet("/Shop/ShopServlet")
public class ShopServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if ("listRest".equals(action)) {
			Map<String, String> errorMsgs = new HashMap<String, String>();
			request.setAttribute("errorMsgs", errorMsgs);

			try {
				HttpSession session = request.getSession();
				ShopVO sVo = (ShopVO) session.getAttribute("ShopLoginOK");
				Integer shopId = sVo.getShopId();

				RestService rSvc = new RestService();
				List<RestVO> listRest = rSvc.findByShopId(shopId);

				session.setAttribute("listRest", listRest);

				String url = "/Shop/listRest.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);
				return;
			} catch (Exception e) {
				errorMsgs.put("error", "取得資料失敗");
				RequestDispatcher rd = request.getRequestDispatcher("/Shop/listRest.jsp");
				rd.forward(request, response);
				return;
			}

		}
		if ("OrderCount".equals(action)) {
			Map<String, String> errorMsgs = new HashMap<String, String>();
			request.setAttribute("errorMsgs", errorMsgs);

			PrintWriter out = response.getWriter();
			HttpSession session = request.getSession();
			ShopVO sVO = (ShopVO) session.getAttribute("ShopLoginOK");
			Integer shopId = sVO.getShopId();

			try {
				OrderService oSvc = new OrderService();
				List<Object[]> list = oSvc.getOrderCount(shopId);
				List<Map<String, String>> m2 = new ArrayList<>();
				for (Object[] object : list) {
					Map<String, String> m1 = new HashMap<>();
					m1.put("start", String.valueOf(object[0]));
					m1.put("title", String.valueOf(object[1]));
					m2.add(m1);
				}
				JSONObject jsob = new JSONObject();
				jsob.put("count", m2);
				// System.out.println(m2);
				out.print(jsob);
			} catch (Exception e) {
				errorMsgs.put("error", "取得資料失敗");
			}
		}

		if ("OrderCalendar".equals(action)) {
			Map<String, String> errorMsgs = new HashMap<String, String>();
			request.setAttribute("errorMsgs", errorMsgs);

			PrintWriter out = response.getWriter();
			HttpSession session = request.getSession();
			ShopVO sVO = (ShopVO) session.getAttribute("ShopLoginOK");
			Integer shopId = sVO.getShopId();
			Date date = Date.valueOf(request.getParameter("date"));

			try {
				OrderService oSvc = new OrderService();

				List<Object[]> list = oSvc.findByDate(shopId, date);
				List<Map<String, String>> m2 = new ArrayList<>();
				for (Object[] object : list) {
					Map<String, String> m1 = new HashMap<>();
					m1.put("order1", String.valueOf(object[0]));
					m1.put("order2", String.valueOf(object[1]));
					m1.put("order3", String.valueOf(object[2]));
					m1.put("order4", String.valueOf(object[3]));
					m1.put("order5", String.valueOf(object[4]));
					m2.add(m1);
				}
				JSONObject jsob = new JSONObject();
				// String jsonString = JSONValue.toJSONString(m2);
				jsob.put("array", m2);
				// System.out.println(m2);
				out.print(jsob);

			} catch (Exception e) {
				errorMsgs.put("error", "取得資料失敗");
			}
		}
		if ("listOrder".equals(action)) {
			Map<String, String> errorMsgs = new HashMap<String, String>();
			request.setAttribute("errorMsgs", errorMsgs);

			HttpSession session = request.getSession();
			ShopVO sVo = (ShopVO) session.getAttribute("ShopLoginOK");
			Integer shopId = sVo.getShopId();

			try {
				OrderService oSvc = new OrderService();
				List<Object[]> listOrder = oSvc.findByShopId(shopId);
				session.setAttribute("listOrder", listOrder);

				String url = "/Shop/listOrder.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);
				return;
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("error", "取得資料失敗");
				RequestDispatcher rd = request.getRequestDispatcher("/Shop/listOrder.jsp");
				rd.forward(request, response);
				return;
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		MemberServlet mbservlet = new MemberServlet();
		// 接收更新請求
		if ("getShopUpdate".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			request.setAttribute("errorMsgs", errorMsgs);
			HttpSession session = request.getSession();
			try {
				// 接收請求
				Integer shopId = new Integer(request.getParameter("shopId"));

				// 開始查詢資料
				ShopService sSvc = new ShopService();
				ShopVO shopVO = sSvc.getoneshop(shopId);

				// 查詢完成，準備轉交
				session.setAttribute("ShopLoginOK", shopVO);
				String url = "/Shop/update_shop_input.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);

			} catch (Exception e) {
				errorMsgs.add("無法取得資料" + e.getMessage());
				RequestDispatcher rd = request.getRequestDispatcher("/Shop/Shop.jsp");
				rd.forward(request, response);
			}
		}

		// 確認更新，準備寫入資料庫
		if ("updateShop".equals(action)) {
			Map<String, String> errorMsgs = new HashMap<String, String>();
			request.setAttribute("errorMsgs", errorMsgs);
			HttpSession session = request.getSession();
			Integer shopId = new Integer(request.getParameter("shopId").trim());
			String shopAcc = request.getParameter("shopAcc").trim();
			String shopPswd = request.getParameter("shopPswd");
			String shopName = request.getParameter("shopName");
			String shopIdd = request.getParameter("shopIdd").trim();
			String shopTel = request.getParameter("shopTel");
			String shopMail = request.getParameter("shopMail");
			String shopLine = request.getParameter("shopLine");
			String fileName = "";
			InputStream is = null;
			byte[] data = null;
			Collection<Part> parts = request.getParts();
			if (parts != null) { // parts裡有東西
				for (Part p : parts) {
					if (p.getContentType() != null) {
						fileName = MemberServlet.getFileName(p);
						if (fileName != null && fileName.trim().length() > 0) {// 判斷檔案名稱							
							is = p.getInputStream();// 能執行到這邊代表要寫入的資料就是圖片,為了準備寫入資料庫,故上面先宣告一個is放著
							ImagesIo io = new ImagesIo();
							data = io.isToByte(is);
						} else {
							ShopService shopsrv = new ShopService();
							ShopVO shopVO = shopsrv.getoneshop(shopId);
							fileName = shopVO.getFileName();							
							data = shopVO.getShopImage();
						}
					}
				}
			}
			if (shopPswd == null || shopPswd.trim().length() == 0 || shopPswd.trim().length() > 12)
				errorMsgs.put("Pswd", "密碼格式錯誤，不得為零或大於12");

			if (shopName == null || shopName.trim().length() == 0 || shopName.trim().length() > 4)
				errorMsgs.put("Name", "姓名格式錯誤，不得為零或大於4個國字");

			if (shopTel == null || shopTel.trim().length() == 0 || shopTel.trim().length() > 10)
				errorMsgs.put("Tel", "電話格式錯誤，不得為零或大於10");

			if (shopMail == null || shopMail.trim().length() == 0)
				errorMsgs.put("Mail", "信箱格式錯誤，不得為零");

			if (shopLine == null || shopLine.trim().length() == 0)
				errorMsgs.put("Line", "Line格式錯誤，不得為零");

			if (!errorMsgs.isEmpty()) {
				RequestDispatcher rd = request.getRequestDispatcher("/Shop/update_shop_input.jsp");
				rd.forward(request, response);
				return;
			}

			try {

				shopPswd = request.getParameter("shopPswd").trim();
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
				shopVO.setShopImage(data);
				shopVO.setFileName(fileName);
				if (!errorMsgs.isEmpty()) {
					request.setAttribute("shopVO", shopVO);
					RequestDispatcher rd = request.getRequestDispatcher("/Shop/update_shop_input.jsp");
					rd.forward(request, response);
					return;
				}
				ShopService sSvc = new ShopService();
				shopVO = sSvc.update(shopId, shopAcc, shopPswd, shopName, shopIdd, shopTel, shopMail, shopLine, 0,data,fileName);
				loginService ls = new loginService();
				ls.updateShop(shopVO);
				// 修改完成，準備轉交
				session.setAttribute("ShopLoginOK", shopVO);
				String url = "/Shop/listOneShop.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);
			} catch (Exception e) {
				errorMsgs.put("修改資料失敗", e.getMessage());
				RequestDispatcher rd = request.getRequestDispatcher("/Shop/update_shop_input.jsp");
				rd.forward(request, response);
			}
		}
		if ("orderDetail".equals(action)) {
			Map<String, String> errorMsgs = new HashMap<String, String>();
			request.setAttribute("errorMsgs", errorMsgs);

			try {

				HttpSession session = request.getSession();
				Integer restId = new Integer(request.getParameter("restId"));

				OrderService oSvc = new OrderService();
				List<OrderVO> listOrderDetail = oSvc.findByRestId(restId);
				session.setAttribute("listOrderDetail", listOrderDetail);

				String url = "/Shop/listOrderDetail.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);
				return;
			} catch (Exception e) {
				errorMsgs.put("error", "取得資料失敗");
				RequestDispatcher rd = request.getRequestDispatcher("/Shop/listOrderDetail.jsp");
				rd.forward(request, response);
				return;
			}
		}
		if ("getOrderUpdate".equals(action)) {
			Map<String, String> errorMsgs = new HashMap<String, String>();
			request.setAttribute("errorMsgs", errorMsgs);

			try {

				HttpSession session = request.getSession();
				Integer orderNum = new Integer(request.getParameter("OrderNum"));

				OrderService oSvc = new OrderService();
				OrderVO orderVO = oSvc.getOrder(orderNum);
				session.setAttribute("OrderVO", orderVO);

				String url = "/Shop/update_order_input.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);
				return;
			} catch (Exception e) {
				errorMsgs.put("error", "取得資料失敗");
				RequestDispatcher rd = request.getRequestDispatcher("/Shop/listOrderDetail.jsp");
				rd.forward(request, response);
				return;
			}
		}

		if ("getRestUpdate".equals(action)) {
			Map<String, String> errorMsgs = new HashMap<String, String>();
			request.setAttribute("errorMsgs", errorMsgs);

			try {
				Integer restId = new Integer(request.getParameter("restId"));

				HttpSession session = request.getSession();
				RestService rSvc = new RestService();
				RestVO restVO = rSvc.getOneRest(restId);

				session.setAttribute("restVO", restVO);

				String url = "/Shop/update_rest_input.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);
				return;
			} catch (Exception e) {
				errorMsgs.put("error", "無法取得資料");
				RequestDispatcher rd = request.getRequestDispatcher("/Shop/listRest.jsp");
				rd.forward(request, response);
				return;
			}
		}
		if ("updateRestMulti".equals(action)) {
			Map<String, String> errorMsg = new HashMap<String, String>();
			HttpSession session = request.getSession();
			request.setAttribute("MsgMap", errorMsg);
			ShopVO sVo = (ShopVO) session.getAttribute("ShopLoginOK");
			AdminVO aVo = (AdminVO) session.getAttribute("AdminLoginOK");
			Integer shopId = 0;
			Integer restId = new Integer(request.getParameter("restId").trim());
			RestVO restVO = new RestService().getOneRest(restId);
			if (sVo != null) {
				shopId = sVo.getShopId();
			}else if(aVo !=null){
				shopId = restVO.getShopId();
			}
			String RestName = "";
			String RestTel = "";
			String RestAddr = "";
			Integer Ein = 0;
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
			RestPhotoService rpsc = new RestPhotoService();
			
			Time restStart = new Time(System.currentTimeMillis());
			Time restEnd = new Time(System.currentTimeMillis());
			Collection<Part> parts = request.getParts();
			if (parts != null) {
				for (Part p : parts) {
					String fldName = p.getName();
					String value = request.getParameter(fldName);
					if (p.getContentType() == null) {
						if (fldName.equals("restName")) {
							RestName = value;
						} else if (fldName.equals("restTel")) {
							RestTel = value;
						} else if (fldName.equals("restaddr")) {
							RestAddr = value;
						} else if (fldName.equals("ein")) {
							try {
								Ein = Integer.parseInt(value);
							} catch (Exception e) {
								errorMsg.put("errorEinEmpty", "統一編號欄格式錯誤");
							}
						} else if (fldName.equals("restNum")) {
							try {
								RestNum = Integer.parseInt(value);
							} catch (Exception e) {
								errorMsg.put("errorRestNum", "刊登人數欄格式錯誤");
							}
						} else if (fldName.equals("brief") && fldName != null) {
							try {
								brief = value;
							} catch (Exception e) {
								errorMsg.put("errorBrief", "刊登簡介欄格式錯誤");
							}
						} else if (fldName.equals("money") && fldName != null) {
							try {
								money = Integer.parseInt(value);
							} catch (Exception e) {
								errorMsg.put("errorMoney", "價錢欄格式錯誤");
							}
						} else if (fldName.equals("restStart") && fldName != null) {
							try {
								restStart = Time.valueOf(request.getParameter("restStart").trim());
							} catch (Exception e) {
								errorMsg.put("errorMoney", "價錢欄格式錯誤");
							}
						} else if (fldName.equals("restEnd") && fldName != null) {
							try {
								restEnd = Time.valueOf(request.getParameter("restEnd").trim());
							} catch (Exception e) {
								errorMsg.put("errorMoney", "價錢欄格式錯誤");
							}
						} else if (fldName.equals("status") && fldName != null) {
							try {
								status = Integer.parseInt(request.getParameter("status"));
							} catch (Exception e) {
								errorMsg.put("errorMoney", "價錢欄格式錯誤");
							}
						}
					} else if (fldName.equals("file0")) {
						fileName0 = RegisterServlet.getFileName(p);
						if (fileName0 != null && fileName0.trim().length() > 0) {
							is0 = p.getInputStream();
						} else {
							
							errorMsg.put("errPicture", "必須挑選圖片檔");// 顯示要使用者挑選圖片檔
						}
					} else if (fldName.equals("file1")) {
						fileName1 = RegisterServlet.getFileName(p);
						if (fileName1 != null && fileName1.trim().length() > 0) {
							is1 = p.getInputStream();
						} else {
							errorMsg.put("errPicture", "必須挑選圖片檔");// 顯示要使用者挑選圖片檔
						}
					} else if (fldName.equals("file2")) {
						fileName2 = RegisterServlet.getFileName(p);
						if (fileName2 != null && fileName2.trim().length() > 0) {
							is2 = p.getInputStream();
						} else {
							errorMsg.put("errPicture", "必須挑選圖片檔");// 顯示要使用者挑選圖片檔
						}
					} else if (fldName.equals("file3")) {
						fileName3 = RegisterServlet.getFileName(p);
						if (fileName3 != null && fileName3.trim().length() > 0) {
							is3 = p.getInputStream();
						} else {
							errorMsg.put("errPicture", "必須挑選圖片檔");// 顯示要使用者挑選圖片檔
						}
					}
				}

				// if(RestName == null || RestName.trim().length()==0)
				// errorMsg.put("errorRestNameEmpty", "餐廳名稱欄必須輸入");
				// if(RestTel==null||RestTel.trim().length()==0)
				// errorMsg.put("errorRestTel", "餐廳電話欄必須輸入");
				// if(RestAddr==null||RestAddr.trim().length()==0)
				// errorMsg.put("errorRestAddr", "餐廳地址欄必須輸入");
				// if(brief==null||brief.trim().length()==0)
				// errorMsg.put("errorBrief", "餐廳簡介欄必須輸入");
				// if(!errorMsg.isEmpty()){
				// RequestDispatcher rd =
				// request.getRequestDispatcher("Publish.jsp");
				// rd.forward(request, response);
				// return;
				// }
			}
			try {
				ImagesIo io = new ImagesIo();
				RestService rserv = new RestService();
				byte[] data0 = null;
				byte[] data1 = null;
				byte[] data2 = null;
				byte[] data3 = null;
				data0 = is0!=null ? io.isToByte(is0):restVO.getRestImage();
				restVO = rserv.update(restId, shopId, RestName, RestTel, RestAddr, Ein, restStart, restEnd, restVO.getRestRate(),
						RestNum, data0, fileName0, brief, status, money);
				SearchService srv = new SearchService();
				srv.updateRest(restVO);
				
				RestPhotoVO restPhotoVO = rpsc.getRePohtos(restId);
				data1 = is1!=null ? io.isToByte(is1):restPhotoVO.getRestImage1();
				data2 = is2!=null ? io.isToByte(is2):restPhotoVO.getRestImage2();
				data3 = is3!=null ? io.isToByte(is3):restPhotoVO.getRestImage3();
				rpsc.update(restPhotoVO.getRePhotoId(), restId, data1, fileName1, data2, fileName2, data3, fileName3);
			} catch (Exception e) {
				e.printStackTrace();
				errorMsg.put("errorIDDup", e.getMessage());
				RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
				rd.forward(request, response);
				return;
			} 
		}
	}
}
