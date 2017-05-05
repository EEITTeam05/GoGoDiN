<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改資料</title>
</head>
<body>
	<a href="<%=request.getContextPath()%>/index.jsp">回首頁</a>
	<hr>
	<c:if test="${not empty errorMsgs }" >
		<font size="-1" color="red">${errorMsgs.Pswd}</font><br>
		<font size="-1" color="red">${errorMsgs.Name}</font><br>
		<font size="-1" color="red">${errorMsgs.Tel}</font><br>
		<font size="-1" color="red">${errorMsgs.Mail}</font><br>
		<font size="-1" color="red">${errorMsgs.Line}</font><br>
	</c:if>
	<c:if test="${! empty AdminLoginOK }">
		<form method="post" action="AdminServlet">
			<table border='1' bordercolor='#CCCCFF' width='800'>
				<tr align='center' valign='middle'>
					<th>編號</th>
					<td>${shopVO.shopId}</td>
				</tr>
				<tr align='center' valign='middle'>
					<th>帳號</th>
					<td>${shopVO.shopAccount}</td>
				</tr>
				<tr align='center' valign='middle'>
					<th>姓名</th>
					<td><input type="text" name="shopName" size="50" value="${shopVO.shopName}" /></td>
				</tr>
				<tr align='center' valign='middle'>
					<th>電話</th>
					<td><input type="text" name="shopTel" size="50"	value="${shopVO.shopTel}" /></td>
				</tr>
				<tr align='center' valign='middle'>
					<th>信箱</th>
					<td><input type="text" name="shopMail" size="50" value="${shopVO.shopEmail}" /></td>
				</tr>
				<tr align='center' valign='middle'>
					<th>Line</th>
					<td><input type="text" name="shopLine" size="50" value="${shopVO.slineId}" /></td>
				</tr>
				<tr align='center' valign='middle'>
					<th>狀態</th>
					<td>
						<select id="select1" name="status">
							<option value="0">正常</option>
							<option value="1">停權</option>
						</select>
					</td>
				</tr>
				
			</table>
			<input type="submit"  value="確認送出"> 
			<input type="hidden" name="action" value="updateShop">
			<input type="hidden" name="shopId" value="${shopVO.shopId}">
			<input type="hidden" name="shopAcc" value="${shopVO.shopAccount}">
			<input type="hidden" name="shopPswd" value="${shopVO.shopPswd}">
			<input type="hidden" name="shopIdd" value="${shopVO.shopIdd}">
		</form>
	</c:if>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript">
		$('option[value="${shopVO.status}"]').attr('selected','selected');
	</script>
</body>

</html>