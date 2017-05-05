<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>業者列表</title>
</head>
<body>
	<a href="<%=request.getContextPath()%>/index.jsp">回首頁</a>
	<hr>
	<c:if test="${! empty errorMsgs }" >
		<font size="-1" color="red">${errorMsgs.error}</font>
	</c:if>
	<c:if test="${! empty AdminLoginOK }">
		<table border='1' bordercolor='#CCCCFF' width='800'>
			<tr align='center' valign='middle'>
				<th>業者編號</th>
				<th>業者帳號</th>
				<th>業者姓名</th>
				<th>業者電話</th>
				<th>業者信箱</th>
				<th>業者Line</th>
				<th>業者狀態</th>
			</tr>
			<c:forEach var="shopVO" items="${listShop }">
				<tr align='center' valign='middle'>
					<td>${shopVO.shopId }</td>
					<td>${shopVO.shopAccount }</td>
					<td>${shopVO.shopName }</td>
					<td>${shopVO.shopTel }</td>
					<td>${shopVO.shopEmail }</td>
					<td>${shopVO.slineId }</td>
					<c:choose>
						<c:when test="${shopVO.status == 0}">
							<td>正常</td>
						</c:when>
						<c:when test="${shopVO.status == 1}">
							<td>停權</td>
						</c:when>
					</c:choose>
					
					<td>
						<form method="post" action="AdminServlet">
							<input type="submit" value="修改">
							<input type="hidden" name="shopId" value="${shopVO.shopId }">
							<input type="hidden" name="action" value="getShopUpdate">
						</form>
					</td>
					<td>
						<form method="post" action="AdminServlet">
							<input type="submit" value="顯示餐廳">
							<input type="hidden" name="shopId" value="${shopVO.shopId }">
							<input type="hidden" name="action" value="getShopRest">
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
		<hr>
		<table border='1' bordercolor='#CCCCFF' width='800'>
			<tr align='center' valign='middle'>
				<th>會員編號</th>
				<th>會員帳號</th>
				<th>會員姓名</th>
				<th>會員信箱</th>
				<th>會員Line</th>
				<th>會員電話</th>
				<th>會員狀態</th>
			</tr>
			<c:forEach var="memVO" items="${listMem }">
				<tr align='center' valign='middle'>
					<td>${memVO.memId }</td>
					<td>${memVO.memAccount }</td>
					<td>${memVO.memName }</td>
					<td>${memVO.email }</td>
					<td>${memVO.mlineId }</td>
					<td>${memVO.memTel }</td>
					<c:choose>
						<c:when test="${memVO.status == 0}">
							<td>正常</td>
						</c:when>
						<c:when test="${memVO.status == 1}">
							<td>停權</td>
						</c:when>
					</c:choose>
					<td>
						<form method="post" action="AdminServlet">
							<input type="submit" value="修改"> <input type="hidden" name="memId" value="${memVO.memId }">
							<input type="hidden" name="action" value="getMemUpdate">
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</body>
</html>