<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style type="text/css">
 table { */
 		border-top-left-radius:20px; 
		border-top-right-radius:20px; 
 		border-bottom-left-radius:20px; 
		padding: 10px; 
 } 



</style>
<head>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/sweetalert.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MemberList</title>
</head>
<body>
	<a href="<%=request.getContextPath()%>/index.jsp">回首頁</a>
	<hr>

	<h1 id='per' align='center'>個人資料</h1>
	<%-- 	<c:if test="${! empty LoginOK }"> --%>
	<!-- 		<img height='40px' width='30px' -->
	<%-- 			src='${pageContext.servletContext.contextPath}/init/getImage?id=${LoginOK.memId}&type=Member'> --%>
	<%-- 	</c:if> --%>

	<c:if test="${! empty LoginOK }">
		<table id='t1' border='1' bordercolor='blue' width='1000' align='center' style="color:#770077;">
			<tr>
				<th>會員編號</th>
				<th>會員帳號</th>
				<th>會員姓名</th>
				<th>性別</th>
				<th>生日</th>
				<th>信箱</th>
				<th>Line帳號</th>
				<th>電話</th>
				<th>地址</th>
				<th>照片</th>
				<th>功能選單</th>
			</tr>
			<tr align='center' valign='middle'>
				<td>${LoginOK.memId}</td>
				<td>${LoginOK.memAccount}</td>
				<td>${LoginOK.memName}</td>
				<td>${LoginOK.sex}</td>
				<td>${LoginOK.birthday}</td>
				<td>${LoginOK.email}</td>
				<td>${LoginOK.mlineId}</td>
				<td>${LoginOK.memTel}</td>
				<td>${LoginOK.memAddr}</td>
				<td>
					<c:choose>
						<c:when test="${! empty FBLoginOK}">
						<jsp:useBean id="LoginOK" scope="session" class="com.member.Model.MemberListVO"></jsp:useBean>
							<img id='img1' height='200px' width='180px' src= <%=new String(LoginOK.getMemberImage())%> />
						</c:when>
						<c:otherwise>
							<img height='200px' width='180px'
					          src='${pageContext.servletContext.contextPath}/init/getImage?id=${LoginOK.memId}&type=Member'>
						</c:otherwise>
					</c:choose>
				</td>

				<td>
					<form method="post" action="MemberServlet" style="margin-top: 5px">
						<input type="submit" value="修改個資" > 
						<input type="hidden" name="memId" value="${LoginOK.memId }"> 
						<input type="hidden" name="action" value="getOneUpdate">
					</form>
					
					<form method="post" action="MemOrderServlet">
						<input type="submit" value="查詢訂單" style="margin-top: 50px; margin-bottom: 5px"> 
						<input type="hidden" name="memId" value="${LoginOK.memId }"> 
						<input type="hidden" name="action" value="getOneOrder">
					</form>
				</td>
			</tr>
		</table>
		
		
			<h1 id='fav' align='center'>專屬收藏</h1>
			
			<c:if test="${! empty favoritelist }">
			  <table id='t2' border='1' bordercolor='blue' width='1000' align='center' style="color:#770077;">

			    <tr>
			      <th>收藏時間</th>				  
				  <th>餐廳名稱</th>
				  <th>餐廳地址</th>				  
				  <th>餐廳照片</th>			
				  <th>功能選單</th>
			    </tr>			
			
			    <c:forEach items="${favoritelist }" var="favoriteVO">
				<tr align='center' valign='middle'>
				    <td>${favoriteVO.addTime}</td>					
					<td>${favoriteVO.restVO.restName}</td>
					<td>${favoriteVO.restVO.restaddr}</td>					
					<td><img height='180px' width='180px'
					          src='${pageContext.servletContext.contextPath}/init/getImage?id=${favoriteVO.restVO.restId}&type=Restaurant'></td>					
					
					<td>
					<a class="btn btn-primary" href="<%=request.getContextPath()%>/SearchPage.do?search=${favoriteVO.restVO.restName}" style="width: 72.58px;">
						<i class="fa fa-list-alt fa-lg"></i> 詳情
					</a>
					<br>
					<br>
					<a class="btn btn-danger" data-id="${favoriteVO.restVO.restId}" id="cancel2">
					   <i class="fa fa-trash-o fa-lg"></i> 刪除</a>
					</td>
					
				</tr>
			    </c:forEach>
		    </table>
			</c:if>
			
		<c:if test="${empty favoritelist }">
			<h1 id='Nfav' align='center'>無收藏資料</h1>
		</c:if>


	</c:if>



</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script type="text/javascript" src="../js/sweetalert.min.js"></script>

<script type="text/javascript">
$('td').on('click','#cancel2',function(){
	var btn = $(this).attr('data-id');
	swal({
		  title: "確定要取消收藏嗎?",
		  type: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#3085d6",
		  confirmButtonText: "是的!",
		  cancelButtonText: "考慮一下",
		  closeOnConfirm: false,		 
	},function(){
			$.post('DeleteFavorite.do',{
				'restId': btn,
				'action':'DeleteOneFavorite'
			});			
			swal({
				  title: "取消成功!",
				  type: "success",				  
				  confirmButtonColor: "#3085d6",
				  confirmButtonText: "OK!",				 
				  closeOnConfirm: false,		  		  
			},function(){
				history.go(0);
			});
	});	
});


</script>
</html>