<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登出</title>
</head>
<body>
<!-- 先將使用者名稱取出 -->
<!-- 移除放在session物件內的屬性物件 -->
<c:remove var="LoginOK" scope="session" />
<c:remove var="ShopLoginOK" scope="session" />
<c:remove var="AdminLoginOK" scope="session" />
<c:remove var="ShoppingCart" scope="session" />
<c:remove var="FBLoginOK" scope="session" />
<%
  session.invalidate();
  response.sendRedirect("http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/index.jsp");
%>
</body> 
</html>