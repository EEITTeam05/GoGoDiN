package message.Model;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
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

import com.admin.Model.AdminVO;
import com.login_Model.loginService;
import com.member.Model.MemberListVO;
import com.member.Model.MemberService;
import com.rest.Model.RestService;
import com.rest.Model.RestVO;
import com.search.Model.SearchService;
import com.shop.Model.ShopService;
import com.shop.Model.ShopVO;

import message.Model.*;
import register.model.RegisterServiceDAO;

@WebServlet("/MessageServlet")
public class MessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MessageServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		/* 判斷查信件者身分 */
		MemberListVO mb = (MemberListVO) session.getAttribute("LoginOK");
		ShopVO svo = (ShopVO) session.getAttribute("ShopLoginOK");
		AdminVO admin = (AdminVO) session.getAttribute("AdminLoginOK");
		String action = request.getParameter("action");
		String Account = null;
		MessageService msrv = new MessageService();
		if ("getMymail".equals(action)) {
			/* 判斷查信件者身分 */
			if (mb != null) {
				Account = mb.getMemAccount();
			} else if (svo != null) {
				Account = svo.getShopAccount();
			} else if (admin != null) {
				Account = admin.getAdminAcc();
			}
			List<MessageVO> list = msrv.getReceive(Account);
			for(MessageVO messageVO : list){
				if(!messageVO.getIsRead()){
					msrv.updateIsRead(messageVO.getMesId());
				}
			}
			request.setAttribute("list", list);
			RequestDispatcher rd = request.getRequestDispatcher("allmail.jsp");
			rd.forward(request, response);
			return;
		}
		if("getIsRead".equals(action)){
						/* 判斷查信件者身分 */
			if (mb != null) {
				Account = mb.getMemAccount();
			} else if (svo != null) {
				Account = svo.getShopAccount();
			} else if (admin != null) {
				Account = admin.getAdminAcc();
			}
			
			out.print(msrv.getIsNotReadCount(Account).toString());
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		MemberListVO mb = (MemberListVO) session.getAttribute("LoginOK");
		String RestName = request.getParameter("RestName");
		String Message = request.getParameter("Message");
		String action = request.getParameter("action");
		if ("MemberSendToShop".equals(action)) {
			try {
				RestVO restVO = new SearchService().getRestMap().get(RestName);
				ShopService srv = new ShopService();
				String shopAccount = srv.getoneshop(restVO.getShopId()).getShopAccount();
				String MemAccount = mb.getMemAccount();
				MessageService msgsrv = new MessageService();
				msgsrv.addMessage(shopAccount, MemAccount, Message, false, new Timestamp(System.currentTimeMillis()));
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}
		}
	}
}
