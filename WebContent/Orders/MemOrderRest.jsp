<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.rest.Model.*"%>

<%RestVO restVO = (RestVO) request.getAttribute("restVO");%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>餐廳資訊</title>
</head>
<body bgcolor='white'>

<table border='1' bordercolor='#CCCCFF' width='1000'>
	<tr>
		<th>編號</th>
		<th>名稱</th>
		<th>電話</th>
		<th>地址</th>
		<th>營業時間</th>
		<th>結束時間</th>
		<th>餐廳照片</th>
	</tr>
	<tr align='center' valign='middle'>
		<td><%=restVO.getRestId()%></td>
		<td><%=restVO.getRestName()%></td>
		<td><%=restVO.getRestTel()%></td>
		<td><%=restVO.getRestaddr()%></td>
		<td><%=restVO.getRestStart()%></td>
		<td><%=restVO.getRestEnd()%></td>
		<td><img height='200px' width='180px'
			src='${pageContext.servletContext.contextPath}/init/getImage?id=<%=restVO.getRestId()%>&type=Restaurant'>
		</td>
	</tr>
</table>

<form method="post" action="MemOrderServlet" style="margin-top: 5px">
   <input type="submit" value="回上一頁">
   <input type="hidden" name="action" value="back2">
</form>

</body>
</html>