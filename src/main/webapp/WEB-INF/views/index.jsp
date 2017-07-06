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
<script src="<%=basePath%>resources/js/locales/bootstrap-datepicker.zh-CN.min.js"></script>
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
				      <li class="nav-item active">
				        <a class="nav-link" href="${pageContext.request.contextPath}/index">首页 <span class="sr-only">(current)</span></a>
				      </li>
				      <li class="nav-item">
				        <a class="nav-link" href="${pageContext.request.contextPath}/newexpress">录入快递</a>
				      </li>
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
		  <div class="panel-heading">搜索</div>
		  <div class="panel-body">
		    <form id="searchForm" role="form" class="form-horizontal" action="${pageContext.request.contextPath}/search_express.action" method="POST">
		      <div class="row">
		          <div class="form-group col-md-6">
	                  <label class="col-sm-3 control-label">时间范围：</label>
	                  <div class="input-daterange input-group col-sm-9" id="datepicker">
	                      <input type="text" class="input-sm form-control" name="start" />
	                      <span class="input-group-addon">到</span>
	                      <input type="text" class="input-sm form-control" name="end" />
	                  </div>
	              </div>
	              
	              <div class="form-group col-md-6">
                      <label class="col-sm-3 control-label">状态：</label>
                      <label class="checkbox-inline">
                        <input type="radio" name="express_status" id="optionsRadios3" value="option1" checked>全部
                      </label>
                      <label class="checkbox-inline">
					    <input type="radio" name="express_status" id="optionsRadios3" value="option1">已签收
					  </label>
					  <label class="checkbox-inline">
                        <input type="radio" name="express_status" id="optionsRadios3" value="option1">未签收
                      </label>
                  </div>
		      </div>
		      
		      <div class="row">
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
                  
                  <div class="form-group col-md-6">
                      <label class="col-sm-3 control-label">手机号码：</label>
                      <div class="col-sm-9">
                        <input class="form-control" type="text" name="phone_number" />
                      </div>
                  </div>
		      </div>
		      
		      <div class="text-center">
		          <button class="btn btn-primary btn-md" type="submit">
		          <span class="glyphicon glyphicon-search"></span>搜索</button>
		          <button class="btn btn-default btn-md" type="button">
		          <span class="glyphicon glyphicon-refresh"></span>重置</button>
		      </div>
		    </form>
		  </div>
        </div>
		
		<div class="row">
			<div class="col-md-12">
				<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th>序号</th>
							<th>姓名</th>
							<th>地址</th>
							<th>电话</th>
							<th>状态</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">1</th>
							<td>地址</td>
							<td>姓名</td>
							<td>电话</td>
							<td>状态</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<div class="row footer">
	   
	</div>
	<script>
	$('#searchForm .input-daterange').datepicker({
		format: 'yyyy年mm月dd日',
		language: 'zh-CN'
	});
	</script>
</body>
</html>