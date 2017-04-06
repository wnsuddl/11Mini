<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<html>
<head>
<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase?userId=${purchase.buyer.userId}").submit();
	}
	
		$(function(){
			
			/* $(".tranClick").bind("click", function(){
				self.location = "/purchase/getPurchase?tranNo="+$(this).attr("valTranNo");
			}); */
			
			
			$( ".tranClick" ).on("mouseover" , function() {
				
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
										+"��ǰ��ȣ : "+JSONData.purchase.purchaseProd.prodNo+"<br/>"
										+"�����ھ��̵�  : "+JSONData.purchase.buyer.userId+"<br/>"
										+"���Ź�� : "+JSONData.purchase.paymentOption+"<br/>"
										+"�������̸� : "+JSONData.purchase.receiverName+"<br/>"
										+"�����ڿ���ó : "+JSONData.purchase.receiverPhone+"<br/>"
										+"�������ּ� : "+JSONData.purchase.divyAddr+"<br/>"
										+"���ſ�û���� : "+JSONData.purchase.divyRequest+"<br/>"
										+"�������� : "+JSONData.purchase.divyDate+"<br/>"
										+"�ֹ��� : "+JSONData.purchase.orderDate+"<br/>"
										+"</h3>";
								
					$("h3").remove();
					$("#"+tranNo+"" ).html(displayValue).delay(500);
					}
				});
			});
			
			
			/* 
			$( ".tranClick1" ).on("mouseover" , function() {
				
				var userId = $(this).attr("valBuyer");
				$.ajax( 
					{
					url : "/user/getJsonUser/"+ userId,
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
										+"���̵� : "+JSONData.user.userId+"<br/>"
									 	+"�̸�  : "+JSONData.user.userName+"<br/>"
										+"�ּ� : "+JSONData.user.addr+"<br/>"
										+"�޴���ȭ��ȣ : "+JSONData.user.phone+"<br/>"
										+"�̸��� : "+JSONData.user.email+"<br/>"
										+"�������� : "+JSONData.user.regDate+"<br/>" 
										+"</h3>";
					//alert("displayValue : \n"+displayValue);			
					$("h3").remove();
					$("#"+userId+"" ).html(displayValue);
					}
				});
			});
			 */
			
		
		
			$(".tranClick").bind("click", function(){
				self.location = "/purchase/getPurchase?tranNo="+$(this).attr("valTranNo");
			});
			
			$(".tranClick1").bind("click", function(){
				self.location = "/user/getUser?userId="+ $(this).attr("valBuyer");
			});
			
			$(".tranClick2").bind("click", function(){
				
					self.location = "/purchase/updateTranCode?tranNo="+$(this).attr("valTranNo")
														 +"&tranCode="+$(this).attr("valTranCode");
				
			});
			
			$(".tranClick5:contains('���ǵ���')").css("color" , "red");
			
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
		});
	
	
		
		

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
			<td colspan="11" >��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ��ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��ȭ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��������</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var='i' value='0'/>
	<c:forEach var="purchase" items="${list}">
	<c:set var="i" value="${i+1}"/>
	<tr class="ct_list_pop">
		<td align="center"  class="tranClick" valTranNo="${purchase.tranNo}">
			${i}
		</td>
		<td></td>
		<td align="left"  class="tranClick1" valBuyer="${purchase.buyer.userId}">
			${purchase.buyer.userId}
		</td>
		<td></td>
		<td align="left">${purchase.receiverName}</td>
		<td></td>
		<td align="left">${purchase.receiverPhone}</td>
		<td></td>
		<td align="left">
			<c:choose>
				<c:when test="${purchase.tranCode.trim()=='1'}">���� ���ſϷ� �����Դϴ�.</c:when>
				<c:when test="${purchase.tranCode.trim()=='2'}">���� ����� �����Դϴ�.</c:when>
				<c:when test="${purchase.tranCode.trim()=='3'}">���� ��ۿϷ� �����Դϴ�.</c:when>
			</c:choose>
		</td>
		<td></td>
		<td align="left"  class="tranClick2" valTranNo="${purchase.tranNo}"  valTranCode="${purchase.tranCode}">
			<c:if test="${purchase.tranCode.trim()=='2'}">
				���ǵ���
			</c:if>
		</td>
	</tr>
	
	<tr>
		<td id= "${purchase.tranNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<%-- <tr>
		<td id= "${purchase.buyer.userId}" colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr> --%>
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