<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>快递管理系统</title>
<link rel="stylesheet"
	href="<%=basePath%>resources/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="<%=basePath%>resources/css/bootstrapValidator.min.css" />
<link rel="stylesheet"
	href="<%=basePath%>resources/css/bootstrap-datepicker.min.css" />
<script src="<%=basePath%>resources/js/jquery-1.12.4.min.js"></script>
<script src="<%=basePath%>resources/js/bootstrap.min.js"></script>
<script src="<%=basePath%>resources/js/bootstrapValidator.min.js"></script>
<script src="<%=basePath%>resources/js/bootstrap-datepicker.min.js"></script>
<script
	src="<%=basePath%>resources/js/locales/bootstrap-datepicker.zh-CN.min.js"></script>
<script src="<%=basePath%>resources/js/bootstrap-typeahead.min.js"></script>
<style>
body, button, input, select, textarea, h1, h2, h3, h4, h5, h6 {
	font-family: Microsoft YaHei, '宋体', Tahoma, Helvetica, Arial,
		"\5b8b\4f53", sans-serif;
}

body {
	padding-top: 20px;
	padding-bottom: 20px;
}
</style>
</head>
<body>
	<div class="container">
		<nav class="navbar navbar-default" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" href="#">快递管理系统</a>
				</div>
				<div>
					<ul class="nav navbar-nav navbar-left">
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/index">首页 <span
								class="sr-only">(current)</span></a></li>
						<li class="nav-item active"><a class="nav-link"
							href="${pageContext.request.contextPath}/newexpress">录入快递</a></li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#"><span class="glyphicon glyphicon-off"></span>
								锁定</a></li>
					</ul>
				</div>
			</div>
		</nav>

		<div class="panel panel-default">
			<div class="text-center">
				<img src="<%=basePath%>resources/images/logo.png" />
			</div>
		</div>

		<div class="panel panel-primary">
			<div class="panel-heading">快递信息</div>
			<div class="panel-body">
				<form id="newexpForm" role="form" class="form-horizontal"
					action="${pageContext.request.contextPath}/new_express.action"
					method="POST">
					<div class="row">
						<div class="form-group col-md-6">
							<label class="col-sm-3 control-label">时间：</label>
							<div class="input-group date">
								<input type="text" class="form-control"><span
									class="input-group-addon"><i
									class="glyphicon glyphicon-th"></i></span>
							</div>
						</div>

						<div class="form-group col-md-6">
							<label class="col-sm-3 control-label">地址：</label>
							<div class="col-sm-9">
								<select class="form-control">
									<option>全部</option>
									<option value="fujian">西良村</option>
									<option value="fujian">下楼村</option>
									<option value="fujian">世甲村</option>
									<option value="fujian">溪墘村</option>
									<option value="fujian">锦田村</option>
									<option value="fujian">南书村</option>
								</select>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group col-md-6">
							<label class="col-sm-3 control-label">姓名：</label>
							<div class="col-sm-9">
								<input class="form-control" type="text" name="customer_name" />
							</div>
						</div>

						<div class="form-group col-md-6">
							<label class="col-sm-3 control-label">手机号码：</label>
							<div class="col-sm-9">
								<input id="phone_number" class="form-control" type="text"
									name="phone_number" data-provide="typeahead" autocomplete="off" />
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-md-2 col-md-offset-5">
							<button class="btn btn-primary btn-block" type="submit">
								<span class="glyphicon glyphicon-plus"></span>录入
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>

	</div>

	<div class="row footer"></div>
	<script>
		$( document ).ready(function() {
			$('#newexpForm .input-group.date').datepicker({
	            todayBtn : "linked",
	            todayHighlight : true,
	            autoclose : true,
	            format : 'yyyy年mm月dd日',
	            language : 'zh-CN'
	        });
	        $('#newexpForm .input-group.date').datepicker('update', new Date());
	        /*$('#phone_number').on("input", function() {
	        	  var phonenumber = $(this).val();
	        	  if(phonenumber.length >= 4){
	        		  
	        	  }
	        });*/
	        var source = ['18759618858'];
	        $("#phone_number").typeahead({
	        	source:source,
	        	items: 8
	        });
		});
	</script>
</body>
</html>