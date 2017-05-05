<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.shop.Model.ShopVO" %>
<%
	ShopVO shopVO = (ShopVO)request.getAttribute("shopVO");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改完成</title>
</head>
<body>
	<table border='1' bordercolor='#CCCCFF' width='800'>
		<tr align='center' valign='middle'>
			<th>編號</th>
			<td>${ShopLoginOK.shopId}</td>
		</tr>
		<tr align='center' valign='middle'>
			<th>帳號</th>
			<td>${ShopLoginOK.shopAccount}</td>
		</tr>
		<tr align='center' valign='middle'>
			<th>密碼</th>
			<td>${ShopLoginOK.shopPswd}</td>
		</tr>
		<tr align='center' valign='middle'>
			<th>姓名</th>
			<td>${ShopLoginOK.shopName}</td>
		</tr>
		<tr align='center' valign='middle'>
			<th>身分證字號</th>
			<td>${ShopLoginOK.shopIdd}</td>
		</tr>
		<tr align='center' valign='middle'>
			<th>電話</th>
			<td>${ShopLoginOK.shopTel}</td>
		</tr>
		<tr align='center' valign='middle'>
			<th>信箱</th>
			<td>${ShopLoginOK.shopEmail}</td>
		</tr>
		<tr align='center' valign='middle'>
			<th>Line</th>
			<td>${ShopLoginOK.slineId}</td>
		</tr>
	</table>
	<a href="<%=request.getContextPath()%>/index.jsp">回首頁</a>
</body>
</html>