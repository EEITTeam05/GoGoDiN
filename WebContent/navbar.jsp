<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.20/css/uikit.min.css" />
<script src="//cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.20/js/uikit.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.20/js/uikit-icons.min.js"></script>
<script src='https://www.google.com/recaptcha/api.js' async defer></script>
<script src="js/line.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="application/javascript">
	function correctCaptcha() {
		$('#btnLogin').removeAttr('disabled');
	}
</script>
</head>
<body>
<nav class="navbar navbar-toggleable-md navbar-light bg-faded" style="background-color: #FFFFFF;">
  <div class="collapse navbar-collapse">
      <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp" style="height: 100px">
		<img alt="" class="d-inline-block align-top" src="images/Logo.png">
    </a>
    <div>
      <ul class="navbar-nav mr-auto">
<!--         <li><a href="#">首頁</a></li> -->
      </ul>
      <ul class="nav navbar-nav navbar-right">
      <c:if test="${!empty LoginOK||!empty ShopLoginOK||!empty AdminLoginOK}">
              <li class="nav-item active" style="margin-top: 25px;width: 100px">
           	 <a class="nav-link uk-button-text" style="width:73px" 
             	 href="<%=request.getContextPath()%>/MessageServlet?action=getMymail">查看通知</a></li>
      </c:if>
      <c:choose>
      	<c:when test="${!empty LoginOK}">
      	<div class="collapse navbar-collapse" style="margin-top: 25px;">
   			 <button type="button" class="btn btn-secondary my-2 my-sm-0 btn-lg">
   			 <c:choose>
   			 		<c:when test="${empty FBLoginOK }">	
   				<img class="uk-border-rounded" style="height: 30px; width: 30px;margin-top:0px;margin-right: 5px;" src="${pageContext.servletContext.contextPath}/init/getImage?id=${LoginOK.memId}&type=Member">
   					</c:when>
   				<c:otherwise>
   					<jsp:useBean id="LoginOK" scope="session" class="com.member.Model.MemberListVO"></jsp:useBean>
				<img class="uk-border-rounded" style="height: 30px; width: 30px;margin-top:0px;margin-right: 5px;" src= <%=new String(LoginOK.getMemberImage())%> />	
   				</c:otherwise>
 			 </c:choose>
     	 			<span style="font-size: 20px;position: relative;top: 3px;">${LoginOK.memName}</span>
		      		<div uk-dropdown>
				        	<ul class="uk-nav uk-dropdown-nav">
					            <li class="uk-active">
						            <a class="uk-button uk-button-text" href='<%=request.getContextPath()%>/Member/MemberList.jsp'>
						            	個人資料
						            </a>
					            </li>
					            <li>
					            	<a class="uk-button uk-button-text" href='<%=request.getContextPath()%>/Member/MemOrderServlet?action=getOrderList'>
					            		查詢訂單
					            	</a>
					            </li>
					            <li class="uk-nav-header">Header</li>
					            <li><a href="#">Item</a></li>
					            <li><a href="#">Item</a></li>
					            <li class="uk-nav-divider"></li>
					            <li><a href="logout.jsp">登出</a></li>
				        	</ul>
				    	</div>
      			</button>
      		</div>
      	</c:when>
      	<c:when test="${!empty ShopLoginOK}">
      	<div class="collapse navbar-collapse" style="margin-top: 25px;">
   			 <button type="button" class="btn btn-success my-2 my-sm-0 btn-lg">	
     	 			<span style="font-size: 20px;position: relative;top: 3px;">${ShopLoginOK.shopName}</span>
		      		<div uk-dropdown>
				        	<ul class="uk-nav uk-dropdown-nav">
				        	<li class="uk-nav-header">業主資料</li>
					            <li>
						            <a class="uk-button uk-button-text" href='<%=request.getContextPath()%>/Shop/Shop.jsp'>
						            	個人資料
						            </a>
					            </li>
					            <li>
					            	<a class="uk-button uk-button-text" href='<%=request.getContextPath()%>/Shop/ShopServlet?action=listOrder'>
					            		訂單列表
					            	</a>
					            </li>
        					      <li class="uk-nav-divider"></li>
					            <li class="uk-nav-header">餐廳資料</li>
					            <li>
					            	<a href="<%=request.getContextPath()%>/Shop/ShopServlet?action=listRest">
					            		餐廳列表
					            	</a>
					            </li>
					            <li><a href="<%=request.getContextPath()%>/Shop/Publish.jsp">刊登餐廳</a></li>
					            <li class="uk-nav-divider"></li>
					            <li><a href="logout.jsp">登出</a></li>
				        	</ul>
				    	</div>
      			</button>
      		</div>
      	</c:when>
      	<c:when test="${!empty AdminLoginOK}">
      	<div class="collapse navbar-collapse" style="margin-top: 25px;">
   			 <button type="button" class="btn btn-danger my-2 my-sm-0 btn-lg">	
     	 			<span style="font-size: 20px;position: relative;top: 3px;">${AdminLoginOK.adminName}</span>
		      		<div uk-dropdown>
				        	<ul class="uk-nav uk-dropdown-nav">
				        		<li class="uk-nav-header">會員</li>
					            <li>
						            <a class="uk-button uk-button-text" href='<%=request.getContextPath()%>/Admin/AdminServlet?action=listAll'>
						            	會員資料
						            </a>
					            </li>
					            <li class="uk-nav-header">訂單</li>
					            <li>
					            	<a class="uk-button uk-button-text" href='<%=request.getContextPath()%>/Admin/AdminServlet?action=listAllOrder'>
					            		訂單資料
					            	</a>
					            </li>
					            <li class="uk-nav-header">餐廳</li>
					            <li>
					            	<a href="<%=request.getContextPath()%>/Admin/AdminServlet?action=listAllRest">
					            		餐廳列表
					            	</a>
					            </li>
					             <li class="uk-nav-divider"></li>
					            <li><a href="<%=request.getContextPath()%>/logout.jsp">登出</a></li>
				        	</ul>
				    	</div>
      			</button>
      		</div>
      	</c:when>
      	<c:when test="${empty ShopLoginOK && empty LoginOK && empty AdminLoginOK }">
	        <li class="dropdown">
      			<a class="dropdown-toggle" data-toggle="dropdown" href="#" style="margin-top: 25px">登入 <span class="glyphicon glyphicon-log-in"></span></a>
	          <div class="dropdown-menu">
	            <form id="formLogin" class="form container-fluid">
	            <label>帳號:</label>
	              <div class="form-group input-group margin-bottom-sm">
		                <span class="input-group-addon"><i class="fa fa-envelope-o fa-fw" aria-hidden="true"></i></span>
		                <input type="text" class="form-control" id="usr" placeholder="Account">
		              </div>
		            <label>密碼:</label>
		              <div class="form-group input-group margin-bottom-sm">
		                <span class="input-group-addon"><i class="fa fa-key fa-fw" aria-hidden="true"></i></span>
		                <input type="password" class="form-control" id="pwd" placeholder="Password">
		              </div>
		                <div class="checkbox">
						    <label>
						      <input type="checkbox" name="rememberMe" <c:if test="${cookie['re'].value==true}">
			    					 checked='checked'
			     			</c:if> value="true"> 記住密碼
						    </label>
						  </div>
						  <div id="recaptcha" class="g-recaptcha" data-callback="correctCaptcha" data-sitekey="6LcYWx8UAAAAADEAuAr9_EAxDqWunfs9MoHlFIqU"></div>
		              <button type="button" id="btnLogin" class="btn btn-block btn-default">登入</button>
		              <br />
		              <label style="">其他平台登入</label>
		              <br />
		              <fb:login-button size="large" scope="public_profile,email,user_birthday,user_location,user_photos" 
		              	style="width: 100px;height: 28px;" onlogin="checkLoginState();">
            		  								<!--         	checkLoginState()在js/line.js -->
		              	  Facebook
            		  </fb:login-button>
<!-- 		              <button type="button" id="facebookLogin" class="btn btn-primary"><i class="fa fa-facebook-official" aria-hidden="true"> facebook</i></button> -->
		              <img src="images/btn_login_base.png" id="linelogin" onclick="Auth();" style="width: 104px;height: 28px;margin-left: 15px;margin-top: -18px">
																   <!--            Auth()在js/line.js -->
		            </form>
	            <div class="container-fluid">
		              	<br>
			              <a class="small" href="#">忘記密碼?</a>
			              <a class="small" style="  float: right;" href="<%=request.getContextPath()%>/Member/register.jsp">註冊</a>
		              <small style="  float: right;">第一次來?</small> 
	            </div> 
	          </div>
	        </li>
       	 </c:when>
       	 <c:otherwise>
       	 </c:otherwise>
        </c:choose>
      </ul>
    </div>
  </div>
</nav>
</body>
<script type="text/javascript">
	$(function(){
		$('ul.uk-nav > li > a').addClass('uk-button uk-button-text');
		$('ul.uk-nav > li').css({
			'width':'90px',
			'margin-left':'25px'
			})
		}
	)
	$('#btnLogin').click(function(){
			$.post('https://www.google.com/recaptcha/api/siteverify',{})
			$.post('login.do',{
				'userId':$('#usr').val(),
				'pswd':$('#pwd').val(),
				'word':'a',
				'rememberMe':$('input[type="checkbox"]').prop("checked")
			},function(){
				history.go(0);
		});
	});
	$('#linelogin').hover(function(){
			cursor:
			$(this).css({
				'cursor':'pointer'
			}).attr('src','images/btn_login_hover.png');
		},function(){
			$(this).attr('src','images/btn_login_base.png');
		}).mousedown(function(){
			$(this).attr('src','images/btn_login_press.png')
		});
	
</script>
</html>