<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>站內信</title>
</head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<div id="popupcalendar" class="text"></div>

<body bgcolor='white'>

	<table border='1' cellpadding='5' cellspacing='0' width='400'>
		<tr bgcolor='green' align='center' valign='middle' height='20'>
			<td>
				<h3>站內信</h3> <a href="select_page.jsp"><img src="" width="100"
					height="32" border="0">回首頁</a>
			</td>
		</tr>
	</table>

	<h3>聯絡業者:</h3>

	<%-- 	<c:if test="${not empty errorMsgs}"> --%>
	<!-- 		<font color='red'>請修正以下錯誤: -->
	<!-- 			<ul> -->
	<%-- 				<c:forEach var="message" items="${errorMsgs}"> --%>
	<%-- 					<li>${message}</li> --%>
	<%-- 				</c:forEach> --%>
	<!-- 			</ul> -->
	<!-- 		</font> -->
	<%-- 	</c:if> --%>

	<FORM METHOD="post" ACTION="MessageServlet" name="form1">
		<table border="0">
			<tr>
				<td>餐廳名稱:<font color=red><b>*</b></font></td>
				<td><input type="hidden" name="RestName" value="牛排"></td>
			</tr>
			<br />
			<tr>
				<td>會員帳號:
					<p><td><font color=red><b>*</b></font>${fb.email}</td>
				</td>
				<td><input type="hidden" name="MemAccount" value="${fb.email}">
				</td>
			</tr>
			<br>
			<tr>
				<td>會員姓名:</td>
				<td><input type="TEXT" name="MemName" height="10" size="10"
					value="${fb.firstname}" /></td>
			</tr>
			<br>
			<tr>
				<td>主旨:</td>

				<td><select size="1" name="KeyP">
						<option value="抱怨">詢問
						<option value="抱怨">抱怨
						<option value="抱怨">其他
				</select></td>

			</tr>
			<br>
			<tr>
				<td>內容:</td>
				<td><textarea cols="100px" name="Message"></textarea></td>
			</tr>


		</table>
		<br> <input type="submit" value="送出">
		
		<a href= "allmail.jsp">信件查詢</a>
	 </FORM>

</body>
</html>