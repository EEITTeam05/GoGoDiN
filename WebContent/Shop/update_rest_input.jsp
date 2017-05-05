<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
.imgs{
margin-left:2px;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改資料</title>
</head>
<body>
	<a href="<%=request.getContextPath()%>/index.jsp">回首頁</a>
	<hr>
	<c:if test="${! empty errorMsgs }" >
		<font size="-1" color="red">${errorMsgs.Name}</font><br>
		<font size="-1" color="red">${errorMsgs.Tel}</font><br>
		<font size="-1" color="red">${errorMsgs.Addr}</font><br>
		<font size="-1" color="red">${errorMsgs.Ein}</font><br>
		<font size="-1" color="red">${errorMsgs.Start}</font><br>
		<font size="-1" color="red">${errorMsgs.End}</font><br>
		<font size="-1" color="red">${errorMsgs.Num}</font><br>
	</c:if>
	<c:if test="${! empty ShopLoginOK ||! empty AdminLoginOK }" >
		<form method="post" name="updateRest" action="ShopServlet" enctype="multipart/form-data" >
			<table border='1' bordercolor='#CCCCFF' width='800'>
				<tr align='center' valign='middle'>
					<th>餐廳名稱</th>
					<td><input type="text" name="restName" size="50" value="${restVO.restName}"/></td>
				</tr>
				<tr align='center' valign='middle'>
					<th>餐廳電話</th>
					<td><input type="text" name="restTel" size="50" value="${restVO.restTel}" /></td>
				</tr>
				<tr align='center' valign='middle'>
					<th>餐廳地址</th>
					<td><input type="text" name="restaddr" size="50" value="${restVO.restaddr}" /></td>
				</tr>
				<tr align='center' valign='middle'>
					<th>統一編號</th>
					<td><input type="text" name="ein" size="50" value="${restVO.ein}" /></td>
				</tr>
				<tr align='center' valign='middle'>
					<th>刊登日期</th>
					<td><input type="text" name="restStart" size="50" value="${restVO.restStart}" /></td>
				</tr>
				<tr align='center' valign='middle'>
					<th>截止日期</th>
					<td><input type="text" name="restEnd" size="50"	value="${restVO.restEnd}" /></td>
				</tr>
				<tr align='center' valign='middle'>
					<th>刊登人數</th>
					<td><input type="text" name="restNum" size="50" value="${restVO.restNum}" /></td>
				</tr>
				<tr align='center' valign='middle'>
					<th>刊登價格</th>
					<td><input type="text" name="money" size="50" value="${restVO.money}" /></td>
				</tr>
				<tr align='center' valign='middle'>
					<th>刊登簡介</th>
					<td>
					<textarea placeholder="請輸入餐廳簡介" cols="50" rows="5" name="brief" size="50" >${restVO.brief}</textarea>	</td>
				</tr>
				<tr align='center' valign='middle'>
					<th>照片</th>
					<td>
					<Input type="file" size="40" style="width:300px;" id="file" name="file[]" multiple="multiple">
					</td>
				</tr>
				<tr align='center' valign='middle'>
	        		<th>狀態</th>
		        		<td>
			        		<select id="select2" name="status">
				        		<option value="0">正常</option>
				        		<option value="1">下架</option>
			        		</select>
		        		</td>
				</tr>
				<tr align='center' valign='middle'>
	        		<th>預覽</th>
	        		<td id="myDiv">
		        		<img id="img0" class="imgs" height='160px' width='160px' src='${pageContext.servletContext.contextPath}/init/getImage?type=Rest&restname=${restVO.restName}'>
		        		<img id="img1" class="imgs" height='160px' width='160px' src='${pageContext.servletContext.contextPath}/init/getImage?id=${restVO.restId}&photo=1&type=RestPhoto'>
		        		<img id="img2" class="imgs" height='160px' width='160px' src='${pageContext.servletContext.contextPath}/init/getImage?id=${restVO.restId}&photo=2&type=RestPhoto'>
		        		<img id="img3" class="imgs" height='160px' width='160px' src='${pageContext.servletContext.contextPath}/init/getImage?id=${restVO.restId}&photo=3&type=RestPhoto'>
	        		</td>
				</tr>
			</table>
			<input type="submit" name="submit" value="確認送出">
			<input type="hidden" name="action" value="updateRestMulti">
			<input type="hidden" name="restId" value="${restVO.restId}">
		</form>
	</c:if>
</body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
	<script type="text/javascript">
	var xhr = null;
	var form = document.forms.namedItem("updateRest");

	form.addEventListener('submit', function(ev) {					

		var formData = new FormData();

		var file_data = $('input[type="file"]')[0].files; // for multiple files

		var other_data = $('form').serializeArray();

		$.each(other_data, function(key, input) {
			formData.append(input.name, input.value);
		});

		for (var i = 0; i < file_data.length; i++) {
			formData.append("file" + i, file_data[i]);
		}
		
		if (updateRest.restName.value=="") {
			alert("請填寫資料！");						
		}
		else{
			xhr = new XMLHttpRequest();
		}				 
		xhr.addEventListener("load",function(){	 			
			console.log("load");
			if(xhr.status == 200){
				console.log(xhr.responseText);
			}
			//判斷status==200
			//接收Server端回傳的結果
		})
		xhr.addEventListener("readystatechange",function(){
			console.log("readyState : " + xhr.readyState);
		});
		xhr.addEventListener("loadend",function(){
			console.log("loadend");
			//隱藏Ajax執行中的圖示
			window.location.href="<%=request.getContextPath()%>/Shop/ShopServlet?action=listRest";
		})
		xhr.open("POST", "ShopServlet"); //document.publish.action			
		xhr.send(formData);
		ev.preventDefault();

	}, false);	
	
	var myDiv = $('#myDiv');
	$('input[type="file"]').bind("change",function(event) {
		if (event.target.files.length > 4) {
			alert("上傳照片數量超過4張！請重新選擇！");
			$('input[type="file"]').val(null);
		}
		if (myDiv.children().length > 0) {
			myDiv.children().remove();
		}
		for (var i = 0; i < event.target.files.length; i++) {
			$('<img></img>').addClass('imgs').attr('id', 'img' + i).appendTo(myDiv);
		}
	});
	
	$(function (){
	    	function preview(input) {			
				if (input.files && input.files[0]) {
					var reader = new FileReader();
					reader.onload = function(e) {
						$('#img0').attr({
							'src' : e.target.result,
							'id' : 'change',
							'height':'160px',
							'width':'160px'
						});
					}
					reader.readAsDataURL(input.files[0]);
				}
				if (input.files && input.files[1]) {
					var reader = new FileReader();
					reader.onload = function(e) {
						$('#img1').attr({
							'src' : e.target.result,
							'id' : 'change',
							'height':'160px',
							'width':'160px'
						});
					}
					reader.readAsDataURL(input.files[1]);
				}
				if (input.files && input.files[2]) {
					var reader = new FileReader();
					reader.onload = function(e) {
						$('#img2').attr({
							'src' : e.target.result,
							'id' : 'change',
							'height':'160px',
							'width':'160px'
						});
					}
					reader.readAsDataURL(input.files[2]);
				}
				if (input.files && input.files[3]) {
					var reader = new FileReader();
					reader.onload = function(e) {
						$('#img3').attr({
							'src' : e.target.result,
							'id' : 'change',
							'height':'160px',
							'width':'160px'
						});
					}
					reader.readAsDataURL(input.files[3]);
				}
			}
	    $('input[type="file"]').bind("change",function(event) {
				preview(this);
		})
	})
	$('option[value="${restVO.status}"]').attr('selected',"selected");
	</script>
</html>