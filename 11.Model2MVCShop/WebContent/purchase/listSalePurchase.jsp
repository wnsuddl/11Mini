<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<html>
<head>
<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method" , "POST").attr("action" , "/purchase/listSale").submit();
	}
	
	$(function(){
		
		
		$( ".tranClick3" ).on("mouseover" , function() {
			
			var tranNo = $(this).attr("valTranNo");
			$.ajax( 
				{
				url : "/purchase/getJsonPurchase/"+ tranNo,
				method : "GET" ,
				dataType : "json" ,
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData , status) {
							
				//alert(status);
				//Debug...
				//alert("JSONData : \n"+JSONData);
				//alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(JSONData) );
							
				var displayValue = "<h3>"
									+"물품번호 : "+JSONData.purchase.purchaseProd.prodNo+"<br/>"
									+"구매자아이디  : "+JSONData.purchase.buyer.userId+"<br/>"
									+"구매방법 : "+JSONData.purchase.paymentOption+"<br/>"
									+"구매자이름 : "+JSONData.purchase.receiverName+"<br/>"
									+"구매자연락처 : "+JSONData.purchase.receiverPhone+"<br/>"
									+"구매자주소 : "+JSONData.purchase.divyAddr+"<br/>"
									+"구매요청사항 : "+JSONData.purchase.divyRequest+"<br/>"
									+"배송희망일 : "+JSONData.purchase.divyDate+"<br/>"
									+"주문일 : "+JSONData.purchase.orderDate+"<br/>"
									+"</h3>";
							
				$("h3").remove();
				$("#"+tranNo+"" ).html(displayValue).delay(500);
				}
			});
		});
		
		$(".tranClick3").bind("click", function(){
			self.location = "/purchase/getPurchase?tranNo="+$(this).attr("valTranNo");
		});
		
		$(".tranClick4").bind("click", function(){
			self.location = "/user/getUser?userId="+ $(this).attr("valBuyer");
		});
		
		$(".tranClick5").bind("click", function(){
			
				self.location = "/purchase/updateTranCode?tranNo="+$(this).attr("valTranNo")
													 +"&tranCode="+$(this).attr("valTranCode");
			
		});
		
		$(".tranClick5:contains('물건도착')").css("color" , "red");
		
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
	})
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/purchase/listSale" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
			<td colspan="11" >전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">전화번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">정보수정</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>

	
	<c:set var='i' value='0'/>
	<c:forEach var="purchase" items="${list}">
	<c:set var="i" value="${i+1}"/>
	<tr class="ct_list_pop">
		<td align="center" class="tranClick3" valTranNo="${purchase.tranNo}">
			${i}
		</td>
		<td></td>
		<td align="left"  class="tranClick4" valBuyer="${purchase.buyer.userId}">
			${purchase.buyer.userId}
		</td>
		<td></td>
		<td align="left">${purchase.receiverName}</td>
		<td></td>
		<td align="left">${purchase.receiverPhone}</td>
		<td></td>
		<td align="left">
			<c:choose>
				<c:when test="${purchase.tranCode.trim()=='1'}">현재 구매완료 상태입니다.</c:when>
				<c:when test="${purchase.tranCode.trim()=='2'}">현재 배송중 상태입니다.</c:when>
				<c:when test="${purchase.tranCode.trim()=='3'}">현재 배송완료 상태입니다.</c:when>
			</c:choose>		
		</td>
		<td></td>
		<td align="left" class="tranClick5" valTranNo="${purchase.tranNo}"  valTranCode="${purchase.tranCode}">
			<c:if test="${purchase.tranCode.trim()=='2'}">
				물건도착
			</c:if>
			</td>
		</tr>
		
	<tr>
		<td id="${purchase.tranNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>
	
		
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
		 <input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
			<jsp:include page="../common/pageNavigator.jsp"/>
		</td>
		
		</td>
	</tr>
</table>

</form>

</div>

</body>
</html>