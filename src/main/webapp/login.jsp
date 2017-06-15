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
<title>LOGIN Template</title>
<link rel="stylesheet" href="<%=basePath %>resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=basePath %>resources/css/bootstrapValidator.min.css" />
<script src="<%=basePath %>resources/js/jquery-3.1.1.min.js"></script>
<script src="<%=basePath %>resources/js/bootstrap.min.js"></script>
<script src="<%=basePath %>resources/js/bootstrapValidator.min.js"></script>
<style>
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-default panel-login">
					<div class="text-center">
						<h2>LOG IN</h2>
					</div><!-- end of panel-heading -->
					<hr />
					<div class="panel-body">
						<form role="form" id="loginForm">
							<!-- username field -->
							<div class="form-group">
								<label for="username">UserName:</label>
								<input type="text" name="username" class="form-control" id="username" placeholder="" />
							</div>
							<!-- password field -->
							<div class="form-group">
								<label for="password">Password:</label>
								<input type="password" name="password" class="form-control" id="password" placeholder="" />
							</div>
							<div class="checkbox">
								<label>
									<input type="checkbox" name="rememberme">Remember Me
								</label>
							</div>
							<div class="form-group">
								<button type="submit" class="btn btn-lg btn-primary btn-block">LOG IN</button>
							</div>
							<div class="form-group">
								<div class="text-right">
									<a href="#" class="text-info">Forgot Password?</a>
									<span>|</span>
									<a href="#" class="text-info">Create Account</a>
								</div>
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
		                        message: 'The username is required'
		                    },
		                    stringLength: {
		                        min: 6,
		                        max: 30,
		                        message: 'The username must be more than 6 and less than 30 characters long'
		                    },
		                    regexp: {
		                        regexp: /^[a-zA-Z0-9_]+$/,
		                        message: 'The username can only consist of alphabetical, number and underscore'
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