<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.rest.Model.*"%>

<%RestVO restVO = (RestVO) request.getAttribute("restVO");%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>�\�U��T</title>
</head>
<body bgcolor='white'>

<table border='1' bordercolor='#CCCCFF' width='1000'>
	<tr>
		<th>�s��</th>
		<th>�W��</th>
		<th>�q��</th>
		<th>�a�}</th>
		<th>��~�ɶ�</th>
		<th>�����ɶ�</th>
		<th>�\�U�Ӥ�</th>
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
   <input type="submit" value="�^�W�@��">
   <input type="hidden" name="action" value="back2">
</form>

</body>
</html>