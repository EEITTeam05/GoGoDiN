<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.GregorianCalendar"%>
<%@ page import="java.sql.Timestamp"%>

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
<title>訂單內容</title>
</head>
<body>
	<jsp:include page="../navbar.jsp"></jsp:include>
	<hr>
	<c:if test="${! empty errorMsgs }" >
		<font size="-1" color="red">${errorMsgs.error}</font>
	</c:if>
	<c:if test="${! empty ShopLoginOK }">
		<table border='1' bordercolor='#CCCCFF' width='800' height='750' align='center' >
			<tr>
			    <th>訂單編號</th>
				<th>餐廳編號</th>
				<th>會員編號</th>
				<th>訂位時間</th>
				<th>訂位人數</th>
				<th>訂單時間</th>
			</tr>
			<c:forEach var="listOrderDetail" items="${listOrderDetail }" >
				<tr align='center' valign='middle'>
				    <td>${listOrderDetail[0] }</td>
					<td>${listOrderDetail[3] }</td>
					<td>${listOrderDetail[1] }</td>
					<td>${listOrderDetail[4] } ${listOrderDetail[5] }</td>
					<td>${listOrderDetail[6] }</td>
					<td>${listOrderDetail[7] }</td>
					<td>
						<form method="post" action="ShopServlet">
							<input type="submit" value="修改">
							<input type="hidden" name="OrderNum" value="${listOrderDetail[0] }">
							<input type="hidden" name="action" value="getOrderUpdate">
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</body>
</html>