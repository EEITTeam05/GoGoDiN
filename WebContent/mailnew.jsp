<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="A layout example that shows off a responsive email layout.">
<link rel="stylesheet" href="https://unpkg.com/purecss@0.6.2/build/pure-min.css" integrity="sha384-" crossorigin="anonymous">
<link rel="stylesheet" href="css/layouts/email.css">
<title>Insert title here</title>
</head>
<body>
<div id="layout" class="content pure-g">
    <div id="nav" class="pure-u">
        <a href="#" class="nav-menu-button">Menu</a>
        <div class="nav-inner">
            <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp" style="height: 100px">
				<img class="d-inline-block align-top" src="<%=request.getContextPath()%>/images/Logo.png" style="width: 150px;">
			</a>
            <button class="primary-button pure-button">寄信</button>
            <div class="pure-menu">
                <ul class="pure-menu-list">
                    <li class="pure-menu-item"><a href="#" class="pure-menu-link">收件匣 <span class="email-count">(2)</span></a></li>
                    <li class="pure-menu-item"><a href="#" class="pure-menu-link">訂位通知 <span class="email-count">(2)</span></a></li>
                    <li class="pure-menu-item"><a href="#" class="pure-menu-link">已加星號</a></li>
                    <li class="pure-menu-item"><a href="#" class="pure-menu-link">系統通知 </a></li>
                    <li class="pure-menu-item"><a href="#" class="pure-menu-link">送件匣</a></li>
                    <li class="pure-menu-item"><a href="#" class="pure-menu-link">所有信件</a></li>
                    <li class="pure-menu-heading">Labels</li>
                    <li class="pure-menu-item"><a href="#" class="pure-menu-link"><span class="email-label-personal"></span>一般</a></li>
                    <li class="pure-menu-item"><a href="#" class="pure-menu-link"><span class="email-label-work"></span>訂位通知</a></li>
                    <li class="pure-menu-item"><a href="#" class="pure-menu-link"><span class="email-label-travel"></span>重要通知</a></li>
                </ul>
            </div>
        </div>
    </div>
<!-- 	email-item-selected 選擇的 -->
<!-- 	email-item-unread 未讀的 -->
    <div id="list" class="pure-u-1">
    <c:forEach var= "VO" items="${list}">
        <div class="email-item pure-g">
            <div class="pure-u">
                <img width="64" height="64" alt="${VO.mesId}" class="email-avatar" src="<%=request.getContextPath()%>/init/getImage?id=${VO.sendAccount}&type=AccountImg">
            </div>
            <div class="pure-u-3-4">
                <h5 class="email-name">${VO.sendAccount}</h5>
                <h4 class="email-subject">Hello from Toronto</h4>
                <p class="email-desc">
                    ${VO.message}
                </p>
            </div>
        </div>
	</c:forEach>
        <div class="email-item  pure-g">
            <div class="pure-u">
                <img width="64" height="64" alt="Eric Ferraiuolo&#x27;s avatar" class="email-avatar" src="">
            </div>

            <div class="pure-u-3-4">
                <h5 class="email-name">Eric Ferraiuolo</h5>
                <h4 class="email-subject">Re: Pull Requests</h4>
                <p class="email-desc">
                    Hey, I had some feedback for pull request #51. We should center the menu so it looks better on mobile.
                </p>
            </div>
        </div>

<!--         <div class="email-item email-item-unread pure-g"> -->
<!--             <div class="pure-u"> -->
<!--                 <img width="64" height="64" alt="YUI&#x27;s avatar" class="email-avatar" src="img/common/yui-avatar.png"> -->
<!--             </div> -->

<!--             <div class="pure-u-3-4"> -->
<!--                 <h5 class="email-name">YUI Library</h5> -->
<!--                 <h4 class="email-subject">You have 5 bugs assigned to you</h4> -->
<!--                 <p class="email-desc"> -->
<!--                     Duis aute irure dolor in reprehenderit in voluptate velit essecillum dolore eu fugiat nulla. -->
<!--                 </p> -->
<!--             </div> -->
<!--         </div> -->

<!--         <div class="email-item pure-g"> -->
<!--             <div class="pure-u"> -->
<!--                 <img width="64" height="64" alt="Reid Burke&#x27;s avatar" class="email-avatar" src="img/common/reid-avatar.png"> -->
<!--             </div> -->

<!--             <div class="pure-u-3-4"> -->
<!--                 <h5 class="email-name">Reid Burke</h5> -->
<!--                 <h4 class="email-subject">Re: Design Language</h4> -->
<!--                 <p class="email-desc"> -->
<!--                     Excepteur sint occaecat cupidatat non proident, sunt in culpa. -->
<!--                 </p> -->
<!--             </div> -->
<!--         </div> -->

<!--         <div class="email-item pure-g"> -->
<!--             <div class="pure-u"> -->
<!--                 <img width="64" height="64" alt="Andrew Wooldridge&#x27;s avatar" class="email-avatar" src="img/common/andrew-avatar.png"> -->
<!--             </div> -->

<!--             <div class="pure-u-3-4"> -->
<!--                 <h5 class="email-name">Andrew Wooldridge</h5> -->
<!--                 <h4 class="email-subject">YUI Blog Updates?</h4> -->
<!--                 <p class="email-desc"> -->
<!--                     Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip. -->
<!--                 </p> -->
<!--             </div> -->
<!--         </div> -->

<!--         <div class="email-item pure-g"> -->
<!--             <div class="pure-u"> -->
<!--                 <img width="64" height="64" alt="Yahoo! Finance&#x27;s Avatar" class="email-avatar" src="img/common/yfinance-avatar.png"> -->
<!--             </div> -->

<!--             <div class="pure-u-3-4"> -->
<!--                 <h5 class="email-name">Yahoo! Finance</h5> -->
<!--                 <h4 class="email-subject">How to protect your finances from winter storms</h4> -->
<!--                 <p class="email-desc"> -->
<!--                     Mauris tempor mi vitae sem aliquet pharetra. Fusce in dui purus, nec malesuada mauris. -->
<!--                 </p> -->
<!--             </div> -->
<!--         </div> -->

<!--         <div class="email-item pure-g"> -->
<!--             <div class="pure-u"> -->
<!--                 <img width="64" height="64" alt="Yahoo! News&#x27; avatar" class="email-avatar" src="img/common/ynews-avatar.png"> -->
<!--             </div> -->

<!--             <div class="pure-u-3-4"> -->
<!--                 <h5 class="email-name">Yahoo! News</h5> -->
<!--                 <h4 class="email-subject">Summary for April 3rd, 2012</h4> -->
<!--                 <p class="email-desc"> -->
<!--                     We found 10 news articles that you may like. -->
<!--                 </p> -->
<!--             </div> -->
<!--         </div> -->
    </div>

    <div id="main" class="pure-u-1">
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

            <div class="email-content-body">
                <p>
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                </p>
                <p>
                    Duis aute irure dolor in reprehenderit in voluptate velit essecillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                </p>
                <p>
                    Aliquam ac feugiat dolor. Proin mattis massa sit amet enim iaculis tincidunt. Mauris tempor mi vitae sem aliquet pharetra. Fusce in dui purus, nec malesuada mauris. Curabitur ornare arcu quis mi blandit laoreet. Vivamus imperdiet fermentum mauris, ac posuere urna tempor at. Duis pellentesque justo ac sapien aliquet egestas. Morbi enim mi, porta eget ullamcorper at, pharetra id lorem.
                </p>
                <p>
                    Donec sagittis dolor ut quam pharetra pretium varius in nibh. Suspendisse potenti. Donec imperdiet, velit vel adipiscing bibendum, leo eros tristique augue, eu rutrum lacus sapien vel quam. Nam orci arcu, luctus quis vestibulum ut, ullamcorper ut enim. Morbi semper erat quis orci aliquet condimentum. Nam interdum mauris sed massa dignissim rhoncus.
                </p>
                <p>
                    Regards,<br>
                    Tilo
                </p>
            </div>
        </div>
    </div>
</div>

<script src="https://yui-s.yahooapis.com/3.18.1/build/yui/yui-min.js"></script>
<script>
    YUI().use('node-base', 'node-event-delegate', function (Y) {

        var menuButton = Y.one('.nav-menu-button'),
            nav        = Y.one('#nav');

        // Setting the active class name expands the menu vertically on small screens.
        menuButton.on('click', function (e) {
            nav.toggleClass('active');
        });

        // Your application code goes here...

    });
</script>



</body>
</html>