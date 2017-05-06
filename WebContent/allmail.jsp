<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="message.Model.*"%>
<%@ page import="com.member.Model.MemberListVO"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.21/css/uikit.min.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">

<title>Insert title here</title>
</head>
<body>
<table border='1' bordercolor='#CCCCFF' width='800'>
	<tr>
		<th>信件編號</th>
		<th>寄件者</th>
		<th>寄件內容</th>
		<th>回覆信件</th>
		<th>寄件時間</th>
	</tr>
	<c:forEach var="VO" items="${list}">
			<tr align="center" valign="middle">
				<td>${VO.mesId}</td>
				<td>${VO.sendAccount}</td>
				<td>${VO.message}</td>
				<td><button id='button' class='btn btn-info' data-whatever="@${VO.sendAccount}" data-toggle='modal' data-target='#sendmail'>回覆</button></td>
				<td>${VO.sendtime}</td>
			</tr>
	</c:forEach>
</table>
<a href="index.jsp"><p align="center">回首頁</a>
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
            <input type="text" class="form-control"  id="recipient-name" disabled="disabled">
          </div>
          <div class="form-group">
            <label for="message-text" class="form-control-label">訊息:</label>
            <textarea class="form-control" id="message-text"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">關閉</button>
        <button type="button" class="btn btn-primary" id="send">寄信</button>
      </div>
    </div>
  </div>
</div>


<div id="Div1" class="uk-position-relative uk-margin-medium">
</div>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.21/js/uikit.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.21/js/uikit-icons.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</body>

<script type="text/javascript">
$(function(){
	$('tr td:last-child').each(function(){
		now = new Date().getTime();
		difftime = (now - (new Date($(this).text()).getTime()))/1000; //取得差距秒數
		var hours = Math.floor(difftime / 3600);
		var minutes = Math.floor((difftime / 60) % 60);
		var seconds = Math.floor((difftime % 60) % 60);
			if(hours>0){
				$(this).text(hours + "小時 " + minutes + "分鐘前");
			}else if(minutes>0){
				$(this).text(minutes + "分鐘 " + seconds + "秒前");
			}else{
				$(this).text(seconds + " 秒前");
			}
	})
});

$('#sendmail').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var recipient = button.data('whatever') // Extract info from data-* attributes
	  var modal = $(this);
	  modal.find('.modal-title').text('寄信給   ' + recipient)
	  modal.find('.modal-body input').val(recipient.replace("@",''))
});

$('#send').click(function(){
	$.post('<%=request.getContextPath()%>/MessageServlet',{
		'MemAccount':$('#recipient-name').val(),
		'Message':$('#message-text').val(),
		'action':'ShopSendToMember'
		},function(data){
			$('#sendmail').modal('hide')
			 swal("信件已寄出!", "", "success");
		});
});
</script>
</html>