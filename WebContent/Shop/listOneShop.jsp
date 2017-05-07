<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.shop.Model.ShopVO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
	table th {
		text-align:center;
		height:30px;
	}
	table td {
		height:50px;
	}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改完成</title>
</head>
<body>
	<jsp:include page="../navbar.jsp"></jsp:include>
	<hr>
	<table border='1' bordercolor='#CCCCFF' width='800' align="center">
		<tr align='center' valign='middle'>
			<th></th>
			<td>
			<img height='200px' width='180px' src='${pageContext.servletContext.contextPath}/init/getImage?id=${ShopLoginOK.shopAccount}&type=AccountImg'>
			</td>
		</tr>
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
</body>
</html>