<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Base64" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改完成</title>
</head>
<body>
	<a href="<%=request.getContextPath()%>/index.jsp">回首頁</a>
	<hr>
	<c:if test="${! empty ShopLoginOK ||! empty AdminLoginOK}" >
		<table border='1' bordercolor="#CCCCFF" width='auto'>
			<tr align='center' valign='middle'>
				<th>餐廳名稱</th>
				<td>${restVO.restName }</td>
			</tr>
			<tr align='center' valign='middle'>
				<th>餐廳電話</th>
				<td>${restVO.restTel }</td>
			</tr>
			<tr align='center' valign='middle'>
				<th>餐廳地址</th>
				<td>${restVO.restaddr }</td>
			</tr>
			<tr align='center' valign='middle'>
				<th>餐廳簡介</th>
				<td>${restVO.brief }</td>
			</tr>
			<tr align='center' valign='middle'>
				<th>統一編號</th>
				<td>${restVO.ein }</td>
			</tr>
			<tr align='center' valign='middle'>
				<th>刊登日期</th>
				<td>${restVO.restStart }</td>
			</tr>
			<tr align='center' valign='middle'>
				<th>截止日期</th>
				<td>${restVO.restEnd }</td>
			</tr>
			<tr align='center' valign='middle'>
				<th>刊登價格</th>
				<td>${restVO.money }</td>
			</tr>
			<tr align='center' valign='middle'>
				<th>刊登人數</th>
				<td>${restVO.restNum }</td>
			</tr>
			<tr align='center' valign='middle'>
				<th>狀態</th>
				<td>
					<c:choose>
						<c:when test="${restVO.status==0}">
							正常
						</c:when>
						<c:when test="${restVO.status==1}">
							下架
						</c:when>
					</c:choose>
       			</td>
			</tr>
			<tr align='center' valign='middle'>
				<th>照片</th>
				<td><img src="data:image/jpeg;base64,${Base64.getEncoder().encodeToString(restVO.restImage) }" width="300" ></td>
			</tr>
		</table>
	</c:if>
</body>
</html>