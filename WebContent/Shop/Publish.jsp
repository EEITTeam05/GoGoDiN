<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="../css/jquery.timepicker.css">
<style>
.imgs {
      height:100px;
      width:100px; 
      border:3px purple solid;
      margin:2px;
      
}

#imge {
      display: none;
}

input{
	margin-bottom: 5px;
}

#d1{
	margin-top: 100px;
	margin-left: 250px;
}

</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>刊登</title>
</head>
<body>
<div id="d1">
<form method="POST" action="publish.do"  name="publish" enctype="multipart/form-data">
      <label class="fontSize" >餐廳名稱：</label>
      <input type="text" name="RestName" value="${param.RestName}" class="fieldWidth" style="width: 180px;">
      <font size="-1" color="#FF0000">${MsgMap.errorRestNameEmpty}${MsgMap.errorIDDup}</font>
      <br/>
      <label class="fontSize" >餐廳電話：</label>
      <input type="text"  name="RestTel" value="${param.RestTel}"    class="fieldWidth" style="width: 120px;">
      <font color="red" size="-1">${MsgMap.errorRestTel}</font>
      <br/>
  	  <label class="fontSize" >餐廳地址：</label>
      <input type="text" name="RestAddr" value="${param.RestAddr}"  class="fieldWidth" style="width: 320px;">
      <font color="red" size="-1">${MsgMap.errorRestAddr}</font>
      <br/>
      <label class="fontSize" >統一編號：</label>
      <input type="text" name="Ein" value="${param.Ein}"   class="fieldWidth" style="width: 200px;">
      <font color="red" size="-1">${MsgMap.errorEinEmpty}</font>            
      <br/>
      <label for="bookdate">營業時間：</label>
      <input type="text" name="StartDay" id="StartDay" value="10:00">
      <font color="red" size="-1">${MsgMap.errorStartDay}</font>
      <br/>
      <label for="bookdate">休業時間：</label>
      <input type="text" name="EndDay" id="EndDay" value="19:00">
      <font color="red" size="-1">${MsgMap.errorEndDay}</font>
      <br/>
      <label for="bookdate">餐廳價位：</label>
      <input type="text" name="money" value="${param.money}">
      <font color="red" size="-1">${MsgMap.errorMoney}</font>
      <br/>
      <label class="fontSize" >刊登人數：</label>
      <input type="text" name="RestNum" value="${param.RestNum}"  class="fieldWidth" style="width: 180px;">
      <font color="red" size="-1">${MsgMap.errorRestNum}</font>
      <br/>        
      <label class="fontSize" >照片(最多4張)：</label>
      <Input type="file" size="40" class="fieldWidth" style="width: 480px;" id="file" name="file[]" multiple="multiple"><BR>
      <font color="red" size="-1">${MsgMap.errPicture}</font>    
      <div id="myDiv"></div>
      <h3>餐廳簡介：</h3>
      <textarea placeholder="請輸入餐廳簡介" cols="50" rows="5" name="brief" ></textarea> 
      <font color="red" size="-1">${MsgMap.errorBrief}</font>
      <br/>      
      <br/> 
      
     
      
      <div id="btnArea" align="left">
         <input type="submit" name="submit" id="buttonSubmit" value="儲存"/>
         <input type="hidden" name="ShopId" value="${ShopLoginOK.shopId}" >
         <input type="reset" name="cancel" id="cancel" value="重填">
         <img id="imge" src="../images/ajax-loader.gif">
      </div>
      <br/>
</form>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.timepicker.min.js"></script>
<script type="text/javascript">
$('input[id$=Day]').timepicker({
	  'step':60,
	  'timeFormat':'H:i',
	  'disableTextInput':true
});

</script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	

	<script type="text/javascript">
		var xhr = null;
		
		var myImg = document.getElementById('imge');
	
		var form = document.forms.namedItem("publish");

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
			
			if (publish.RestName.value=="") {
				alert("請填寫資料！");						
			}
			else{
				xhr = new XMLHttpRequest();
			}				 
			
			xhr.addEventListener("readystatechange",function(){
				console.log("readyState : " + xhr.readyState);
			});
			//Ajax開始事件
			xhr.addEventListener("loadstart",function(){
				console.log("loadstart");	
				//顯示Ajax執行中的圖示
				myImg.style.display = "inline";
			})
			
			//改用load事件，接收server端回傳的結果
			xhr.addEventListener("load",function(){	 			
				console.log("load");
				if(xhr.status == 200){
					console.log(xhr.responseText);
				}
				//判斷status==200
				//接收Server端回傳的結果
			})
			//Ajax結束事件
			xhr.addEventListener("loadend",function(){
				console.log("loadend");
				//隱藏Ajax執行中的圖示
				myImg.style.display = "none";
				window.location.href="<%=request.getContextPath()%>/index.jsp";
			})
			
			xhr.open("POST", "publish.do"); //document.publish.action			

			xhr.send(formData);

			ev.preventDefault();

		}, false);	
		
		var myDiv = $('#myDiv');
		if (myDiv.children().length > 0) {
			myDiv.children().remove();
		}
		
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
	</script>
	
	
	<script>	
		$(function() {
			function preview(input) {				
				if (input.files && input.files[0]) {
					var reader = new FileReader();
					reader.onload = function(e) {
						$('#img0').attr({
							'src' : e.target.result,
							'id' : 'change'
						});
					}
					reader.readAsDataURL(input.files[0]);
				}
				if (input.files && input.files[1]) {
					var reader = new FileReader();
					reader.onload = function(e) {
						$('#img1').attr({
							'src' : e.target.result,
							'id' : 'change'
						});
					}
					reader.readAsDataURL(input.files[1]);
				}
				if (input.files && input.files[2]) {
					var reader = new FileReader();
					reader.onload = function(e) {
						$('#img2').attr({
							'src' : e.target.result,
							'id' : 'change'
						});
					}
					reader.readAsDataURL(input.files[2]);
				}
				if (input.files && input.files[3]) {
					var reader = new FileReader();
					reader.onload = function(e) {
						$('#img3').attr({
							'src' : e.target.result,
							'id' : 'change'
						});
					}
					reader.readAsDataURL(input.files[3]);
				}
			}

			$('input[type="file"]').bind("change",function(event) {
				preview(this);
			})
		})
	</script>
	

</body>
</html>