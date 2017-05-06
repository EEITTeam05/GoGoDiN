package mailserivce;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.login_Model.loginService;
import com.member.Model.MemberListVO;

@WebServlet("/MailServlet")
public class MailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		Map<String, String> errorMsg = new HashMap<String, String>();
		request.setAttribute("errorMsg", errorMsg);

		String mail = request.getParameter("email");
		try {
			loginService login = new loginService();
			MemberListVO vo = login.getMemberList().get(mail);
			if (vo != null) {
				MailService pass = new MailService();
				pass.sendMail(vo.getEmail(), "GoGoDiN-忘記密碼通知" , vo.getMemName() + "你好: http://localhost:8080/" + request.getContextPath()
						+ "/modifyPass.jsp?account=" + vo.getMemAccount());
				RequestDispatcher re = request.getRequestDispatcher("index.jsp");
				re.forward(request, response);
				return;
			} else {
				errorMsg.put("errormail", "email不存在");
				RequestDispatcher re = request.getRequestDispatcher("forgetpass.jsp");
				re.forward(request, response);
				return;
			}
		} catch (Exception e) {
			e.getMessage();
		}

	}

}
