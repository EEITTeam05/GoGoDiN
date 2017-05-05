<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="../js/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="../js/moment.min.js"></script>
	<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.3.1/fullcalendar.min.js"></script>
	<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.3.1/locale-all.js"></script>
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.3.1/fullcalendar.min.css" />
	<link rel="stylesheet" media="print" href="//cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.3.1/fullcalendar.print.css" />
	<style>
		/*th外框*/
 		td.fc-head-container { 
  			border-top-color:#DCB5FF; 
  			border-left-color:#DCB5FF; 
  			border-right-color:#DCB5FF;
  			border-top-width:2px;
  			border-left-width:2px;
  			border-right-width:2px;
 		}
 		/*th內框*/
 		th.fc-day-header { 
			background-color:#E0E0E0;
			color:#C6A300;
 		}
 		/*td外框*/
 		td.fc-widget-content { 
  			border-color:#DCB5FF;
  			border-left-width:2px;
  			border-right-width:2px;
  			border-bottom-width:2px;
 		}
 		/*td內框*/
 		td.fc-day { 
 			border-color:#FFAD86;
 		}
 		#outer {
 			overflow:auto;
 		}
 		#lan {
 			padding:10px;
 		}
 		h1 {
 			display:inline;
 			padding-left:250px;
 		}
	</style>
<title>訂單日曆</title>
</head>
<body>
	<a href="<%=request.getContextPath()%>/index.jsp">回首頁</a>
	<hr>
	<c:if test="${! empty errorMsgs }" >
		<font size="-1" color="red">${errorMsgs.error }</font>
	</c:if>
	<c:if test="${! empty ShopLoginOK }" >
		<div id='outer'>
			<div id='lan'>
				Language:
				<select id='locale-selector'></select>
			</div>
			<div id='calendar' style="width:60%;float:left;" ></div>
				<h1>訂單一覽</h1>
			<div id='myDiv' style="width:35%;float:right;"></div>
		</div>
	</c:if>
</body>
 	<script type="text/javascript">
		var myDiv = $('#myDiv');
	 	$(document).ready(function() {
	 		
	 		var initialLocaleCode = 'zh-tw';
	 	    $('#calendar').fullCalendar({
	 	    	locale: initialLocaleCode,
	 	    	
	 	    	header: {
	 	    		left: 'prevYear prev today next nextYear',
	 	    		center: 'title',
	 	    		right: 'month'
// 	 	    		right: 'month agendaWeek agendaDay'
	 	    	},
	 	    	
	 	    	dayClick: function(date) {
        			myDiv.empty();
    				
        			$.get("ShopServlet",{"action":"OrderCalendar","date":date.format()},
        			function(datas) {
        				var dataj = JSON.parse(datas);
        				
        				var docFrag = $(document.createDocumentFragment());
        				
        				var head1 = $('<th></th>').text("會員編號");
        				var head2 = $('<th></th>').text("餐廳編號");
        				var head3 = $('<th></th>').text("預約時間");
        				var head4 = $('<th></th>').text("人數");
        				var head5 = $('<th></th>').text("下訂時間");
        				var hrow = $('<tr></tr>')
        				.append([head1, head2, head3, head4, head5])
        				.css({
        					'margin':'5px'
        				});
        				var table = $('<table></table>').append(hrow);
        				
        				$.each(dataj.array, function(key,value){    				
        				
	        			var cell1 = $('<td></td>').text(value.order1);
	        			var cell2 = $('<td></td>').text(value.order2);
	        			var cell3 = $('<td></td>').text(value.order3);
	        			var cell4 = $('<td></td>').text(value.order4);
	        			var cell5 = $('<td></td>').text(value.order5);
	        			var crow = $('<tr></tr>')
	        			.append([cell1, cell2, cell3, cell4, cell5])
	        			.css({
	        				'text-align':'center',
	        				'vertical-align':'middle'
	        			});

        				table
        				.append(crow)
        				.css({
        					'border-style':'solid',
        					'border-width':'1px',
        					'border-color':'#CCCCFF'
        				});
	        			docFrag.append(table);
	        			myDiv.append(docFrag);
	        			
        				})
        			})
    			}
	 	    });
	 	    
	 		// build the locale selector's options
			$.each($.fullCalendar.locales, function(localeCode) {
				$('#locale-selector').append(
					$('<option/>')
						.attr('value', localeCode)
						.prop('selected', localeCode == initialLocaleCode)
						.text(localeCode)
				);
			});
			// when the selected option changes, dynamically change the calendar option
			$('#locale-selector').on('change', function() {
				if (this.value) {
					$('#calendar').fullCalendar('option', 'locale', this.value);
				}
			});
			
			var t;
			var tb;
			var n;
			var p;
			
			$('td.fc-day').each(function() {
// 				console.log($(this).attr('data-date'))
				t = new Date($(this).attr('data-date')).getTime()
				cnt(t)
			})
			$('button.fc-today-button').click(function(){
				$('td.fc-day').each(function() {
// 					console.log($(this).attr('data-date'))
					tb = new Date($(this).attr('data-date')).getTime()
					cnt(tb)
				})
			})
			$('button.fc-next-button').click(function(){
				$('td.fc-day').each(function() {
// 					console.log($(this).attr('data-date'))
					n = new Date($(this).attr('data-date')).getTime()
					cnt(n)
				})
			})
			$('button.fc-prev-button').click(function(){
				$('td.fc-day').each(function() {
// 					console.log($(this).attr('data-date'))
					p = new Date($(this).attr('data-date')).getTime()
					cnt(p)
				})
			})
			
			function cnt(x) {
			$.get("ShopServlet",{"action":"OrderCount"},
			    	function(datas) {
		 			var datac = JSON.parse(datas)
			    		$.each(datac.count, function(key,value) {
			    			if (new Date(value.start).getTime() == x) {
// 			    				$('.fc-day[data-date="' + value.start + '"]').css('background','red');
								$('#calendar').fullCalendar('renderEvents',[{title:value.title + '筆訂單',start:value.start}])
			    			}
			    		})
			    	});
			}
	 	});
 	</script>
</html>