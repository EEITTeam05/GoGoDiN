<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Base64" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
 table { 
 		border-top-left-radius:20px; 
		border-top-right-radius:20px; 
 		border-bottom-left-radius:20px; 
		padding: 10px; 
 }
 table th {
 	text-align:center;
 }
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>餐廳修改</title>
</head>
<body>
	<jsp:include page="../navbar.jsp"></jsp:include>
	<hr>
	<c:if test="${! empty errorMsgs }">
		<font size="-1" color="red">${errorMsgs.error }</font>
	</c:if>
	<c:if test="${! empty ShopLoginOK }">
		<table border='1' bordercolor='#CCCCFF' width='1200' align='center' >
			<tr align='center' >
				<th>餐廳名稱</th>
				<th>餐廳電話</th>
				<th>餐廳地址</th>
				<th>統一編號</th>
				<th>刊登日期</th>
				<th>截止日期</th>
				<th>刊登人數</th>
				<th>照片</th>
			</tr>
			<c:forEach var="listRest" items="${listRest }" >
				<tr align='center' valign='middle' >
					<td>${listRest.restName }</td>
					<td>${listRest.restTel }</td>
					<td>${listRest.restaddr }</td>
					<td>${listRest.ein }</td>
					<td>${listRest.restStart }</td>
					<td>${listRest.restEnd }</td>
					<td>${listRest.restNum }</td>
					<td><img src="data:image/jpeg;base64,${Base64.getEncoder().encodeToString(listRest.restImage) }" width="300" ></td>
					<td>
						<form method="post" action="ShopServlet">
							<input type="submit" value="修改">
							<input type="hidden" name="restId" value="${listRest.restId }">
							<input type="hidden" name="action" value="getRestUpdate">
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</body>
</html>