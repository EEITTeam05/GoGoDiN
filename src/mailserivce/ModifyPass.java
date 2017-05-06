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
import com.member.Model.MemberService;

/**
 * Servlet implementation class ModifyPass
 */
@WebServlet("/ModifyPass")
public class ModifyPass extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ModifyPass() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String account = request.getParameter("account");
		String pass = request.getParameter("pass");
		String pass2 = request.getParameter("pass2");
		Map<String, String> error=new HashMap<>();
		request.setAttribute("error", error);
		try {
			loginService login = new loginService();
			
			MemberListVO vo=login.getMemberList().get(account);
    
			if (pass.equals(pass2)) {
				MemberService mbs = new MemberService();
				 mbs.update(vo.getMemId(), vo.getMemAccount(), pass, vo.getMemName(), vo.getSex(),
						vo.getBirthday(), vo.getEmail(), vo.getMlineId(), vo.getMemTel(), vo.getMemAddr(),
						vo.getMemberImage(), vo.getFileName(),vo.getStatus());
				 RequestDispatcher re=request.getRequestDispatcher("index.jsp");
				 re.forward(request, response);
				 return;
			}
			
            else{
            	error.put("error","密碼不相等");
            	RequestDispatcher re=request.getRequestDispatcher("modifypass.jsp");
				 re.forward(request, response);
				 return;
            	
            }
		} catch (Exception e) {
			e.getMessage();
		}

	}

}
