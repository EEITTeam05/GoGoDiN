<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="A layout example that shows off a responsive email layout.">
<link rel="stylesheet"
	href="https://unpkg.com/purecss@0.6.2/build/pure-min.css"
	integrity="sha384-" crossorigin="anonymous">
<link rel="stylesheet" href="css/layouts/email.css">
<title>Insert title here</title>
</head>
<body>
	<div id="layout" class="content pure-g">
		<div id="nav" class="pure-u">
			<a href="#" class="nav-menu-button">Menu</a>
			<div class="nav-inner">
				<a class="navbar-brand"
					href="<%=request.getContextPath()%>/index.jsp"
					style="height: 100px"> <img class="d-inline-block align-top"
					src="<%=request.getContextPath()%>/images/Logo.png"
					style="width: 150px;">
				</a>
				<button class="primary-button pure-button">寄信</button>
				<div class="pure-menu">
					<ul class="pure-menu-list">
						<li class="pure-menu-item"><a href="#" class="pure-menu-link">收件匣
								<span class="email-count">(2)</span>
						</a></li>
						<li class="pure-menu-item"><a href="#" class="pure-menu-link">訂位通知
								<span class="email-count">(2)</span>
						</a></li>
						<li class="pure-menu-item"><a href="#" class="pure-menu-link">已加星號</a></li>
						<li class="pure-menu-item"><a href="#" class="pure-menu-link">系統通知
						</a></li>
						<li class="pure-menu-item"><a href="#" class="pure-menu-link">送件匣</a></li>
						<li class="pure-menu-item"><a href="#" class="pure-menu-link">所有信件</a></li>
						<li class="pure-menu-heading">Labels</li>
						<li class="pure-menu-item"><a href="#" class="pure-menu-link"><span
								class="email-label-personal"></span>一般</a></li>
						<li class="pure-menu-item"><a href="#" class="pure-menu-link"><span
								class="email-label-work"></span>訂位通知</a></li>
						<li class="pure-menu-item"><a href="#" class="pure-menu-link"><span
								class="email-label-travel"></span>重要通知</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 	email-item-selected 選擇的 -->
		<!-- 	email-item-unread 未讀的 -->
		<div id="list" class="pure-u-1">
			<c:forEach var="VO" items="${list}">
				<c:set var="string1" value="${VO.message}" />
				<c:set var="string2" value="${fn:substring(string1 , 0, 22)}" />
				<div class="email-item pure-g" style="cursor: pointer;">
					<c:choose>
						<c:when test="${VO.sendAccount=='admin'}">
							<div class="pure-u">
								<img width="64" height="64" alt="${VO.mesId}"
									class="email-avatar"
									src="<%=request.getContextPath()%>/images/admin.png">
							</div>
						</c:when>
						<c:otherwise>
							<div class="pure-u">
								<img width="64" height="64" alt="${VO.mesId}"
									class="email-avatar"
									src="<%=request.getContextPath()%>/init/getImage?id=${VO.sendAccount}&type=AccountImg">
							</div>
						</c:otherwise>
					</c:choose>
					<div class="pure-u-3-4">
						<h5 class="email-name">${VO.sendAccount}</h5>
						<span hidden class="email-time">${VO.sendtime}</span>
						<h4 class="email-subject">${VO.title}</h4>
						<p class="email-desc">${string2}</p>
						<div hidden class="email-real">
							<p>${VO.message}</p>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
		<div hidden id="main" class="pure-u-1">
			<div class="email-content">
				<div class="email-content-header pure-g">
					<div class="pure-u-1-2">
						<h1 class="email-content-title">Hello from Toronto</h1>
						<p class="email-content-subtitle">
							From <a>Tilo Mitra</a> at <span>3:56pm, April 3, 2012</span>
						</p>
					</div>

					<div class="email-content-controls pure-u-1-2">
						<button class="secondary-button pure-button">Reply</button>
						<button class="secondary-button pure-button">Forward</button>
						<button class="secondary-button pure-button">Move to</button>
					</div>
				</div>

				<div class="email-content-body" style="width: 920px;"></div>
			</div>
		</div>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://yui-s.yahooapis.com/3.18.1/build/yui/yui-min.js"></script>
	<script>
		YUI().use('node-base', 'node-event-delegate', function(Y) {

			var menuButton = Y.one('.nav-menu-button'), nav = Y.one('#nav');

			// Setting the active class name expands the menu vertically on small screens.
			menuButton.on('click', function(e) {
				nav.toggleClass('active');
			});

			// Your application code goes here...

		});
		$('div.email-item').on(
				'click',
				function() {
					$('div.email-item').removeClass('email-item-selected');
					$(this).attr({
						'class' : 'email-item email-item-selected pure-g'
					});
					$('#main').removeAttr('hidden');
					$('h1.email-content-title').text(
							$(this).find('h4.email-subject').text());
					$('p.email-content-subtitle > a').text(
							$(this).find('h5.email-name').text());
					$('p.email-content-subtitle > span').text(
							$(this).find('span.email-time').text());
					$('div.email-content-body').html(
							$(this).find('div.email-real').html());
				}).mouseover(function() {
			$(this).addClass('email-item-hover');
		}).mouseout(function() {
			$(this).removeClass('email-item-hover');
		});
	</script>



</body>
</html>