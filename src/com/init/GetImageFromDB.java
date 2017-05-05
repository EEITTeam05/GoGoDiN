package com.init;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Query;
import org.hibernate.classic.Session;

import com.img.Io.ImagesIo;
import com.member.Model.MemberListVO;
import com.member.Model.MemberService;
import com.rest.Model.RestService;
import com.rest.Model.RestVO;
import com.restPhoto.Model.RestPhotoService;
import com.restPhoto.Model.RestPhotoVO;
import com.search.Model.SearchService;

import hibernate.util.BigImportentHibernate;

@WebServlet("/init/getImage")
public class GetImageFromDB extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		OutputStream os = null;
		byte[] data = null;
		response.setContentType("image/jpeg");
		String sid = request.getParameter("id");
		String type = request.getParameter("type"); 
		String mid = request.getParameter("restname");
		String photo = request.getParameter("photo");
		if (type.equalsIgnoreCase("Member")) {  // 讀取Member表格
			MemberService msc = new MemberService();
			MemberListVO memVO = msc.getOneEmp(new Integer(sid));
			data = memVO.getMemberImage();			
		} else if (type.equalsIgnoreCase("Restaurant")) {  // 讀取Restaurant表格
			RestService rsc = new RestService();
			RestVO restVO = rsc.getOneRest(new Integer(sid));
			data = restVO.getRestImage();
		} else if (type.equalsIgnoreCase("Rest")) {  // 讀取Restaurant表格
			SearchService srv;RestVO restVO;
			try {
				srv = new SearchService();
				restVO = srv.getOneRest(mid);
				data = restVO.getRestImage();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (type.equalsIgnoreCase("RestPhoto")){
				RestPhotoService restph = new RestPhotoService();
				RestPhotoVO restPhotoVO = restph.getRePohtos(new Integer(sid));
				switch(photo){
					case "1":
						data = restPhotoVO.getRestImage1();
					break;
					case "2":
						data = restPhotoVO.getRestImage2();
					break;
					case "3":
						data = restPhotoVO.getRestImage3();
					break;
				}
		}
		
		
		
		
		os = response.getOutputStream();		
		//os.write(data, 0, count);
		os.write(data);
		if (os != null) {
			os.close();
		}
	}
}
