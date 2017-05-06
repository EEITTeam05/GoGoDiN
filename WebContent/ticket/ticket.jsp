<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.ticket.model.* ,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%	
	TicketService tktsvc = new TicketService();
	List<TicketVO> ticketlist = tktsvc.getAll();
	session.setAttribute("ticketlist", ticketlist);
%>
<script type="text/javascript">
function confirmDelete(n) {
	if (confirm("確定刪除此項商品 ? ") ) {
		document.forms[0].action="<c:url value='UpdateItem.do?cmd=DEL&bookID=" + n +"' />" ;
		document.forms[0].method="POST";
		document.forms[0].submit();
	} else {
	
	}
}
function modify(key, qty, index) {
	var x = "newQty" + index;
	var newQty = document.getElementById(x).value;
	if  (newQty < 0 ) {
		window.alert ('數量不能小於 0');
		return ; 
	}
	if  (newQty == 0 ) {
		window.alert ("請執行刪除功能來刪除此項商品");
		document.getElementById(x).value = qty;
		return ; 
	}
	if  (newQty == qty ) {
		window.alert ("新、舊數量相同，不必修改");
		return ; 
	}
	if (confirm("確定將此商品的數量由" + qty + " 改為 " + newQty + " ? ") ) {
		document.getElementById("newQty${x}").value=qty;
	} else {
		document.getElementById(x).value = qty;
	}
}
</script>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/sweetalert.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ticket</title>

</head>
<body>
	<jsp:include page="../navbar.jsp"></jsp:include>
	<c:choose>
		<c:when test="${ShoppingCart.itemNumber > 0}">
			<!-- 購物車內有一項以上的商品 -->
			<c:set var="cartContent" value="購物車內有${ShoppingCart.itemNumber}項商品" />
			<%-- 			<c:set var="cart" value="購物車內有${ShoppingCart.itemName}商品" /> --%>
		</c:when>
		<c:otherwise>
			<!-- 購物車內沒有商品 -->
			<c:set var="cartContent" value="您尚未購買任何商品" />
		</c:otherwise>
	</c:choose>








	<%-- 	<c:if test="${! empty LoginOK }"> --%>
	<table id='t1' border='1' bordercolor='white' width='800'
		align='center' style="color: #770077;">
		<tr>
			<th width="200">商品圖片</th>
			<th width="150">商品名稱</th>
			<th width="300">詳細描述</th>
			<th width="150">金額</th>
			<th width="270">購物車</th>


		</tr>
		<div width="350" align="right" style="margin-right: 100px">${cartContent}</div>
		


		<div width="350" align="right" style="margin-right: 100px;border:3px solid red; float:right;" >
		
			<c:forEach   varStatus="vs" var="anEntry" items="${ShoppingCart.content}">
		
          	   ${anEntry.value.productName}    ${anEntry.value.qty}張     
          
               <Input id="newQty${vs.index}" style="width:28px;text-align:right" name="newQty" type="text" value="<fmt:formatNumber value="${anEntry.value.qty}" />" name="qty" onkeypress="return isNumberKey(event)"  />
    
               <Input type="button" name="update" value="修改" onClick="modify(${anEntry.value.tktId}, ${anEntry.value.qty}, ${vs.index})">
           
               <Input type="button" name="delete" value="刪除" onClick="confirmDelete(${anEntry.value.tktId})">
                 <br>       
            </c:forEach>            
              <hr>
              
          	<p style="font-weight:bold; color:blue; font-size:24px;" >總金額:$${ShoppingCart.subtotal}</p>
	
          
        <div width="350" align="right" style="margin-right: 100px">
         <input type="button" value="結帳" size="10px"  onclick="location.href='buyticket.jsp'">
        </div>
		</div>
		
	

		
		<tr>

			<c:forEach var="ticketlist" items="${ticketlist}">
				<tr height='180' border="5">
					<td><img height='180px' width='200px'
						src='${pageContext.servletContext.contextPath}/init/getImage?id=${ticketlist.tktId}&type=ticketlist'></td>

					<td width="200">${ticketlist.productName}</td>

					<td width="200">${ticketlist.detailed}</td>

					<td width="200">${ticketlist.tktMoney}</td>
					<td>
						<form action="CartService" method="post">
							購買數量: <select name="qty">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
							</select> <input type="hidden" name="ProductName"
								value="${ticketlist.productName}">
							<p />
							<input type="hidden" name="Detailed"
								value="${ticketlist.detailed}">
							<p />
							<input type="hidden" name="TktMoney"
								value="${ticketlist.tktMoney}">
							<p />
							<input type="hidden" name="TktId" value="${ticketlist.tktId}">
							<p />
							<input type="submit" value="加入購物車">
							<p />

						</form>
					</td>
				</tr>
			</c:forEach>
		</tr>

	</table>
	<%-- 	</c:if> --%>
</body>
</html>