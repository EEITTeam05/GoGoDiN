<%@page import="com.order.Model.OrderVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Date" %>
<jsp:useBean id="listOrder_ByMemid" scope="session" type="java.util.List" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.20/css/uikit.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/sweetalert.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/search.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/sweetalert.min.js"></script>
<link href="<%=request.getContextPath()%>/css/star-rating.min.css" media="all" rel="stylesheet" type="text/css" />
<style>
.box {
    background: white;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 5px;
    box-shadow: 1px 1px 3px #666;
}
span.label{
	margin-left: 15px;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查詢訂單</title>

</head>
<body bgcolor='white'>

<c:if test="${! empty LoginOK }">
  <table border='1' style="float:left;" bordercolor='#CCCCFF' width='1200' >
	<tr align='center' valign='middle'>
		<th>訂單編號</th>
		<th>會員姓名</th>
		<th>業主編號</th>
		<th>餐廳名稱</th>
		<th>訂位時間</th>
		<th>訂位人數</th>
		<th>訂單時間</th>		
		<th>餐廳資訊</th>	
		<th>餐廳評分</th>
	</tr>
	<c:forEach var="orderVO" items="${listOrder_ByMemid}" >
		<tr align='center' valign='middle'> 
			<td>${orderVO.orderNum}</td>
			<td>${orderVO.memVO.memName}</td>
			<td>${orderVO.shopId}</td>
			<td>${orderVO.restVO.restName}</td>			
			<td>${orderVO.orderDate} ${orderVO.orderTime}</td>
			<td>${orderVO.pnum}</td>
			<td>${orderVO.bidTime}</td>				 
			<td>
				<input type="button" value="查詢" data-restid="${orderVO.restVO.restName}" data-id="${orderVO.restVO.restName}" data-addr="${orderVO.restVO.restaddr}"></input>	        
			</td>
			<td>
			<c:choose>
				<c:when test="${orderVO.isRate}">
					<input id="rateStar" type="text" readonly="true" 
					value="${orderVO.rate}"  class="rating rating-loading" data-size="xs" 
					data-min="0" data-max="100" data-show-clear="false" >
				</c:when>
				<c:when test="${orderVO.orderDate < Date()}">
					<input id="rateStar" type="text" value="${orderVO.rate}" 
					data-name="${orderVO.restVO.restName}" data-id="${orderVO.orderNum}" 
					class="rating rating-loading" data-size="xs" data-min="0" data-max="100" data-step="5"
					data-show-clear="false">
				</c:when>
				<c:when test="${orderVO.orderDate >= Date()}">
					<input id="NonrateStar" type="text" readonly="true" value="${orderVO.rate}" 
					data-name="${orderVO.restVO.restName}" data-id="${orderVO.orderNum}" 
					class="rating rating-loading" data-size="xs" data-min="0" data-max="100" data-step="5"
					data-show-clear="false">
				</c:when>
			</c:choose>
			</td>
		</tr>		
	</c:forEach>
</table>
</c:if>
<div id="myMap" style="width:800px;height:300px;"></div>
<input type="button" onclick=history.back() value="回上頁" />
<div id="myDiv"></div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.20/js/uikit.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA86fMRXUcXBspzmQgFZ0QTrxumNTvAz-I" async defer></script>
<script src="<%=request.getContextPath()%>/js/jquery.tinyMap.min.js"></script>
<script src="<%=request.getContextPath()%>/js/star-rating.min.js"></script>  
<script type="text/javascript">
var myDiv = $('#myDiv');
var restid;
$('td > input[type="button"]').on('click',function(){
	restName = $(this).attr("data-id");
	restAddr = $(this).attr("data-addr");
	restId = $(this).attr("data-restid");
	$('tr').removeAttr('style').children().removeAttr('style');
	$(this).parent().parent().css({'background-color':'#DB4437'}).find('td:lt(7)').css('color','white');
	mapGo();
})
function mapGo(){
		var MapChange = $('#myMap');
		MapChange.tinyMap('destroy');
		MapChange.tinyMap({
			'center':restAddr,
			'zoom':17,
			'markerWithLabel': true,
			'marker':[{
				'addr':restAddr,
				'labelContent':'<strong>'+restName+'</strong><span id="info" class="label label-default">點我看詳情</span><div><img style="width:150px;height:100px" src="${pageContext.servletContext.contextPath}/init/getImage?id=1&restname='+restName+'&type=Rest"/></div>' ,
				'labelClass':'box',
				'icon':{
					'path':'M 0 0'
				},'event':{
				'click':{
					'func':function(e){
						window.location.href='<%=request.getContextPath()%>/SearchPage.do?search=' + restId
						},'once': true //僅執行一次
					}
                }
			}]
		})
	};
	 $('td').on('rating.change','#rateStar',function(event,value,caption){
		var star = $(this);
		var orderNum = star.attr("data-id");
		var restName = star.attr("data-name");
		 swal({
			  title: "確定要給評分?",
			  text: "你確定要給["+restName+"] "+value+"分?",
			  type: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#DD6B55",
			  confirmButtonText: "是的, "+value+" 分!",
			  cancelButtonText: "待會再說",
			  closeOnConfirm: false
			},
			function(isConfirm){
				if(isConfirm){
					  swal("已評分!", "謝謝您的評分.", "success");
				      $.post('<%=request.getContextPath()%>/OrderRateServlet.do',{'orderNum':orderNum,'rate':value,'restName':restName},function(){})
					  star.rating("refresh", {disabled:true, showClear:false});
				}else{
					  star.rating("reset");
				}
			});
	 })
</script>

</html>