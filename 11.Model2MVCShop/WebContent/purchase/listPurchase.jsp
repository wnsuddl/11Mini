<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<head>

	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<link href="/css/animate.min.css" rel="stylesheet">
	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
	<script type="text/javascript">
	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase?userId=${purchase.buyer.userId}").submit();
	}
	
		$(function(){
			
			
			$( ".glyphicon.glyphicon-search" ).on("mouseover" , function() {
				
				var tranNo = $(this).next().val();
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
								
					var displayValue = "<h6>"
										+"��ǰ��ȣ : "+JSONData.purchase.purchaseProd.prodNo+"<br/>"
										+"�����ھ��̵�  : "+JSONData.purchase.buyer.userId+"<br/>"
										+"���Ź�� : "+JSONData.purchase.paymentOption+"<br/>"
										+"�������̸� : "+JSONData.purchase.receiverName+"<br/>"
										+"�����ڿ���ó : "+JSONData.purchase.receiverPhone+"<br/>"
										+"�������ּ� : "+JSONData.purchase.divyAddr+"<br/>"
										+"���ſ�û���� : "+JSONData.purchase.divyRequest+"<br/>"
										+"�������� : "+JSONData.purchase.divyDate+"<br/>"
										+"�ֹ��� : "+JSONData.purchase.orderDate+"<br/>"
										+"</h6>";
								
					$("h6").remove();
					$("#"+tranNo+"" ).html(displayValue);
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
			
			$( ".tranClick1" ).css("color" , "red");
			
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
		});
	
	
		
		

</script>
</head>

	<body>
	
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
				<h3>���α��� �����ȸ</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
		<div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				</form>
	    	</div>
	    	
		</div>
		
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >ȸ��ID</th>
            <th align="left">ȸ����</th>
            <th align="left">��ȭ��ȣ</th>
            <th align="left">�����Ȳ</th>
            <th align="left">��������</th>
            <th align="left">ȸ����������</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center"  class="tranClick" valTranNo="${purchase.tranNo}">
				${ i }
			  </td>
			  <td align="left"  class="tranClick1" valBuyer="${purchase.buyer.userId}">
				${purchase.buyer.userId}
			  </td>
			  <td align="left">${purchase.receiverName}</td>
			  <td align="left">${purchase.receiverPhone}</td>
			  <td align="left">
				<c:choose>
					<c:when test="${purchase.tranCode.trim()=='1'}">���� ���ſϷ� �����Դϴ�.</c:when>
					<c:when test="${purchase.tranCode.trim()=='2'}">���� ����� �����Դϴ�.</c:when>
					<c:when test="${purchase.tranCode.trim()=='3'}">���� ��ۿϷ� �����Դϴ�.</c:when>
				</c:choose>
			 </td>
			 <td align="left"  class="tranClick2" valTranNo="${purchase.tranNo}"  valTranCode="${purchase.tranCode}">
				<c:if test="${purchase.tranCode.trim()=='2'}">
					���ǵ���
				</c:if>
			 </td>
			 <td align="left">
				  <i class="glyphicon glyphicon-search" id= "${purchase.tranNo}"></i>
				  <input type="hidden" value="${purchase.tranNo}">
			 </td>
		   </tr>
         </c:forEach>
        
       </tbody>
      
     </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
	</body>

</html>
