package register.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.img.Io.ImagesIo;
import com.login_Model.loginService;
import com.member.Model.MemberListVO;
import com.member.Model.MemberService;

import oracle.sql.DATE;
import register.model.RegisterServiceDAO;
import register.model.RegisterService_interface;

@MultipartConfig(location = "", fileSizeThreshold = 1024 * 1024, // 超過file-size-threshold的檔案request將會以臨時暫存的方式存到硬碟中，預設為0
		maxFileSize = 1024 * 1024 * 50, maxRequestSize = 1024 * 1024 * 50 * 5)
@WebServlet("/fbregister.do")
public class fbRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		

		HttpSession session = request.getSession();

		

		String Account = "";
		String password = "";
	
		String name = "";
		int sex = 1;
		Date bday = null;
		String address = "";
		String tel = "";
		String email = "";
		String LineID = "";
		String fileName = "";
		InputStream is = null;
		byte[] data = null;

		Account = request.getParameter("Account");
		password = request.getParameter("password");
		
		name = request.getParameter("name");
		LineID = request.getParameter("MlineId");
		int lin = LineID.indexOf("@");
		LineID = LineID.substring(0, lin);
		
		try{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String s =request.getParameter("birthday");
			/* 因為FB傳的日期字串無法辨識(無法parse)所以重新split組合 */
			String[] z =s.split("/");
			  java.util.Date b=sdf.parse(z[2]+"-"+z[0]+"-"+z[1]);
		        bday=new java.sql.Date(b.getTime());
		}
		catch(Exception e){
			e.getMessage();
		}
		fileName = request.getParameter("fileName");
		address = request.getParameter("address");
		if (request.getParameter("sex").equalsIgnoreCase("male") == false) {
			sex = 0;
		}
		tel = request.getParameter("tel");
		data=request.getParameter("Image").getBytes();
		email = request.getParameter("email");
		RegisterService_interface rs = new RegisterServiceDAO();
		MemberService mb=new MemberService();
		System.out.println(Account);
		System.out.println(bday);
		try {
			MemberListVO ml = null;
			loginService logsrv = new loginService();
			if (rs.idExists(Account)) {
				ml = logsrv.getMemberList().get(Account);
				ml = mb.update(ml.getMemId(), Account, password, name, sex, bday, email, LineID, tel, address, data,
						fileName,ml.getStatus()); 
				logsrv.updateMember(ml);
			} else {
				ml = mb.addMember(Account, password, name, sex, bday, email, LineID, tel, address, data,
						fileName,0);
				logsrv.addNewMember(ml);
			}
			session.setAttribute("FBLoginOK",ml);
			session.setAttribute("LoginOK"  ,ml);
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
}
