<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
	tr {
		text-align:center;
	}
	table th {
		text-align:center;
	}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../navbar.jsp"></jsp:include>
	<hr>
	<form enctype="multipart/form-data" method="POST" action="register.do"  id="register.do" >
		<table border='1' bordercolor='blue' align="center" width='700' height='500' >
			<tr>
				<th>帳號：</th>
				<td>
					<input type="text" name="Account" value="${param.Account}" class="fieldWidth" >
					<font size="-1" color="#FF0000">${MsgMap.errorIDEmpty}${MsgMap.errorIDDup}</font>
				</td>
			</tr>
			<tr>
				<th>密碼：</th>
				<td>
					<input type="password" name="password" value="${param.password}" class="fieldWidth" >
      				<font color="red" size="-1">${MsgMap.errorPasswordEmpty}</font> 
				</td>
			</tr>
			<tr>
				<th>密碼確認：</th>
				<td>
					<input type="password" name="password2" value="${param.password2}"   class="fieldWidth" >
      				<font color="red" size="-1">${MsgMap.errorPassword2Empty}</font>
				</td>
			</tr>
			<tr>
				<th>姓名：</th>
				<td>
					<input type="text" name="name" value="${param.name}"  class="fieldWidth" >
      				<font color="red" size="-1">${MsgMap.errorName}</font>
				</td>
			</tr>
			<tr>
				<th>性別：</th>
				<td>
					<input type="radio" name="sex" value="1" CHECKED>男
      				<input type="radio" name="sex" value="0">女
      				<font color="red" size="-1">${MsgMap.errorSex}</font>
				</td>
			</tr>
			<tr>
				<th>生日：</th>
				<td>
					<input type="date" name="bday" id="bookdate" value="2017-03-22">
      				<font color="red" size="-1">${MsgMap.errorbday}</font>
				</td>
			</tr>
			<tr>
				<th>地址：</th>
				<td>
					<input type="text" name="address" value="${param.address}"  class="fieldWidth" >
      				<font color="red" size="-1">${MsgMap.errorAddr}</font>
				</td>
			</tr>
			<tr>
				<th>電話：</th>
				<td>
					<input type="text"  name="tel" value="${param.tel}"    class="fieldWidth" >
      				<font color="red" size="-1">${MsgMap.errorTel}</font>
				</td>
			</tr>
			<tr>
				<th>電子郵件：</th>
				<td>
					<input type="text"  name="eMail" value="${param.eMail}"   class="fieldWidth" >
          			<font color="red" size="-1">${MsgMap.errorEmail}</font>
				</td>
			</tr>
			<tr>
				<th>LineID：</th>
				<td>
					<input type="text"  name="MLineID" value="${param.MLineID}"   class="fieldWidth" >
          			<font color="red" size="-1"></font>
				</td>
			</tr>
      		<tr>
      			<th>照片：</th>
      			<td>
      				<Input type="file" size="40" class="fieldWidth" style="width:480px;padding:15px 0px 0px 10px" name="file1"><BR>
      				<font color="red" size="-1">${MsgMap.errPicture}</font>
      			</td>
      		</tr>
      		<tr>
      			<td colspan="2">
      				<input type="submit" name="submit" id="submit" value="儲存"/>
         			<input type="reset" name="cancel" id="cancel" value="重填">
      			</td>
      		</tr>
		</table>
	</form>
</body>
</html>