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

.toolbar {
	margin-bottom: 5px;
}
</style>
</head>
<body>
	<div class="container">
		<nav class="navbar navbar-default" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand"> <img
						src="<%=basePath%>resources/images/shieldcar.svg" width="25"
						height="25" alt="">
					</a>
				</div>
				<div>
					<ul class="nav navbar-nav navbar-left">
						<li class="nav-item active"><a class="nav-link"
							href="${pageContext.request.contextPath}/index">首页 <span
								class="sr-only">(current)</span></a></li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#"><span class="glyphicon glyphicon-off"></span>
								锁定</a></li>
					</ul>
				</div>
			</div>
		</nav>

		<div class="row">

			<div class="panel panel-primary">
				<div class="panel-heading">快递管理</div>
				<div class="panel-body">
					<div class="col-md-6">
						<form id="searchForm" role="form"
							action="${pageContext.request.contextPath}/exp/search.action"
							method="POST">
							<div class="form-group">
								<label>时间范围：</label>
								<div class="input-daterange input-group" id="datepicker">
									<input type="text" class="input-sm form-control" name="start" />
									<span class="input-group-addon">到</span> <input type="text"
										class="input-sm form-control" name="end" />
								</div>
							</div>

							<div class="form-group">
								<label>状态：</label> <label class="checkbox-inline"> <input
									type="radio" name="express_status" id="optionsRadios3"
									value="option1" checked>全部
								</label> <label class="checkbox-inline"> <input type="radio"
									name="express_status" id="optionsRadios3" value="option1">已签收
								</label> <label class="checkbox-inline"> <input type="radio"
									name="express_status" id="optionsRadios3" value="option1">未签收
								</label>
							</div>

							<div class="form-group">
								<label>地址：</label> <select class="form-control area">
									<option>全部</option>
								</select>
							</div>

							<div class="form-group">
								<label>手机号码：</label> <input class="form-control phone_number" type="text"
									name="phone_number" class="phone_number" />
							</div>

							<div class="form-group">
								<button class="btn btn-lg btn-primary btn-block" type="button">
									<span class="glyphicon glyphicon-search"></span> 搜索
								</button>
							</div>

							<div class="form-group">
								<button class="btn btn-lg btn-primary btn-block" type="button">
									<span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
									重置
								</button>
							</div>
						</form>
					</div>
					<div class="col-md-6">
						<form id="newexpForm" role="form"
							action="${pageContext.request.contextPath}/exp/new.action"
							method="POST">
							<div class="form-group">
								<label>时间：</label>
								<div class="input-group date">
									<input type="text" class="form-control"><span
										class="input-group-addon"><i
										class="glyphicon glyphicon-th"></i></span>
								</div>
							</div>

							<div class="form-group">
								<label>地址：</label> <select class="form-control area">
									<option>全部</option>
								</select>
							</div>

							<div class="form-group">
								<label>姓名：</label> <input class="form-control" type="text"
									name="customer_name" />
							</div>

							<div class="form-group">
								<label>手机号码：</label> <input class="form-control phone_number"
									type="text" name="phone_number" data-provide="typeahead"
									autocomplete="off" />
							</div>

							<div class="form-group">
								<button class="btn btn-lg btn-primary btn-block" type="submit">
									<span class="glyphicon glyphicon-plus"></span> 录入
								</button>
							</div>
						</form>
					</div>

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

		<div class="row footer"></div>
		<script>
			$(document).ready(
					function() {
						$('#newexpForm .input-group.date').datepicker({
							todayBtn : "linked",
							todayHighlight : true,
							autoclose : true,
							format : 'yyyy年mm月dd日',
							language : 'zh-CN'
						});
						$('#newexpForm .input-group.date').datepicker('update',
								new Date());
						$('#searchForm .input-daterange').datepicker({
							todayBtn : "linked",
							todayHighlight : true,
							autoclose : true,
							format : 'yyyy年mm月dd日',
							language : 'zh-CN'
						});
						var source = [ '18759618858' ];
						$("#newexpForm input.phone_number").typeahead({
							source : source,
							items : 8
						});
						$('#newexpForm').bootstrapValidator({
							feedbackIcons : {
								valid : 'glyphicon glyphicon-ok',
								invalid : 'glyphicon glyphicon-remove',
								validating : 'glyphicon glyphicon-refresh'
							},
							fields : {
								phone_number : {
									validators : {
										notEmpty : {
											message : '手机号码不能为空'
										},
										regexp : {
											regexp : /^\d{11}$/,
											message : '无效的手机号码'
										}
									}
								}
							}
						}).on('success.form.bv', function(e) {
							e.preventDefault();
                            $.ajax({
                                  type:'POST',
                                  url:$('#newexpForm').attr('action'),
                                  data:$('#newexpForm').serialize(),
                                  success:function(data){
                                      console.log(data);
                                  }
                              });
						});
						$('#newexpForm input.phone_number').on(
								'change paste keyup',
								function(e) {
									$('#newexpForm')
									.bootstrapValidator('updateStatus', 'phone_number', 'NOT_VALIDATED')
                                    .bootstrapValidator('validateField', 'phone_number');
								});

						$.ajax({
							type : "POST",
							url : "area/list.action",
							data : {},
							success : function(data) {
								for (i in data) {
									var area = data[i];
									$('#searchForm select.area').append(
											'<option value="'+area.code+'">'
													+ area.name + '</option>');
									$('#newexpForm select.area').append(
											'<option value="'+area.code+'">'
													+ area.name + '</option>')
								}
							}
						});
					});
		</script>
</body>
</html>