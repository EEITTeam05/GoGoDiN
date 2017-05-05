<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List"%>
<%@ page import="java.sql.Timestamp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>訂單列表</title>
</head>
<body>
	<a href="<%=request.getContextPath()%>/index.jsp">回首頁</a>
	<hr>
	<c:if test="${! empty errorMsgs }" >
		<font size="-1" color="red">${errorMsgs.error}</font>
	</c:if>
	<c:if test="${! empty AdminLoginOK }">
		<table border='1' bordercolor='#CCCCFF' width='800'>
			<tr>
				<th>會員編號</th>
				<th>業者編號</th>
				<th>餐廳名稱</th>
				<th>訂位時間</th>
				<th>訂位人數</th>
				<th>訂單時間</th>
			</tr>
			<c:forEach items="${listAllOrder }" var="listAllOrder">
				<tr align='center' valign='middle'>
					<td>${listAllOrder.memVO.memId}</td>
					<td>${listAllOrder.shopId}</td>
					<td>${listAllOrder.restVO.restName}</td>
					<td>${listAllOrder.orderTime}</td>
					<td>${listAllOrder.pnum}</td>
					<td>${listAllOrder.bidTime}</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</body>
</html>