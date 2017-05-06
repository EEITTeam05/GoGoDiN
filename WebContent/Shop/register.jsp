<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
tr {
	text-align: center;
}

table th {
	text-align: center;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>業主註冊</title>
</head>
<body>
	<jsp:include page="../navbar.jsp"></jsp:include>
	<hr>
	<form ENCTYPE="multipart/form-data" method="POST"
		action="shopregister.do" id="shopregister.do">
		<table border='1' bordercolor='#CCCCFF' width='700' height='500'
			align='center'>
			<tr>
				<th>業主帳號：</th>
				<td><input type="text" name="Account" value="${param.Account}"
					class="fieldWidth"> <font size="-1" color="#FF0000">${MsgMap.errorIDEmpty}${MsgMap.errorIDDup}</font>
				</td>
			</tr>
			<tr>
				<th>業主密碼：</th>
				<td><input type="password" name="password"
					value="${param.password}" class="fieldWidth"> <font
					color="red" size="-1">${MsgMap.errorPasswordEmpty}</font></td>
			</tr>
			<tr>
				<th>密碼確認：</th>
				<td><input type="password" name="password2"
					value="${param.password2}" class="fieldWidth">
					 <font color="red" size="-1">${MsgMap.errorPassword2Empty}</font></td>
					
			</tr>
			
			<tr>
				<th>業主姓名：</th>
				<td><input type="text" name="name" value="${param.name}"
					class="fieldWidth"> <font color="red" size="-1">${MsgMap.errorName}</font>
				</td>
			</tr>
			<tr>
				<th>業主電話：</th>
				<td><input type="text" name="tel" value="${param.tel}"
					class="fieldWidth"> <font color="red" size="-1">${MsgMap.errorTel}</font>
				</td>
			</tr>
			<tr>
				<th>身分證號：</th>
				<td><input type="text" name="Idd" value="${param.Idd}"
					class="fieldWidth"> <font color="red" size="-1">${MsgMap.errorIdd}
				</font><font color="green" size="-1"></font></td>
			</tr>
			<tr>
				<th>電子郵件：</th>
				<td><input type="text" name="eMail" value="${param.eMail}"
					class="fieldWidth"> <font color="red" size="-1">${MsgMap.errorEmail}</font>
				</td>
			</tr>
			<tr>
				<th>LineID：</th>
				<td><input type="text" name="SLineID" value="${param.SLineID}"
					class="fieldWidth"> <font color="red" size="-1"></font></td>
			</tr>
			<tr>
				<th>業主地址：</th>
				<td><input type="text" name="address" value="${param.address}"
					class="fieldWidth"> <font color="red" size="-1">${MsgMap.errorAddr}</font>
				</td>
			</tr>
			<tr>
				<th>照片：</th>
				<td> 
					<Input type="file" size="40" class="fieldWidth" style="width: 480px;"  name="file1"><BR>
		     		 <font color="red" size="-1">${MsgMap.errPicture}</font>
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" name="submit" id="submit"
					value="儲存" /> <input type="reset" name="cancel" id="cancel"
					value="重填"></td>
			</tr>
		</table>
	</form>
</body>
</html>