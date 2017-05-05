<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css"
	integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.20/css/uikit.min.css" />
<link rel="stylesheet" href="css/search.css">
<link rel="stylesheet" href="css/normalize.css">
<link rel="stylesheet" href="css/asPieProgress.min.css">
<link rel="stylesheet" href="css/jquery-ui.min.css">
<link rel="stylesheet" href="css/jquery.datetimepicker.min.css">
<link rel="stylesheet" href="css/sweetalert.css">
<link rel="stylesheet" href="css/jquery.timepicker.css">
<style type="text/css">
.pie_progress {
	width: 160px;
	margin: 10px auto;
}

div.pie_progress {
	position: absolute;
	width: 160px;
	height: 160px;
	top: 50%;
	left: 50%;
	margin-top: -185px;
	margin-left: -80px;
}

@media all and (max-width: 768px) {
	.pie_progress {
		width: 80%;
		max-width: 300px;
	}
}

div.carousel-inner {
	width: 100%;
	max-height: 460px !important;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${restdetail.RestName}</title>
</head>
<body>
	<jsp:include page="navbar.jsp"></jsp:include>
	<div class="container">
		<div id="div2" class="row">
			<div class="col-9 col-md-auto offset-md-2 bd-content">
				<div id="carouselExampleIndicators" class="carousel slide"
					data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#carouselExampleIndicators" data-slide-to="0"
							class="active"></li>
						<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
						<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner" role="listbox">
						<div class="item active">
							<img class="d-block img-fluid"
								src='${pageContext.servletContext.contextPath}/init/getImage?id=${restdetail.RestId}&photo=1&type=RestPhoto'
								alt="First slide" height="468px" width="832px">
						</div>
						<div class="item">
							<img class="d-block img-fluid"
								src='${pageContext.servletContext.contextPath}/init/getImage?id=${restdetail.RestId}&photo=2&type=RestPhoto'
								alt="Second slide" height="468px" width="832px">
						</div>
						<div class="item">
							<img class="d-block img-fluid"
								src='${pageContext.servletContext.contextPath}/init/getImage?id=${restdetail.RestId}&photo=3&type=RestPhoto'
								alt="Third slide" height="468px" width="832px">
						</div>
					</div>
					<a class="carousel-control-prev" href="#carouselExampleIndicators"
						role="button" data-slide="prev"> <span
						class="carousel-control-prev-icon" aria-hidden="true"></span><span
						class="sr-only">Previous</span>
					</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
						role="button" data-slide="next"> <span
						class="carousel-control-next-icon" aria-hidden="true"></span> <span
						class="sr-only">Next</span>
					</a>
				</div>
				<div class="card-block">
					<h3 class="uk-heading-bullet" id="restName"
						style="display: inline-block;">${restdetail.RestName}</h3>
					<button type="button" class="btn btn-info float-right" id="button2"
						data-toggle="modal" data-target="#sendmail"
						data-whatever="@${restdetail.RestName}">寄信給
						@${restdetail.RestName}</button>
					<div class="pie_progress" role="progressbar"
						data-goal="${restdetail.RestRate}">
						<div class="pie_progress__number">0</div>
						<div class="pie_progress__label">評分</div>
					</div>
					<p class="card-text">${restdetail.RestAddr}</p>
						<i id="collect" style="color: red;" class="fa fa-heart-o fa-2x" aria-hidden="true" data-toggle="popover" 
						data-trigger="hover" data-placement="left" data-content="收藏 ${restdetail.RestName} !"></i>
						<c:forEach var="favorVO" items="${favoritelist}">
							<c:choose>
								<c:when test="${favorVO.restVO.restId == restdetail.RestId}">
									<script type="text/javascript">
									$('#collect').attr({
										'class':'fa fa-heart fa-2x',
									 	'id':'collected',
										'data-content':'取消收藏'
									})
									</script>
								</c:when>
							</c:choose>
						</c:forEach>
					<input type="button" class="btn btn-primary float-right" id="din"
						value="我要預訂">
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">訂位專區</div>
					<div class="panel-body">
						一般訂位 <input id="datepicker" type="text" readonly="readonly"
							style="cursor: pointer;"> <label
							style="margin-left: 2em;">選擇人數</label> 
							<select id="select1" style="display: inline-block; width: 200px;">
							<option value="1">1 人</option>
						</select> <label style="margin-left: 2em;">選擇時間</label> <input
							id="timepicker" type="text" autocomplete="off">
					</div>
						<div class="panel-heading">餐廳簡介</div>
						<div class="panel-body"><i class="fa fa-quote-left fa-2x fa-pull-left fa-border" aria-hidden="true"></i><p class="lead">${restdetail.RestBrief}</h3></div>

						<div class="panel-heading">餐廳地址</div>
						<div class="panel-body">
							<div id="map" style="width: 800px; height: 300px;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="sendmail" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">New message</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label for="recipient-name" class="form-control-label">收件者:</label>
							<input type="text" class="form-control" disabled
								id="recipient-name">
						</div>
						<div class="form-group">
							<label for="message-text" class="form-control-label">訊息:</label>
							<textarea class="form-control" id="message-text"></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">關閉</button>
					<button type="button" class="btn btn-primary" id="send">寄信</button>
				</div>
			</div>
		</div>
	</div>

	<script
		src="//cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.20/js/uikit.min.js"></script>
	<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script> -->
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
		integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
		crossorigin="anonymous"></script>
	<script src="js/jquery-mark-min.js"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA86fMRXUcXBspzmQgFZ0QTrxumNTvAz-I"
		async defer></script>
	<script src="js/jquery.tinyMap.min.js"></script>
	<script src="js/jquery-ui.min.js"></script>
	<script src="js/jquery-asPieProgress.min.js"></script>
	<script type="text/javascript" src="js/jquery.googlemap.js"></script>
	<script type="text/javascript" src="js/sweetalert.min.js"></script>
	<script type="text/javascript" src="js/jquery.timepicker.min.js"></script>
</body>
<script type="text/javascript">
$(function(){
	$('.carousel').carousel({
		  interval: 2500
	});
	$('[data-toggle="popover"]').popover();   
	var date = new Date();
	date.setDate(date.getDate() + 1); //預設日期 本日+1天
	$('#datepicker').val($.datepicker.formatDate('yy-mm-dd',date)).
	datepicker({minDate: +1, maxDate: "+1M +1D",dateFormat:"yy-mm-dd" })
	$('#timepicker').timepicker({
		'timeFormat': 'H:i',
		'step':60,
		'minTime': '${restdetail.RestStart}',
		'maxTime': '${restdetail.RestEnd}',
		'disableTextInput':true
	});
	$('#map').tinyMap({
		'center':'${restdetail.RestAddr}',
		'zoom':17,
		'scrollwheel': false,
		'marker':[{
			'addr':'${restdetail.RestAddr}'
		}]
	});
	for(var i =2;i<=20;i++){
		$('#select1').append(new Option(i+" 人",i));
	}
	$('.pie_progress').asPieProgress({
        namespace: 'pie_progress',
        barsize: '10',
        speed:'30',
        				 /*  評分    >= 75                 綠色           否則           紅色                */
        barcolor: ${restdetail.RestRate} >= 75 ? '#1D9D74' : '#E44134'}).asPieProgress('start');

});
$('#div2').on('change','#datepicker',seat);
			$('#div2').on('change','#select1',seat)
			$('#div2').on('click','#din',function(){
						if(!$('#timepicker').val()||!$('#datepicker').val()){
						   swal("訂位失敗!","請選擇訂位時間","error")
						   return;
						}
						if(<%=session.getAttribute("LoginOK") == null%>){
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
									'restName':'${restdetail.RestName}',
									'orderdate':$('#datepicker').val(),
									'ordertime':$('#timepicker').val(),
									'pNum':$('#select1').val(),
									'action':'add',
								},setTimeout(function(data){
									if(<%=session.getAttribute("LoginOK") != null%>){
										 swal("訂位成功!", "已寄送通知至您的收件匣", "success");
									}
							},1200));
						});
					});
			
			$('#div2').on('click','#button2',function(){
				if(<%=session.getAttribute("LoginOK") == null%>){
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
					'restName':'${restdetail.RestName}',
					'orderdate':$('#datepicker').val(),
					'pNum':$('#select1').val(),
					'action':'add',
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
			$('div.card-block').on('mouseenter','#collected',function(){
				$(this).attr({
					'class':'fa fa-heartbeat fa-2x',
				}).css({'cursor': 'pointer'})
				$(this).css({'cursor': 'pointer','color':'gray'})
			}).on('mouseleave','#collected',function(){
				$(this).attr({
					'class':'fa fa-heart fa-2x'
				})
				$(this).css({'cursor': 'pointer','color':'red'})
			});
			$('div.card-block').on('click','#collected',function(){
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
								'restId': ${restdetail.RestId},
								'action':'DeleteFromSearch'
							},setTimeout(function(data){
								if(<%= session.getAttribute("LoginOK")!=null%>){
									 swal("取消成功!", "", "success");
									 $('#collected').attr(
												{'class':'fa fa-heart-o fa-2x',
												 'id':'collect',
												 'data-content':'收藏 ${restdetail.RestName} !'
									  });
								}
						}));
					});
					return;
			})
			$('div.card-block').on('mouseenter','#collect',function(){
				$(this).attr({
					'class':'fa fa-heart fa-2x',
				}).css({'cursor': 'pointer'})
			}).on('mouseleave','#collect',function(){
				$(this).attr({
					'class':'fa fa-heart-o fa-2x'
				})
			});
			
			$('div.card-block').on('click','#collect',function(){
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
							'restId': ${restdetail.RestId}
						},setTimeout(function(data){
							if(<%= session.getAttribute("LoginOK")!=null%>){
								 swal("收藏成功!", "已收藏至會員專屬功能", "success");
								 $('#collect').attr(
											{'class':'fa fa-heart fa-2x',
											 'id':'collected',
											 'data-content':'取消收藏'
								  });
							}
					},800));
				});
				return;
			})
</script>
</html>