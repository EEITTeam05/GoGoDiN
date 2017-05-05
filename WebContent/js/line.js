 function Auth() {
            var URL = 'https://access.line.me/dialog/oauth/weblogin?';
            URL += 'response_type=code';
            URL += '&client_id=1511345634';
            URL += '&redirect_uri=http://localhost:8080/GoGoDiN_0420/Search.jsp';
            URL += '&state=abcde';
            window.location.href = URL;
}
 function statusChangeCallback(response) {
		console.log('statusChangeCallback');
		console.log(response);
		if (response.status === 'connected') {
			testAPI();
		} else if (response.status === 'not_authorized') {
			document.getElementById('status').innerHTML = 'Please log '
					+ 'into this app.';
		} else {

			document.getElementById('status').innerHTML = 'Please log '
					+ 'into Facebook.';
		}
	}
	function checkLoginState() {
		FB.getLoginStatus(function(response) {
			statusChangeCallback(response);
		});
	}
	window.fbAsyncInit = function() {
		FB.init({
			appId : '130516937492678',
			cookie : true,
			xfbml : true,
			version : 'v2.9'
		});
		FB.AppEvents.logPageView();
	};

	(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id)) {
			return;
		}
		js = d.createElement(s);
		js.id = id;
		js.src = "//connect.facebook.net/zh_TW/sdk.js";
		fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));

	var count = 0;
	function testAPI() {
		FB.api('/me', {
			"fields" :  "email,last_name,first_name,id,gender,picture.type(large),name,birthday,location"
		}, function(response) {
			$('#status').text('登入者lastName ：' + response.last_name);
			console.log('Successful login for: ' + response.name);
			console.log(JSON.stringify(response));
			var datas = JSON.stringify(response);
			var info = JSON.parse(datas);
			console.log(info);
			ajaxPost(response.email, response.last_name, response.first_name,
					response.gender, response.picture.data.url,response.birthday);
			$('#img').prop("src", response.picture.data.url);
		
		});
		function ajaxPost(email, lastname, firstname, gender, picture, birthday, location) {
			$.post('fbregister.do', {
				'Account' : email,
				'password' : 'PASSWORD',
				'password2' : 'PASSWORD2',
				'name' : lastname + firstname,
				'MlineId' : email,
				'sex' : gender,
				'birthday' : birthday,
				'tel' : 'tel',
				'Image' : picture,
				'email' : email,
				'address': 'location',
				'fileName' : 'fbname',
			});
			history.go(0);
		}
		

		(function(d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id))
				return;
			js = d.createElement(s);
			js.id = id;
			js.src = "//connect.facebook.net/zh_TW/sdk.js#xfbml=1";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
	}