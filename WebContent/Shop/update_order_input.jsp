<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.GregorianCalendar"%>
<%@ page import="java.sql.Timestamp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
table{
	margin-left: 20px;
}




</style>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css"
	integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ"
	crossorigin="anonymous">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.20/css/uikit.min.css" />
<link rel="stylesheet" href="../css/search.css">
<link rel="stylesheet" href="../css/normalize.css">
<link rel="stylesheet" href="../css/asPieProgress.min.css">
<link rel="stylesheet" href="../css/jquery-ui.min.css">
<link rel="stylesheet" href="../css/jquery.datetimepicker.min.css">
<link rel="stylesheet" href="../css/sweetalert.css">
<link rel="stylesheet" href="../css/jquery.timepicker.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>訂單內容</title>
</head>
<body>
	<a href="<%=request.getContextPath()%>/index.jsp">回首頁</a>
	<hr>
	<c:if test="${! empty errorMsgs }" >
		<font size="-1" color="red">${errorMsgs.error}</font>
	</c:if>
	
	<c:if test="${! empty ShopLoginOK }">
		<table border='1' bordercolor='#CCCCFF' width='400'>
			    <tr>
					<th>訂單編號</th>
					<td>${OrderVO.orderNum }</td>
				</tr>
				<tr>
					<th>會員姓名</th>
					<td>${OrderVO.memVO.memName }</td>
				</tr>
				<tr>
					<th>訂單時間</th>
					<td>${OrderVO.bidTime }</td>
				</tr>
				
				<tr>
					<th>餐廳名稱</th>
					<td>${OrderVO.restVO.restName }</td>
				</tr>
				
				<tr>
					<th>訂位日期</th>
					<td><input id="datepicker" type="text" readonly="readonly" style="cursor: pointer;"> </td>
				</tr>
				
				<tr>
					<th>訂位時間</th>
					<td><input id="timepicker" type="text" autocomplete="off" value="${OrderVO.orderTime }"></td>
				</tr>
				
				<tr>
					<th>訂位人數</th>
					<td>
					  <select id="select1" style="display: inline-block; width: 200px;">
							<option value="1">1 人</option>
					  </select>
					</td>
				</tr>
			
			   <tr>
			        <th></th>
					<td>
					<input type="button" class="btn btn-primary float-right" id="upd" value="修改">		
					</td>
				</tr>
		</table>
	</c:if>
	
	
		
	<script	src="//cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.20/js/uikit.min.js"></script>	
	<script src="../js/jquery-mark-min.js"></script>
	<script	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA86fMRXUcXBspzmQgFZ0QTrxumNTvAz-I" async defer></script>
	<script src="../js/jquery.tinyMap.min.js"></script>
	<script src="../js/jquery-ui.min.js"></script>
	<script src="../js/jquery-asPieProgress.min.js"></script>
	<script src="../js/jquery.googlemap.js"></script>
	<script src="../js/sweetalert.min.js"></script>
	<script src="../js/jquery.timepicker.min.js"></script>
	
	<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
		integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
		crossorigin="anonymous"></script>
</body>



<script type="text/javascript">
$(function(){
	var date = new Date('${OrderVO.orderDate }');
	date.setDate(date.getDate()); //預設日期 就是DB的日期
	$('#datepicker').val($.datepicker.formatDate('yy-mm-dd',date)).
	datepicker({minDate: +1, maxDate: "+1M +1D",dateFormat:"yy-mm-dd" })
	$('#timepicker').timepicker({
		'timeFormat': 'H:i',
		'step':60,
		'minTime': '${OrderVO.restVO.restStart}',
		'maxTime': '${OrderVO.restVO.restEnd}',
		'disableTextInput':true
	});
	
	for(var i =2;i<=20;i++){
		$('#select1').append(new Option(i+" 人",i));	
	}
	$('option[value="${OrderVO.pnum}"]').attr('selected','selected');
	
});
$('#datepicker').on('change',seat);
$('#select1').on('change',seat)
$('#upd').on('click',function(){
	if(!$('#timepicker').val()||!$('#datepicker').val()){
		   swal("修改失敗!","請選擇訂位時間","error")
		   return;
		}		
		swal({
			  title: "確定要修改嗎?",
			  type: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#3085d6",
			  confirmButtonText: "馬上修改!",
			  cancelButtonText: "考慮一下",
			  closeOnConfirm: false,
			  showLoaderOnConfirm: true,
			},function(){
				$.post('<%=request.getContextPath()%>/OrderSeat.do',{
					'restName':'${OrderVO.restVO.restName }',
					'orderdate':$('#datepicker').val(),
					'ordertime':$('#timepicker').val(),
					'pNum':$('#select1').val(),
					'action':'update',
				},setTimeout(function(data){
					if(<%=session.getAttribute("ShopLoginOK") != null%>){
						 swal("修改成功!", "已寄送通知至您的收件匣", "success");
						 
						 $('button[class="confirm"]').on('click',function(){
							 window.location.href="<%=request.getContextPath()%>/Shop/listOrderDetail.jsp";
						 });						 
					}
			},1200));
		});
	});
/* 查看是否還有位置  */
function seat(){
	var timepick = $('#timepicker');
	timepick.val("");
	$.get('<%=request.getContextPath()%>/OrderServlet.do',{
		'restName':'${OrderVO.restVO.restName}',
		'orderdate':$('#datepicker').val(),
		'pNum':$('#select1').val(),
		'action':'update',
	},function(data2){
		var data3 = $.parseJSON(data2);
		timepick.timepicker(
			'option',{"disableTimeRanges":data3.array}
		)
	})
};
</script>	
</html>