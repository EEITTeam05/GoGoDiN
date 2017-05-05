<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.member.Model.MemberListVO"%>
<%@page import="com.favorite.Model.*"%>
<html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GoGoDiN</title>
<style type="text/css">
a.list-group-item {
    height:auto;
    min-height:220px;
}
a.list-group-item.active small {
    color:#fff;
}
.stars {
    margin:20px auto 1px;    
}
.glyphicon.glyphicon-heart{
	color:red;
}
.btn.btn-outline-danger{
	border:1px solid transparent;
	border-color: #c9302c;
}
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
<!-- <link rel="stylesheet" href="css/bootstrap.min.css"> -->
<link rel="stylesheet" href="css/search.css">
<link rel="stylesheet" href="css/normalize.css">
<link rel="stylesheet" href="css/jquery-ui.min.css">
<link rel="stylesheet" href="css/sweetalert.css">
<link href="<%=request.getContextPath()%>/css/star-rating.min.css" media="all" rel="stylesheet" type="text/css" />
</head>
<body>
<jsp:include page="navbar.jsp"></jsp:include>
	<div class="container">
		<!-- Jumbotron -->
		<div class="jumbotron">
			<div class="page-header">
				<h3>
					搜尋餐廳 <small>AutoComplete</small>
				</h3>
			</div>
			<!-- 每頁不同的內容從這裡開始 -->

			<form name="myData" method="get" action="SearchList.do">
				<div class="input-group">
						<input type="text" class="form-control" id="txtSearch" name="search" value="${param.search}"
						 autocomplete="off" placeholder="搜尋想找的餐廳   例如:牛排">
	     				<span class="input-group-btn">
		       			<input class="btn btn-default" type="submit" id="buttonLoad" value="Go!">
		       			</span>
				</div>
			</form>
				<div id="div1"></div>
			<!-- 每頁不同的內容到這裡結束 -->
		</div>
			<div id="div2" class="row" >
			<div class="container">
    <div class="row">
		<div class="well" style="width: 1170px;" >
        <div class="alert alert-success" role="alert">
		  <p class="text-right">搜尋關鍵字<strong> ${param.search}</strong> 的餐廳　約有 ${searchlist.size()} 項餐廳符合</p>
		</div>
        <c:forEach var="itemlist" items="${searchlist}">
        <div class="list-group" data-id="${itemlist.RestName}" data-id2="${itemlist.RestId}" id="listgroup">
          <a class="list-group-item">
                <div class="media col-md-3">
                    <figure class="pull-left">
                        <img class="media-object img-rounded img-responsive"  
                        src='${pageContext.servletContext.contextPath}/init/getImage?id=1&restname=${itemlist.RestName }&type=Rest' 
                        alt="${itemlist.RestName}" >
                    </figure>
                </div>
                <div class="col-md-6">
                    <h4 class="list-group-item-heading"><strong> ${itemlist.RestName}</strong></mark> </h4>
                    <h4 class="list-group-item-text"> ${itemlist.RestBrief}</h4>
                </div>
                <div class="col-md-3 text-center">
                <button id="favoriteBtn${itemlist.RestId}" data-id='${itemlist.RestId}' type="button" style="margin-top:10px;" class="btn btn-outline-danger btn-lg btn-block favorite">
	 					 		<span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span> 收藏
	 			</button>
						<c:forEach var="favorVO" items="${favoritelist}">
							<c:choose>
								<c:when test="${favorVO.restVO.restId == itemlist.RestId}">
								<script type="text/javascript">
									var btnid = $('button[id$=Btn${favorVO.restVO.restId}]');
									var heart = btnid.children().css({'color':'white','margin-right':'3px'}).attr('class','glyphicon glyphicon-heart');
									btnid.attr({
										'class':'btn btn-danger btn-lg btn-block',
										'id':'favoritecancel',
										'data-id':${favorVO.restVO.restId}
									}).text('已收藏').prepend(heart);
								</script>
		 					 	</c:when>
		 					 </c:choose>
						</c:forEach>
                    <br>
						<input id="input-6" name="input-6" 
						class="rating rating-loading" value="${itemlist.RestRate}" data-size="xs"
						data-min="0" data-max="100" 
						data-show-clear="false" data-show-caption="false" data-readonly="true">
                	    <p> 評分 ${itemlist.RestRate}<small> / </small> 100 </p>
             	   </div>
         		 </a> 
        	</div>
       	</c:forEach>
        </div>
	</div>
</div>
			</div>
		</div>
		<!-- Site footer -->
	<!-- /container -->
<script src="//cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script> -->
<script src="js/jquery-mark-min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/sweetalert.min.js"></script>
<script src="js/star-rating.min.js"></script>
	<script language="javascript">
		var show;
		$(function(){
			txt = $('#txtSearch');
			txt.on('keyup',getData);
			show = $('#div1');
		})
		function getData() {
			$.getJSON('SearchBar.do',{'search':txt.val()},function(datas){
				show.css('display',"block");
				if(datas.length>0){	
					var eleDiv = $('<div></div>');
				if (show.children().length > 0) {
					show.children().remove();
				}	
				var docFrag = $(document.createDocumentFragment());
					for (var j = 0, max = datas.length; j < max; j++) {
							var txth4 = $('<h5></h5>').addClass('list-group-item-heading');	 //搜尋店名
							var str = $('<strong></strong>').text(datas[j].RestName).appendTo(txth4);
						    txth4.mark(txt.val());			  
							var addp = $('<span></span>').text(datas[j].RestAddr)
														.addClass('list-group-item-text');//搜尋-地址
							//var mark = $('<mark></mark>');
							addp.mark(txt.val());

							var badgeRate = $('<span></span>').text("評分：" + datas[j].RestRate)
														      .addClass('badge')//搜尋-評分			
														      
							var eleBtn = $('<button></button').addClass('list-group-item')
															  .attr('type','button')
															  .append(txth4)
															  .append(addp)
															  .append(badgeRate);
														
							eleBtn.on('click',function() {
									txt.val($(this).children('h5').text());
									show.css('display','none');
									geneator();
							});
							
							docFrag.append(eleBtn);
						}
						show.append(docFrag);
				}
				if (datas.length == 0&&show.children().length > 0) {
						show.children().remove();
				}
				
			})
		}
		var myDiv = $('#div2');
		myDiv.on('mouseenter','button.btn.favorite',function(){
				$(this).attr('class','btn btn-danger btn-lg btn-block favorite')
				$(this).children().css('color','white');
		});
		myDiv.on('mouseleave','button.btn.favorite',function(){
				$(this).attr('class','btn btn-outline-danger btn-lg btn-block favorite');
				$(this).children().css('color','red');
		});
		myDiv.on('click','div.list-group',function(e){
				var target = $(e.target);
				var dataid2 = $(this).attr('data-id2');
				var dataid = $(this).attr('data-id');
				var ident = target.attr('id');
				if(ident!=null&&ident.startsWith("favoriteBtn")){
					if(<%= session.getAttribute("LoginOK")==null%>){
						   swal("收藏失敗!","請先登入會員","error")
						   return;
						}
						swal({
							  title: "確定要收藏嗎?",
							  type: "warning",
							  showCancelButton: true,
							  confirmButtonColor: "#3085d6",
							  confirmButtonText: "馬上收藏!",
							  cancelButtonText: "考慮一下",
							  closeOnConfirm: false,
							  showLoaderOnConfirm: true,
						},function(){
								$.post('favorite.do',{
									'restId': dataid2
								},setTimeout(function(data){
									if(<%= session.getAttribute("LoginOK")!=null%>){
										 swal("收藏成功!", "已收藏至會員專屬功能", "success");
										 var heart = $('<span></span>').css({'color':'white','margin-right':'3px'}).addClass('glyphicon glyphicon-heart');
										 target.attr(
													{'class':'btn btn-danger btn-lg btn-block',
													 'id':'favoritecancel',
											}).text('已收藏').prepend(heart);
									}
							},800));
						});
						return;
				}
				if(ident!=null&&ident.startsWith('favoritecancel')){
					if(<%= session.getAttribute("LoginOK")==null%>){
						   swal("失敗!","請先登入會員","error")
						   return;
						}
						swal({
							  title: "確定要取消收藏嗎?",
							  type: "warning",
							  showCancelButton: true,
							  confirmButtonColor: "#3085d6",
							  confirmButtonText: "是的!",
							  cancelButtonText: "考慮一下",
							  closeOnConfirm: false,
							  showLoaderOnConfirm: true,
						},function(){
								$.post('Member/DeleteFavorite.do',{
									'restId': dataid2,
									'action':'DeleteFromSearch'
								},setTimeout(function(data){
									if(<%= session.getAttribute("LoginOK")!=null%>){
										 swal("取消成功!", "", "success");
										 var heart = $('<span</span>').css('margin-right','3px').addClass('glyphicon glyphicon-heart-empty')
										 target.attr(
													{'class':'btn btn-outline-danger btn-lg btn-block favorite',
													 'id':'favoriteBtn'+dataid,
											}).text('收藏').prepend(heart);
									}
							}));
						});
						return;
				}
			$.get('SearchPage.do',{'search':dataid},function(data){
				window.location.href="SearchPage.do?search="+dataid;
			})
			});
			$('#div2').on('change','#datepicker',seat);
			$('#div2').on('change','#select1',seat)
			$('#div2').on('click','#din',function(){
						if(!$('#timepicker').val()||!$('#datepicker').val()){
						   swal("訂位失敗!","請選擇訂位時間","error")
						   return;
						}
						if(<%= session.getAttribute("LoginOK")==null%>){
						   swal("訂位失敗!","請先登入會員","error")
						   return;
						}
						swal({
							  title: "確定要訂位嗎?",
							  type: "warning",
							  showCancelButton: true,
							  confirmButtonColor: "#3085d6",
							  confirmButtonText: "馬上訂位!",
							  cancelButtonText: "待會再說",
							  closeOnConfirm: false,
							  showLoaderOnConfirm: true,
							},function(){
								$.post('OrderSeat.do',{
									'restName':$('#restName').text(),
									'orderdate':$('#datepicker').val(),
									'ordertime':$('#timepicker').val(),
									'pNum':$('#select1').val(),
								},setTimeout(function(data){
									if(<%= session.getAttribute("LoginOK")!=null%>){
										 swal("訂位成功!", "已寄送通知至您的收件匣", "success");
									}
							},1200));
						});
					});
			
			$('#div2').on('click','#button2',function(){
				if(<%= session.getAttribute("LoginOK")==null%>){
					$('#button2').removeAttr('data-target');
					swal("寄信失敗!","請先登入會員","error");
				}
			})
			$('#sendmail').on('show.bs.modal', function (event) {
				  var button = $(event.relatedTarget) // Button that triggered the modal
				  var recipient = button.data('whatever') // Extract info from data-* attributes
				  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
				  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
				  var modal = $(this);
				  modal.find('.modal-title').text('寄信給   ' + recipient)
				  modal.find('.modal-body input').val(recipient.replace("@",''))
				});
			/* 查看是否還有位置  */
			function seat(){
				var timepick = $('#timepicker');
				timepick.val("");
				$.get('OrderServlet.do',{
					'restName':$('#restName').text(),
					'orderdate':$('#datepicker').val(),
					'pNum':$('#select1').val(),
				},function(data2){
					var data3 = $.parseJSON(data2);
					timepick.timepicker(
						'option',{"disableTimeRanges":data3.array}
					)
				})
			};
			$('#send').click(function(){
				$.post('<%=request.getContextPath()%>/MessageServlet',{
					'RestName':$('#recipient-name').val(),
					'Message':$('#message-text').val(),
					'action':'MemberSendToShop'
					},function(data){
						$('#sendmail').modal('hide')
						 swal("信件已寄出!", "", "success");
					});
			});
			</script>
</body>

</html>