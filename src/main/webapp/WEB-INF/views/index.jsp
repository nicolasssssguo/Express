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

.toolbar {
	margin-top: 5px;
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<div class="container">
		<nav class="navbar navbar-default" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" href="#">首页</a>
				</div>

				<ul class="nav navbar-nav navbar-right">
					<li><a href="#"><span class="glyphicon glyphicon-off"></span>
							锁定</a></li>
				</ul>
			</div>
		</nav>

		<div class="panel panel-default">
			<div class="text-center">
				<img src="<%=basePath%>resources/images/logo.png" />
			</div>
		</div>
		<div class="dateoption row text-center">
			<div class="col-md-4 col-md-offset-8">
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-info active"> <input type="radio"
						name="options" id="option1" autocomplete="off" checked>
						全部
					</label> <label class="btn btn-info"> <input type="radio"
						name="options" id="option2" autocomplete="off"> 一周
					</label> <label class="btn btn-info"> <input type="radio"
						name="options" id="option3" autocomplete="off"> 今日
					</label> <label class="btn btn-info"> <input type="radio"
						name="options" id="option3" autocomplete="off"> 自定义
					</label>
				</div>
			</div>
		</div>
		<div id="datepicker" class="datepicker row">
			<div class="col-md-4 col-md-offset-8">
				<div class="input-daterange input-group" id="datepicker">
				    <input type="text" class="input-sm form-control" name="start" />
				    <span class="input-group-addon">到</span>
				    <input type="text" class="input-sm form-control" name="end" />
				</div>
			</div>
		</div>
		<div class="row toolbar">
			<div class="col-md-4">
				<button type="button" class="btn btn-default btn-sm">
					<span class="glyphicon glyphicon-plus"></span>录入
				</button>
			</div>
			<div class="col-md-4 col-md-offset-4">
				<div class="input-group">
					<div class="input-group-btn">
						<button type="button" class="btn btn-default dropdown-toggle"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							手机号码<span class="caret"></span>
						</button>
						<ul class="dropdown-menu">
							<li><a href="#">手机号码</a></li>
							<li><a href="#">姓名</a></li>
						</ul>
					</div>
					<!-- /btn-group -->
					<input type="text" class="form-control" aria-label="...">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button">
							<span class="glyphicon glyphicon-search"></span>
						</button>
					</span>
				</div>
				<!-- /input-group -->
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th>序号</th>
							<th>地址</th>
							<th>姓名</th>
							<th>电话</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">1</th>
							<td>Mark</td>
							<td>Otto</td>
							<td>@mdo</td>
						</tr>
						<tr>
							<th scope="row">2</th>
							<td>Mark</td>
							<td>Otto</td>
							<td>@TwBootstrap</td>
						</tr>
						<tr>
							<th scope="row">3</th>
							<td>Jacob</td>
							<td>Thornton</td>
							<td>@fat</td>
						</tr>
						<tr>
							<th scope="row">4</th>
							<td colspan="2">Larry the Bird</td>
							<td>@twitter</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script>
	$('#datepicker .input-daterange').datepicker({
		format: 'yyyy年mm月dd日',
		language: 'zh-CN'
	});
	</script>
</body>
</html>