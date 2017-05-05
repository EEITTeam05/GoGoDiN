<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.shop.Model.ShopVO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改資料</title>
</head>
<body>
<c:if test="${not empty errorMsgs }" >
	<font size="-1" color="red">${errorMsgs.Pswd}</font>
	<font size="-1" color="red">${errorMsgs.Name}</font>
	<font size="-1" color="red">${errorMsgs.Tel}</font>
	<font size="-1" color="red">${errorMsgs.Mail}</font>
	<font size="-1" color="red">${errorMsgs.Line}</font>
</c:if>
	<form method="post" action="ShopServlet">
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
				<td><input type="text" name="shopPswd" size="50" value="${ShopLoginOK.shopPswd}" /></td>
			</tr>
			<tr align='center' valign='middle'>
				<th>姓名</th>
				<td><input type="text" name="shopName" size="50" value="${ShopLoginOK.shopName}" /></td>
			</tr>
			<tr align='center' valign='middle'>
				<th>身分證字號</th>
				<td>${ShopLoginOK.shopIdd}</td>
			</tr>
			<tr align='center' valign='middle'>
				<th>電話</th>
				<td><input type="text" name="shopTel" size="50"	value="${ShopLoginOK.shopTel}" /></td>
			</tr>
			<tr align='center' valign='middle'>
				<th>信箱</th>
				<td><input type="text" name="shopMail" size="50" value="${ShopLoginOK.shopEmail}" /></td>
			</tr>
			<tr align='center' valign='middle'>
				<th>Line</th>
				<td><input type="text" name="shopLine" size="50" value="${ShopLoginOK.slineId}" /></td>
			</tr>
		</table>

		<input type="submit" value="確認送出"> <input type="hidden" name="action" value="updateShop">
		<input type="hidden" name="shopId" value="${ShopLoginOK.shopId}">
		<input type="hidden" name="shopAcc" value="${ShopLoginOK.shopAccount}">
		<input type="hidden" name="shopIdd" value="${ShopLoginOK.shopIdd}">

	</form>
</body>
</html>