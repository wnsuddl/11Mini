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
		   	//document.detailForm.submit();
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu}").submit();
		
		}
				
		$(function() {
			$( "button.btn.btn-default" ).on("click" , function() {
				fncGetList(1);
			});
			 	
			 //id ���� ������ ���������� ������ ������ ���ϸ����� �༮���Ը� ����ȴ�	
			$( ".glyphicon.glyphicon-search" ).on("mouseover" , function() {
				/* if ( $(this).attr('valProTranCode').trim() == '0') {
					self.location ="/product/getProduct?prodNo="+$(this).attr("valProdNo")+
									"&menu="+$(this).attr("valMenu");*/
					var prodNo = $(this).next().val();
						$.ajax( 
								{
								url : "/product/getJsonProduct/"+ prodNo,
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
									
									var displayValue = "<h6>"
																+"��ǰ��ȣ : "+JSONData.product.prodNo+"<br/>"
																+"��ǰ�� : "+JSONData.product.prodName+"<br/>"
																+"��ǰ�̹��� : "+JSONData.product.fileName+"<br/>"
																+"��ǰ������ : "+JSONData.product.prodDetail+"<br/>"
																+"�������� : "+JSONData.product.manuDate+"<br/>"
																+"���� : "+JSONData.product.price+"<br/>"
																+"������� : "+JSONData.product.regDate+"<br/>"
																+"</h6>";
									//alert(displayValue);
									$("h6").remove();
									$("#"+prodNo+"" ).html(displayValue);
								}
						});
			});
			 
			$( ".prodClick" ).on("click", function() {
				if ( $(this).attr('valProTranCode').trim() == '0') {
					self.location ="/product/getProduct?prodNo="+$(this).attr("valProdNo")+
									"&menu="+$(this).attr("valMenu");
				}
			});
					
					
			 
			$( ".prodClick2" ).on ( "click", function() {
				if ( $(this).attr('valProTranCode').trim() == '1') {
					
						self.location ="/purchase/updateTranCodeByProd?prodNo="+$(this).attr("valProdNo")+
										"&tranCode="+$(this).attr("valProTranCode");
				}
			});
			
			$( ".prodClick2:contains('����ϱ�')" ).css("color" , "red");
			
			$( ".prodClick" ).css("color" , "red");
			
			$( ".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
			
			
		});
		
		
		
</script>
</head>
<body>
	
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
		    <c:if test="${ param.menu == 'manage' }" >
				<h3>��ǰ ����</h3>
		    </c:if>
		    <c:if test="${ param.menu == 'search' }" >
				<h3>��ǰ �����ȸ</h3>
		    </c:if>
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
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    	   value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table ���� �˻� Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >��ǰ��</th>
            <th align="left">����</th>
            <th align="left">�����</th>
            <th align="left">�������</th>
            <th align="left">��������</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left" class="prodClick" valProTranCode="${product.proTranCode.trim()}" valProdNo="${product.prodNo}" valMenu="${param.menu}">
				${product.prodName}
			  </td>
			  <td align="left">${product.price}</td>								   
			  <td align="left">${product.regDate}</td>
			  <td align="left" class="prodClick2" valProTranCode="${product.proTranCode.trim()}" valProdNo="${product.prodNo}" valMenu="${param.menu}">
				<c:if test="${param.menu=='search'}">
					<c:choose>
						<c:when test="${product.proTranCode.trim()=='0'}">
							�Ǹ���
							<br/>
						</c:when>
						<c:otherwise>
							������
							<br/>
						</c:otherwise>
					</c:choose>
				</c:if>
				
				<c:if test="${param.menu=='manage'}">
					<c:choose>
						<c:when test="${product.proTranCode.trim()=='0' }">
							�Ǹ���
							<br/>
						</c:when>
						<c:when test="${product.proTranCode.trim()=='1' }">
							����ϱ�
						</c:when>
						<c:when test="${product.proTranCode.trim()=='2' }">
							�����
							<br/>
						</c:when>
						<c:when test="${product.proTranCode.trim()=='3' }">
							��ۿϷ�
							<br/>
						</c:when>
					</c:choose>
				</c:if>
			  </td>
			  <td align="left">
				  <i class="glyphicon glyphicon-search" id= "${product.prodNo}"></i>
				  <input type="hidden" value="${product.prodNo}">
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
