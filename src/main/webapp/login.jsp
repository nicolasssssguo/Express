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
<title>快递信息管理系统</title>
<link rel="stylesheet" href="<%=basePath %>resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=basePath %>resources/css/bootstrapValidator.min.css" />
<script src="<%=basePath %>resources/js/jquery-1.12.4.min.js"></script>
<script src="<%=basePath %>resources/js/bootstrap.min.js"></script>
<script src="<%=basePath %>resources/js/bootstrapValidator.min.js"></script>
<style>
body,button, input, select, textarea,h1 ,h2, h3, h4, h5, h6 { font-family: Microsoft YaHei,'宋体' , Tahoma, Helvetica, Arial, "\5b8b\4f53", sans-serif;}

.vertical-center {
  min-height: 100%;  /* Fallback for browsers do NOT support vh unit */
  min-height: 100vh; /* These two lines are counted as one :-)       */

  display: flex;
  align-items: center;
}
</style>
</head>
<body class="bg-info vertical-center">
	<div class="container">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-default panel-login">
					<div class="text-center">
						<img src="<%=basePath %>resources/images/logo.png" />
					</div><!-- end of panel-heading -->
					<div class="panel-body">
						<form role="form" id="loginForm" action="${pageContext.request.contextPath}/login.action" method="POST">
							<!-- username field -->
							<div class="form-group">
								<label for="username">用户名:</label>
								<input type="text" name="username" class="form-control" id="username" placeholder="" />
							</div>
							<!-- password field -->
							<div class="form-group">
								<label for="password">密码:</label>
								<input type="password" name="password" class="form-control" id="password" placeholder="" />
							</div>
							<div class="checkbox">
								<label>
									<input type="checkbox" name="rememberme">记住密码
								</label>
							</div>
							<div class="form-group">
								<button type="submit" class="btn btn-lg btn-primary btn-block">登录</button>
							</div>
						</form>
					</div><!-- end of panel-body -->
				</div><!-- end of panel -->
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
		    $('#loginForm').bootstrapValidator({
		        message: 'This value is not valid',
		        feedbackIcons: {
		            valid: 'glyphicon glyphicon-ok',
		            invalid: 'glyphicon glyphicon-remove',
		            validating: 'glyphicon glyphicon-refresh'
		        },
		        fields: {
		        	username: {
		                validators: {
		                    notEmpty: {
		                        message: '用户名不能为空'
		                    },
		                    stringLength: {
		                        min: 5,
		                        max: 30,
		                        message: '用户名长度必须在6-30个字符之间'
		                    },
		                    regexp: {
		                        regexp: /^[a-zA-Z0-9_]+$/,
		                        message: '用户名只能由字母,数字和下划线组成'
		                    }
		                }
		            },
		            password: {
		                validators: {
		                    notEmpty: {
		                        message: 'The password is required'
		                    }
		                }
		            }
		        }
		    });
		});
	</script>
</body>
</html>