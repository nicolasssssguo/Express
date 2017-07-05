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
<link rel="stylesheet" href="<%=basePath %>resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=basePath %>resources/css/bootstrapValidator.min.css" />
<script src="<%=basePath %>resources/js/jquery-1.12.4.min.js"></script>
<script src="<%=basePath %>resources/js/bootstrap.min.js"></script>
<script src="<%=basePath %>resources/js/bootstrapValidator.min.js"></script>
<style>
body,button, input, select, textarea,h1 ,h2, h3, h4, h5, h6 { font-family: Microsoft YaHei,'宋体' , Tahoma, Helvetica, Arial, "\5b8b\4f53", sans-serif;}
</style>
</head>
<body class="bg-info">
	<div class="container">
		<nav class="navbar navbar-default" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" href="#">快递管理系统</a>
				</div>
				
				<ul class="nav navbar-nav navbar-right"> 
		            <li><a href="#"><span class="glyphicon glyphicon-off"></span> 锁定</a></li> 
		        </ul>
			</div>
		</nav>
	</div>
	<script>
	</script>
</body>
</html>