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
<title>SIGN UP Template</title>
<link rel="stylesheet" href="<%=basePath %>resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=basePath %>resources/css/bootstrapValidator.min.css" />
<link rel="stylesheet" href="<%=basePath %>resources/css/bootstrap-datetimepicker.min.css" />
<script src="<%=basePath %>resources/js/jquery-1.10.2.min.js"></script>
<script src="<%=basePath %>resources/js/bootstrap.min.js"></script>
<script src="<%=basePath %>resources/js/bootstrapValidator.min.js"></script>
<script src="<%=basePath %>resources/js/moment.min.js"></script>
<script src="<%=basePath %>resources/js/bootstrap-datetimepicker.min.js"></script>
<!-- Override feedback icon position -->
<style type="text/css">

</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-default panel-login">
					<div class="text-center">
						<h2>Sign up</h2>
					</div><!-- end of panel-heading -->
					<hr />
					<div class="panel-body">
						<form role="form" id="loginForm">
							<!-- username field -->
							<div class="form-group">
								<label for="username">UserName:</label>
								<input type="text" name="username" class="form-control" id="username" placeholder="" />
							</div>
							<div class="form-group">
								<label for="email">Email:</label>
								<input type="text" name="email" class="form-control" id="email" placeholder="" />
							</div>
							<!-- password field -->
							<div class="form-group">
								<label for="password">Password:</label>
								<input type="password" name="password" class="form-control" id="password" placeholder="" />
							</div>
							<div class="form-group">
								<label for="password">Confirm Password:</label>
								<input type="password" name="confirm-password" class="form-control" id="confirm-password" placeholder="" />
							</div>
							<div class="form-group">
						        <label class="control-label">Gender</label>
						        <select class="form-control" name="gender">
						                <option value="">Choose gender</option>
						                <option value="male">Male</option>
						                <option value="female">Female</option>
						                <option value="other">Other</option>
						            </select>
						    </div>
							<div class="form-group">
						        <label for="dob">Date of birth</label>
						        <div class="input-group date" id="dobPicker" data-date-format="YYYY/DD/MM">
						        	<input type="text" class="form-control" name="dob" />
						            <span class="input-group-addon">
						            	<span class="glyphicon-calendar glyphicon"></span>
						            </span>
						        </div>
						    </div>
							<div class="form-group">
								<button type="submit" class="btn btn-lg btn-primary btn-block">Sign up</button>
							</div>
							<div class="form-group">
								<div class="text-right">
									<a href="#" class="text-info">Already registered? Sign in</a>
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
			 $('#dobPicker').datetimepicker({
		            pickTime: false
		        });
			
		    $('#loginForm').bootstrapValidator({
		        message: 'This value is not valid',
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
		            email: {
		                validators: {
		                	emailAddress: {
		                        message: 'The value is not a valid email address'
		                    }
		                }
		            },
		            password: {
		                validators: {
		                    notEmpty: {
		                        message: 'The password is required'
		                    }
		                }
		            },
		            'confirm-password': {
		                validators: {
		                    notEmpty: {
		                        message: 'The confirm password is required and can\'t be empty'
		                    },
		                    identical: {
		                        field: 'password',
		                        message: 'The password and its confirm are not the same'
		                    }
		                }
		            },
		            gender: {
		                validators: {
		                    notEmpty: {
		                        message: 'The gender is required and cannot be empty'
		                    }
		                }
		            },
		            dob: {
		                validators: {
		                    notEmpty: {
		                        message: 'The date of birth is required and cannot be empty'
		                    },
		                    date: {
		                        format: 'YYYY/DD/MM',
		                        message: 'The value is not a valid date'
		                    }
		                }
		            }
		        }
		    });
		});
	</script>
</body>
</html>