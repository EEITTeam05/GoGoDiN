<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<form action="ModifyPass" align="center" method="post" >
                  帳號:<br> 
		<input type="text" name="account" value="${param.account}" disabled><br>
		<input type="hidden" name="account" value="${param.account}"><br>  
		新密碼:<br> 
		<input type="text" name="pass"><br> 
		新密碼確認:<br>
		<input type="text" name="pass2"><font style="color:red">${error.error}</font><br>
        
        <input type="submit" name="submit" id="submit" value="送出"/>
        <input type="reset" name="cancel" id="cancel" value="重填">
	</form>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">


</script>
</html>