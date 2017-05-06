<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.login.controller.LoginServlet"%>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script
	src="js/line.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-ui.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>

<style type="text/css">
/* .homepage-hero-module { */
/*     border-right: none; */
/*     border-left: none; */
/*     position: relative; */
/* } */
/* .no-video .video-container video, */
/* .touch .video-container video { */
/*     display: none; */
/* } */
/* .no-video .video-container .poster, */
/* .touch .video-container .poster { */
/*     display: block !important; */
/* } */
/* .video-container { */
/*     position: relative; */
/*     bottom: 0%; */
/*     left: 0%; */
/*     height: 100%; */
/*     width: 100%; */
/*     overflow: hidden; */
/*     background: #000; */
/* } */
/* .video-container .poster img { */
/*     width: 100%; */
/*     bottom: 0; */
/*     position: absolute; */
/* } */
/* .video-container .filter { */
/*     z-index: 100; */
/*     position: absolute; */
/*     background: rgba(0, 0, 0, 0.4); */
/*     width: 100%; */
/* } */
/* .video-container video { */
/*     position: absolute; */
/*     z-index: 0; */
/*     bottom: 0; */
/* } */
/* .video-container video.fillWidth { */
/*     width: 100%; */
/* } */
</style>
<meta property="og:url"
	content="http://localhost:8081/GoGoDiN/Shop/Publish.jsp" />
<meta property="og:type" content="website" />
<meta property="og:title" content="Your Website Title" />
<meta property="og:description" content="Your description" />
<meta property="og:image"
	content="http://www.your-domain.com/path/image.jpg" />
<script type="text/javascript">
	function reloadImage() {
		document.getElementById('btn').disabled = true;
		document.getElementById('identity').src = 'login.do?ts='
				+ new Date().getTime();
	}
	//=====================================================================================	

	

		$('#fb-share-button').click(function() {
			FB.ui({
				method : 'share',
				link : "http://localhost:8081/GoGoDiN/Shop/Publish.jsp",
				picture : 'The picture url',
				name : "The name who will be displayed on the post",
				description : "The description who will be displayed"
			}, function(response) {
				console.log(response);
			});
		});

	
</script>


<title>登入</title>
</head>
<body>
<jsp:include page="navbar.jsp"></jsp:include>
<div class="homepage-hero-module">
    <div class="video-container">
        <div class="filter">
	<a href='<%=request.getContextPath()%>/Shop/register.jsp'>Shop Register</a>
	<c:if test="${!empty ShopLoginOK}">
	<a href='<%=request.getContextPath()%>/Shop/Publish.jsp'>刊登</a>
	</c:if>
	<a href='<%=request.getContextPath()%>/Search.jsp'>Search</a>
	<c:choose>
		<c:when test="${!empty LoginOK}">
			<a href='<%=request.getContextPath()%>/Member/MemberList.jsp'>個人資料</a>
			<a href='<%=request.getContextPath()%>/Member/MemOrderServlet?action=getOrderList'>查詢訂單</a>
			<a href='<%=request.getContextPath()%>/ticket/ticket.jsp'>購買餐卷</a>
		</c:when>
		<c:when test="${!empty ShopLoginOK}">
			<a href='<%=request.getContextPath()%>/Shop/Shop.jsp'>查詢資料</a>
			<a href='<%=request.getContextPath()%>/Shop/ShopServlet?action=listRest' >餐廳列表</a>
			<a href='<%=request.getContextPath()%>/Shop/ShopServlet?action=listOrder' >訂單列表</a>
			<a href='<%=request.getContextPath()%>/Shop/OrderCalendar.jsp'>訂單日曆</a>
		</c:when>
		<c:when test="${!empty AdminLoginOK}">
			<form method="post" action="Admin/AdminServlet">
				<input type="submit" value="查詢所有會員">
				<input type="hidden" name="action" value="listAll" >
			</form>
			<form method="post" action="Admin/AdminServlet" >
				<input type="submit" value="查詢所有訂單" >
				<input type="hidden" name="action" value="listAllOrder" >
			</form>
			<form method="post" action="Admin/AdminServlet">
				<input type="submit" value="查詢所有餐廳" >
				<input type="hidden" name="action" value="listAllRest" >
			</form>
		</c:when>
		<c:otherwise>
			<a href='<%=request.getContextPath()%>/index.jsp'>查詢資料</a>
		</c:otherwise>
	</c:choose>
	<c:if test="${!empty AdminLoginOK or !empty ShopLoginOK or !empty LoginOK}">
			<a href='<%=request.getContextPath()%>/MessageServlet?action=getMymail'>
			查看通知<span class="badge"></span></a>
	</c:if>
	<hr>
	

	<img id="img" src=""></img>

        
        </div>
        <video autoplay loop class="fillWidth">
<!--             <source src="webVideo/MP4/Night-BBQ.mp4" type="video/mp4" />Your browser does not support the video tag. I suggest you upgrade your browser. -->
<!--             <source src="webVideo/WEBM/Night-BBQ.webm" type="video/webm" />Your browser does not support the video tag. I suggest you upgrade your browser. -->
        </video>
        <div class="poster hidden">
<!--             <img src="webVideo/Snapshots/Night-BBQ.jpg" alt=""> -->
        </div>
    </div>
</div>
	
	<script>
			$.get('MessageServlet',({'action':'getIsRead'}),function(data){
				if(data>0){
					$('span.badge').text(data);
				}
			});
// 			$( document ).ready(function() {

// 			    scaleVideoContainer();

// 			    initBannerVideoSize('.video-container .poster img');
// 			    initBannerVideoSize('.video-container .filter');
// 			    initBannerVideoSize('.video-container video');

// 			    $(window).on('resize', function() {
// 			        scaleVideoContainer();
// 			        scaleBannerVideoSize('.video-container .poster img');
// 			        scaleBannerVideoSize('.video-container .filter');
// 			        scaleBannerVideoSize('.video-container video');
// 			    });

// 			});

// 			function scaleVideoContainer() {

// 			    var height = $(window).height() + 5;
// 			    var unitHeight = parseInt(height) + 'px';
// 			    $('.homepage-hero-module').css('height',unitHeight);

// 			}

// 			function initBannerVideoSize(element){

// 			    $(element).each(function(){
// 			        $(this).data('height', $(this).height());
// 			        $(this).data('width', $(this).width());
// 			    });

// 			    scaleBannerVideoSize(element);

// 			}

// 			function scaleBannerVideoSize(element){

// 			    var windowWidth = $(window).width(),
// 			    windowHeight = $(window).height() + 5,
// 			    videoWidth,
// 			    videoHeight;

// 			    // console.log(windowHeight);

// 			    $(element).each(function(){
// 			        var videoAspectRatio = $(this).data('height')/$(this).data('width');

// 			        $(this).width(windowWidth);

// 			        if(windowWidth < 1000){
// 			            videoHeight = windowHeight;
// 			            videoWidth = videoHeight / videoAspectRatio;
// 			            $(this).css({'margin-top' : 0, 'margin-left' : -(videoWidth - windowWidth) / 2 + 'px'});

// 			            $(this).width(videoWidth).height(videoHeight);
// 			        }

// 			        $('.homepage-hero-module .video-container video').addClass('fadeIn animated');

// 			    });
// 			}		
</script>
</body>
</html>