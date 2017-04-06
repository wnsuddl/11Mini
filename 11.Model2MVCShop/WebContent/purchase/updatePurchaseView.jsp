<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>






<html>
<head>
	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<script type="text/javascript" src="../javascript/calendar.js"></script>
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
	
	function fncUpdatePurchase(){
		
		$("form").attr("method", "POST").attr("action", "/purchase/updatePurchase?tranNo=${purchase.tranNo}").submit();
	}
	
	$(function (){
		
		$("button.btn.btn-primary").on("click", function(){
			fncUpdatePurchase();
		});
		
		$("a[href='#' ]").on("click", function(){
			history.go(-1);
		});
		
		$( "button.btn.btn-info" ).on("click", function(){
			show_calendar ('document.detailForm.divyDate', $("#divyDate").val());
		});
		
		
	});
	

</script>
</head>

	<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">������������</h3>
	       <h5 class="text-muted">���������� <strong class="text-danger">����</strong>�� �ּ���.</h5>
	    </div>
	    
	    <!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" name="detailForm">
		  
		  <div class="form-group">
		    <label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">�����ھ��̵�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="buyerId" name="buyerId" value="${purchase.buyer.userId}" readonly>
		      <span id="helpBlock" class="help-block">
		      	<strong class="text-danger">�����ھ��̵�� �����Ұ�</strong>
		      </span>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
		    <div class="col-sm-4">
		    	<select class="form-control" name="paymentOption" id="paymentOption">
				  	<option value="1" selected="selected">���ݱ���</option>
					<option value="2" >�ſ뱸��</option>
				</select>
		    </div>
		  </div>
		
		  <div class="form-group">
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">�������̸�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="${purchase.receiverName}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">������ ����ó</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" placeholder="${purchase.receiverPhone}">
		    </div>
		  </div>
		   <!--css��Ʈ�� Inline form�ʿ� ��������ġ�±�� �����غ���  -->
		  
		  <div class="form-group">
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">�������ּ�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyAddr" name="divyAddr" placeholder="${purchase.divyAddr}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyRequest" name="divyRequest"  placeholder="${purchase.divyRequest}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
		    <div class="col-sm-4">
		      <input type="divyDate" class="form-control" id="divyDate" name="divyDate" placeholder="${purchase.divyDate}" readonly>
		    </div>
		    <div class="col-sm-3">
		      <button type="button" class="btn btn-info"><i class="glyphicon glyphicon-calendar" id="date"></i></button>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >�� &nbsp;��</button>
			  <a class="btn btn-primary btn" href="#" role="button">����ȭ�����ΰ���</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
	    
 	</div>
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
 	
	</body>

</html>

