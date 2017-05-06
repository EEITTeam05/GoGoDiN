<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>結帳</title>
</head>
<body>
	<jsp:include page="../navbar.jsp"></jsp:include>
	
	
	
	
<TABLE border='2' width="1200"  align='center'>
<TR><TD colspan='4'>
<!--          購物車的標題          --> 
   <TABLE width="800" style="margin-right: 100px">
     <TR height='40'><TD width="270">&nbsp;</TD><TD width="280" align='center'><FONT  size='+2'>${LoginOK.memAccount}</FONT></TD><TD width="270" align='right'></TD></TR>
     <TR height='18'><TD width="270">&nbsp;</TD><TD width="280" align='center'><FONT  size='+2'>購 物 清 單</FONT></TD><TD width="270" align='right'></TD></TR>
   </TABLE>
</TD></TR>

<TR>
   <TD><font size='-1' face='標楷體, Arial'> 
   <TABLE border='1'>
     <TR><TH width="280">商品名稱</TH><TH width="560">詳細內容</TH><TH width="60">數量</TH><TH width="60">單價</TH><TH width="110">小計</TH><TH width="250">修改</TH></TR>
     <c:forEach  var="anEntry" items="${ShoppingCart.content}">
        <TR height='16'>
          <TD >${anEntry.value.productName}</TD>
          <TD>${anEntry.value.detailed}</TD>
          <TD >${anEntry.value.qty}</TD>
          <TD >${anEntry.value.tktMoney}</TD>
          <TD  style="text-align:right;">${anEntry.value.tktMoney * anEntry.value.qty} 元</TD>
        </TR>
     </c:forEach>
        <TR height='16'>
          <TD colspan='5' align='right'>合計金額：</TD>
          <TD align='right'><fmt:formatNumber value='${ShoppingCart.subtotal}' pattern="#,###,###" />元</TD>
          <TD align='right'>&nbsp;</TD>          
        </TR>
        <TR>
          <TD colspan='5' align='right'>營業稅：</TD>
          <c:set var="VAT" value="${ShoppingCart.subtotal*0.05 + 0.0001}"/>
          <TD align='right'><fmt:formatNumber value="${VAT}" pattern="#,###,###" />元</TD>
          <TD align='right'>&nbsp;</TD>          
        </TR>
        <TR>
          <TD colspan='5' align='right'>總計金額：</TD>
          <TD align='right'><fmt:formatNumber value="${ShoppingCart.subtotal - VAT }" pattern="#,###,###" />元</TD>
          <TD align='right'>&nbsp;</TD>          
        </TR>
   </TABLE>
   </font>
   </TD>
</TR>
<TR height='80'>
   <TD > 
     <TABLE border='1'>
        <TR >
          <TD width="260" align='center'>
              <A href="<c:url value='../_03_listBooks/DisplayPageProducts?pageNo=1' />">繼續購物</A>
          </TD>
          <TD width="260" align='center'>
              <A href="<c:url value='checkout.do' />" onClick="return Checkout(${subtotal});">再次確認</A>
          </TD>
         <TD width="260" align='center'>
              <A href="<c:url value='abort.do' />" onClick="return Abort();">放棄購物</A>
          </TD>
        </TR>
     </TABLE>
   </TD>
</TR>
</TABLE>










</body>
</html>