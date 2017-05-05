<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Base64" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>餐廳列表</title>
</head>
<body>
	<a href="<%=request.getContextPath()%>/index.jsp">回首頁</a>
	<hr>
	<c:if test="${! empty errorMsgs }" >
		<font size="-1" color="red">${errorMsgs.error}</font>
	</c:if>
	<c:if test="${! empty AdminLoginOK }">
		<table border='1' bordercolor='#CCCCFF' width='auto'>
			<tr align='center' valign='middle'>
				<th>餐廳編號</th>
				<th>業者帳號</th>
				<th>餐廳名稱</th>
				<th>餐廳電話</th>
				<th>餐廳地址</th>
				<th>統一編號</th>
				<th>營業時間</th>
				<th>營業時間</th>
				<th>評價</th>
				<th>餐廳人數</th>
				<th>餐廳照片</th>
				<th>修改</th>
			</tr>
			<c:forEach var="listAllRest" items="${listAllRest }">
				<tr align='center' valign='middle'>
					<td>${listAllRest.restId }</td>
					<td>${listAllRest.shopId }</td>
					<td>${listAllRest.restName }</td>
					<td>${listAllRest.restTel }</td>
					<td>${listAllRest.restaddr }</td>
					<td>${listAllRest.ein }</td>
					<td>${listAllRest.restStart }</td>
					<td>${listAllRest.restEnd }</td>
					<td>${listAllRest.restRate }</td>
					<td>${listAllRest.restNum }</td>
					<td><img src="data:image/jpeg;base64,${Base64.getEncoder().encodeToString(listAllRest.restImage) }" width="300" ></td>
					<td>
						<form method="post" action="<%=request.getContextPath()%>/Shop/ShopServlet">
							<input type="submit" value="修改">
							<input type="hidden" name="restId" value="${listAllRest.restId }">
							<input type="hidden" name="action" value="getRestUpdate">
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</body>
</html>