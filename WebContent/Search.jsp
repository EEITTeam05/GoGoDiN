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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css"
	integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.20/css/uikit.min.css" />
<link rel="stylesheet" href="css/search.css">
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
					<input type="text" class="form-control" id="txtSearch"
						name="search" autocomplete="off" placeholder="搜尋想找的餐廳   例如:牛排">
					<span class="input-group-btn"> <input
						class="btn btn-default" type="submit" id="buttonLoad" value="Go!">
					</span>
				</div>
			</form>
			<div id="div1"></div>


			<!-- 每頁不同的內容到這裡結束 -->
		</div>
		<div id="div2" class="row"></div>
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
	<!-- Site footer -->
	<!-- /container -->
	<script
		src="//cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.20/js/uikit.min.js"></script>
	<!-- 　<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script> -->
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
		integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
		crossorigin="anonymous"></script>
	<script src="js/jquery-mark-min.js"></script>

	<script language="javascript">
		var show;
		$(function() {
			txt = $('#txtSearch');
			txt.on('keyup', getData);
			show = $('#div1');
		})
		function getData() {
			$.getJSON('SearchBar.do', {
				'search' : txt.val()
			}, function(datas) {
				show.css('display', "block");
				if (datas.length > 0) {
					var eleDiv = $('<div></div>');
					if (show.children().length > 0) {
						show.children().remove();
					}
					var docFrag = $(document.createDocumentFragment());
					for (var j = 0, max = datas.length; j < max; j++) {
						var txth4 = $('<h5></h5>').addClass(
								'list-group-item-heading'); //搜尋店名
						var str = $('<strong></strong>')
								.text(datas[j].RestName).appendTo(txth4);
						txth4.mark(txt.val());
						var addp = $('<span></span>').text(datas[j].RestAddr)
								.addClass('list-group-item-text');//搜尋-地址
						//var mark = $('<mark></mark>');
						addp.mark(txt.val());

						var badgeRate = $('<span></span>').text(
								"評分：" + datas[j].RestRate).addClass('badge')//搜尋-評分			

						var eleBtn = $('<button></button').addClass(
								'list-group-item').attr('type', 'button')
								.append(txth4).append(addp).append(badgeRate);

						eleBtn.on('click', function() {
							txt.val($(this).children('h5').text());
							show.css('display', 'none');
						});
						docFrag.append(eleBtn);
					}
					show.append(docFrag);
				}
				if (datas.length == 0 && show.children().length > 0) {
					show.children().remove();
				}
			})
		}
	</script>
</body>

</html>