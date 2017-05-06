<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="navbar.jsp"></jsp:include>

	<form  align="center" action="MailServlet" method="post" >
		
		請輸入您的帳號:<br>
		<input type="text" name="email"><font style="color:red">${errorMsg.errormail}</font><br>
        <input type="submit" name="submit" id="submit" value="送出">
        <input type="reset" name="cancel" id="cancel" value="重填">
        
	</form>





</body>
</html>