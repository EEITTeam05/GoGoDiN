<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>訂單一覽</title>
</head>
<body>
	<a href="<%=request.getContextPath()%>/index.jsp">回首頁</a>
	<hr>
	<c:if test="${! empty errorMsgs }">
		<font size="-1" color="red">${errorMsgs.error}</font>
	</c:if>
	<c:if test="${! empty ShopLoginOK }">
		<table border='1' bordercolor='#CCCCFF' width='800'>
			<tr>
				<th>業者編號</th>
				<th>餐廳編號</th>
				<th>訂位人數</th>
			</tr>
			<c:forEach var="listOrder" items="${listOrder}" >
				<tr align='center' valign='middle'>
					<td>${listOrder[0]}</td>
					<td>${listOrder[1]}</td>
					<td>${listOrder[2]}</td>
					<td>
						<form method="post" action="ShopServlet">
							<input type="submit" value="訂單明細">
							<input type="hidden" name="restId" value="${listOrder[1]}">
							<input type="hidden" name="action" value="orderDetail">
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</body>
</html>