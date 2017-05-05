<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
		<font size="-1" color="red">${errorMsgs.error }</font>
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
			<c:forEach var="list" items="${list }">
				<tr align='center' valign='middle'>
					<td>${list.restId }</td>
					<td>${list.shopId }</td>
					<td>${list.restName }</td>
					<td>${list.restTel }</td>
					<td>${list.restaddr }</td>
					<td>${list.ein }</td>
					<td>${list.restStart }</td>
					<td>${list.restEnd }</td>
					<td>${list.restRate }</td>
					<td>${list.restNum }</td>
					<td>
						<input type="button" data-id="${list.restId}" id="btn" value="顯示圖片" >
					</td>
					<td>
						<form method="post" action="<%=request.getContextPath()%>/Shop/ShopServlet">
							<input type="submit" value="修改">
							<input type="hidden" name="restId" value="${list.restId}">
							<input type="hidden" name="action" value="getRestUpdate">
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
		<div id="div1">
		</div>
	</c:if>
</body>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
	<script>
		var myDiv = $('#div1');
		$('body').on('click','#btn',function() {
			restId = $(this).attr('data-id');
			getImg();
		});
		function getImg() {
			$.getJSON("<%=request.getContextPath()%>/Admin/AdminServlet",{"action":"getImg","restId":restId },function(datas) {
				if (myDiv.children().length > 0) {
					myDiv.children().remove();
				}
				var docFrag = $(document.createDocumentFragment());
				var img = $('<img></img>').attr({
					'src':'data:image/jpeg;base64,' + datas.RestImg,
					'width':'300'
				});
				docFrag.append(img);
				myDiv.append(docFrag);
			})
		}
	</script>
</html>