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
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous"> -->
<link rel="stylesheet"
	href="https://unpkg.com/purecss@0.6.2/build/pure-min.css"
	integrity="sha384-" crossorigin="anonymous">
	
<link rel="stylesheet" href="css/bootstrapchange.css">
<link rel="stylesheet" href="css/layouts/email.css">
<link rel="stylesheet" href="css/sweetalert.css">

<title>GoGoDiN E-mail</title>
</head>
<body>
	<div id="layout" class="content pure-g">
		<div id="nav" class="pure-u">
			<a href="#" class="nav-menu-button">Menu</a>
			<div class="nav-inner">
				<a class="navbar-brand"
					href="<%=request.getContextPath()%>/index.jsp"
					style="height: 50px"> <img class="d-inline-block align-top"
					src="<%=request.getContextPath()%>/images/Logo.png"
					style="width: 150px;">
				</a>
				<button class="primary-button pure-button" data-toggle='modal' data-target='#sendmail' id="send">寄信</button>
				<div class="pure-menu">
					<ul class="pure-menu-list">
						<li class="pure-menu-item"><a id="all" style="cursor:pointer" class="pure-menu-link">所有信件<span class="email-count"></span></a></li>
						<li class="pure-menu-item"><a href="#" class="pure-menu-link">已加星號</a></li>
						<li class="pure-menu-item"><a href="#" class="pure-menu-link">送件匣</a></li>
						<li class="pure-menu-heading">Labels</li>
						<li class="pure-menu-item"><a id="normal" style="cursor:pointer" class="pure-menu-link"><span
								class="email-label-personal"></span>一般</a></li>
						<li class="pure-menu-item"><a id="din" style="cursor:pointer" class="pure-menu-link"><span
								class="email-label-work"></span>訂位通知</a></li>
						<li class="pure-menu-item"><a id="system" style="cursor:pointer" class="pure-menu-link"><span
								class="email-label-travel"></span>系統通知</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 	email-item-selected 選擇的 -->
		<!-- 	email-item-unread 未讀的 -->
		<div id="list" class="pure-u-1">
			<c:forEach var="VO" items="${list}">
				<c:set var="string1" value="${VO.message}" />
				<c:set var="string2" value="${fn:substring(string1 , 0, 20)}" />
				<c:choose>
					<c:when test="${VO.mailType==2}">
					<div class="email-item email-item-din pure-g" id="${VO.mesId}" data-type="din" style="cursor: pointer;">
					</c:when>
					<c:when test="${VO.mailType==3}">
					<div class="email-item email-item-system pure-g" id="${VO.mesId}" data-type="system" style="cursor: pointer;">
					</c:when>
					<c:otherwise>
					<div class="email-item email-item-normal pure-g" id="${VO.mesId}" data-type="normal" style="cursor: pointer;">
					</c:otherwise>
				</c:choose>
					<c:choose>
						<c:when test="${VO.sendAccount=='系統通知'}">
							<div class="pure-u">
								<img width="64" height="64" alt="${VO.mesId}"
									class="email-avatar"
									src="<%=request.getContextPath()%>/images/admin.png">
							</div>
						</c:when>
						<c:otherwise>
							<div class="pure-u">
								<img width="64" height="64" alt="${VO.mesId}"
									class="email-avatar" src="<%=request.getContextPath()%>/init/getImage?id=${VO.sendAccount}&type=AccountImg">
							</div>
						</c:otherwise>
					</c:choose>
					<div class="pure-u-3-4">
						<h5 class="email-name">${VO.sendAccount}</h5>
						<span hidden class="email-time">${VO.sendtime}</span>
						<h4 class="email-subject">${VO.title}
						<c:if test="${!VO.isRead}">
							<span class="label label-default float-right">New</span>
						</c:if>
						</h4>
						<p class="email-desc">${string2}...</p>
						<div hidden class="email-real">
							${VO.message}
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
						<button class="secondary-button pure-button" data-toggle='modal' data-target='#sendmail' id="reply">回覆</button>
						<button class="secondary-button pure-button" data-toggle='modal' data-target='#sendmail' id="forward">轉發</button>
					</div>
				</div>

				<div class="email-content-body" style="width: 920px;">
				</div>
			</div>
		</div>
	</div>
<div class="modal fade" id="sendmail" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">New message</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="recipient-name" class="form-control-label">收件者:</label>
            <input type="text" class="form-control" style="width: 450px;"  id="recipient-name" disabled="disabled">
          </div>
          <div class="form-group">
							<label for="recipient-name" class="form-control-label">主旨:</label>
							<input type="text" style="width: 450px;" class="form-control" 
								id="message-title">
		</div>
          <div class="form-group">
            <label for="message-text" class="form-control-label">訊息:</label>
            <textarea class="form-control" style="width: 450px;" id="message-text"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">關閉</button>
        <button type="button" class="btn btn-primary" id="sendEmail">寄信</button>
      </div>
    </div>
  </div>
</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
	<script src="https://yui-s.yahooapis.com/3.18.1/build/yui/yui-min.js"></script>
	<script type="text/javascript" src="js/sweetalert.min.js"></script>
	<script>
		YUI().use('node-base', 'node-event-delegate', function(Y) {

			var menuButton = Y.one('.nav-menu-button'), nav = Y.one('#nav');

			// Setting the active class name expands the menu vertically on small screens.
			
			menuButton.on('click', function(e) {
				nav.toggleClass('active');
			});

			// Your application code goes here...

		});
		function getisReadCount(){
			$.get('MessageServlet',({'action':'getIsRead'}),function(data){
				if(data>0){
					$('span.email-count').text('('+data+')');
				}else{
					$('span.email-count').text('');
				}
			});
		}
		$(function(){
			getisReadCount();
			
		})
		$('div.email-item').on('mousedown',function(){
			$.post('MessageServlet',{
				'action':'updateisRead',
				'messageId':$(this).attr('id')
			})
			
		}).on('mouseup',function(){
			getisReadCount();
			$('div.email-item').removeClass('email-item-selected');
			$(this).find('span.label-default').prop('hidden',true);
			$(this).addClass('email-item-selected');
			$('#main').removeAttr('hidden');
			$('h1.email-content-title').text(
					$(this).find('h4.email-subject').text());
			$('p.email-content-subtitle > a').text(
					$(this).find('h5.email-name').text());
			$('p.email-content-subtitle > span').text(
					$(this).find('span.email-time').text());
			$('div.email-content-body').html(
					$(this).find('div.email-real').html().replace(/\n/g, "<br>"));
		})
		$('div.email-item').mouseover(function() {
			$(this).addClass('email-item-hover');
		}).mouseout(function() {
			$(this).removeClass('email-item-hover');
		});
		
		$('#sendmail').on('show.bs.modal',function(event){
			var target = $(event.relatedTarget);
			if(target.attr('id')=='reply'){
				var button = $(event.relatedTarget)
				var modal = $(this);
				var targetAcconut =  $('p.email-content-subtitle > a').text();
				modal.find('.modal-title').text('回信給 @' + targetAcconut);
				modal.find('#recipient-name').val(targetAcconut).prop('disabled',true);
				modal.find('#message-title').val('RE: '+ $('h1.email-content-title').text())
				modal.find('#message-text').val('');
			}else if(target.attr('id')=='send'){
				var button = $(event.relatedTarget)
				var modal = $(this);
				modal.find('.modal-title').text('新訊息');
				modal.find('#recipient-name').val('').removeAttr('disabled');
				modal.find('#message-title').val('');
				modal.find('#message-text').val('');
			}else if(target.attr('id')=='forward'){
				var button = $(event.relatedTarget)
				var modal = $(this);
				modal.find('.modal-title').text('轉發');
				modal.find('#recipient-name').val('').removeAttr('disabled');
				modal.find('#message-title').val('轉發: '+$('h1.email-content-title').text());
				modal.find('#message-text').val($('div.email-content-body').html().replace(/<br\s*[\/]?>/gi,"\n").trim());
			}
		});
				
		$('#sendEmail').click(function(){
			if($('#recipient-name').val()==""){
				swal("錯誤!","收件者未填寫","error");
				return
			}
			if($('#message-title').val()==""){
				swal("錯誤!","主旨未填寫","error");
				return
			}
			$.post('<%= request.getContextPath()%>/MessageServlet',{
				'ReciveAccount':$('#recipient-name').val(),
				'Title':$('#message-title').val(),
				'Message':$('#message-text').val(),
				'action':'newMailSend'
			},function(data){
				$('#sendmail').modal('hide')
				swal("信件已寄出!","","success");
			});
		});
		$('a.pure-menu-link').mouseenter(function(){
			
		})
		$('#all').on('click',function(){
			var type = $('div.email-item').slideDown('fast');
		})
		$('ul.pure-menu-list > li:gt(3) > a').on('click',function(){
			typeid =  $(this).attr('id');
			var type = $('div.email-item[data-type!='+typeid+']').slideUp('fast');
			var type = $('div.email-item[data-type='+typeid+']').slideDown('fast');
		})
	</script>



</body>
</html>