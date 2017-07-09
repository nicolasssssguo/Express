<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ contextPath + "/";
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
<script src="<%=basePath%>resources/js/bootstrap-typeahead.js"></script>
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
	<div class="modal fade" id="expressDialog" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">快递录入</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="alert alert-success collapse" role="alert">录入成功！</div>
					<div class="alert alert-danger collapse" role="alert">录入失败！</div>
					<form id="expressForm" role="form"
						action="${pageContext.request.contextPath}/express/create.action"
						method="POST">
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon">姓名</span> <input
									class="form-control" type="text"
									name="name" />
							</div>
						</div>

						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon">手机号码</span> <input
									class="form-control phoneNumber" type="text"
									name="phoneNumber" class="phoneNumber" autocomplete="off" />
							</div>
						</div>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon">地址</span> <select name="area"
									class="form-control area">
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="input-group date">
								<span class="input-group-addon">时间</span> <input type="text" name="createTime"
									class="form-control"><span class="input-group-addon"><i
									class="glyphicon glyphicon-th"></i></span>
							</div>
						</div>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon">状态</span>
								<div class="form-control">
									<label class="checkbox-inline"> <input type="radio"
										name="status" value="0" checked>未签收
									</label> <label class="checkbox-inline"> <input type="radio"
										name="status" value="1">已签收
									</label>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary"
						onclick="createExpress()">录入</button>
				</div>
			</div>
		</div>
	</div>
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
							href="${pageContext.request.contextPath}/express/index">首页 <span
								class="sr-only">(current)</span></a></li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#"><span class="glyphicon glyphicon-off"></span>
								锁定</a></li>
					</ul>
				</div>
			</div>
		</nav>

		<div class="panel panel-primary panel-search">
			<div class="panel-heading">搜索</div>
			<div class="panel-body">
				<form id="searchForm" role="form"
					action="${pageContext.request.contextPath}/express/search.action"
					method="POST">
					<div class="col-md-6">
						<div class="form-group">
							<div class="input-daterange input-group" id="datepicker">
								<span class="input-group-addon">时间范围</span> <input type="text"
									class="input-sm form-control" name="startDate" /> <span
									class="input-group-addon">到</span> <input type="text"
									class="input-sm form-control" name="endDate" />
							</div>
						</div>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon">地址</span> <select name="area"
									class="form-control area">
									<option value="">全部</option>
								</select>
							</div>
						</div>


					</div>

					<div class="col-md-6">
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon">状态</span>
								<div class="form-control">
									<label class="checkbox-inline"> <input type="radio"
										name="status" value="-1" checked>全部
									</label> <label class="checkbox-inline"> <input type="radio"
										name="status" value="0">未签收
									</label> <label class="checkbox-inline"> <input type="radio"
										name="status" value="1">已签收
									</label>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon">手机号码</span> <input
									class="form-control phoneNumber" type="text"
									name="phoneNumber" class="phoneNumber" value="18759618858" autocomplete="off" />
							</div>
						</div>
					</div>
					<div class="text-center">
						<div class="btn-group" role="group" aria-label="Basic example">
							<button class="btn btn-md btn-primary" type="submit">
								<span class="glyphicon glyphicon-search"></span> 搜索
							</button>
							<a href="${pageContext.request.contextPath}/express/index" class="btn btn-md btn-default">
								<span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
								重置
							</a>
						</div>
					</div>
				</form>
			</div>
		</div>

		<div class="panel panel-default panel-table">
			<div class="panel-heading">快递列表</div>
			<div class="panel-body">
				<div class="toolbar">
					<div class="col-md-4">
						<div class="btn-group" role="group" aria-label="Basic example">
							<button class="btn btn-default" type="button"
								onclick="showNewExpDialog()">
								<span class="glyphicon glyphicon-plus"></span> 增加
							</button>
							<button id="btnEdit" class="btn btn-default" type="button" disabled>
								<span class="glyphicon glyphicon-pencil"></span> 编辑
							</button>
							<button id="btnRemove" class="btn btn-default" type="button" disabled>
								<span class="glyphicon glyphicon-remove"></span> 删除
							</button>
						</div>
					</div>
				</div>
			</div>
			<table id="expressTable" class="table table-bordered table-hober">
				<thead>
					<tr class="success">
						<th class="text-center">姓名</th>
						<th class="text-center">地址</th>
						<th class="text-center">电话</th>
						<th class="text-center">状态</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${expressPage.list}" var="item">
						<tr>
							<td class="text-center">${item.recipient.name}</td>
							<td class="text-center">${item.dest.name}</td>
							<td class="text-center">${item.recipient.phoneNumber}</td>
							<c:if test="${item.status == 0}">
							<td class="text-center"><a href="${pageContext.request.contextPath}/express/sign.action?id=${item.id}">
							<span class="glyphicon glyphicon-pencil"></span> 签收</a></td>
							</c:if>
							<c:if test="${item.status == 1}">
							<td class="text-center"><span class="text-danger">已签收(签收时间: ${item.signTime})</span></td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="panel-footer">
				<div class="text-center">
					<nav>
						<ul class="pagination pagination-sm">
							<c:choose>
								<c:when test="${expressPage.pageNo <= 1}">
									<li class="disabled"><a aria-label="上一页">上一页</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="${action}?pageNo=${expressPage.pageNo-1}" aria-label="上一页">上一页</a></li>
								</c:otherwise>
							</c:choose>
							<c:forEach begin="1" end="${expressPage.getTotalPages()}" var="pageNo">
								<c:if test="${expressPage.pageNo != pageNo}">
									<li><a href="${action}?pageNo=${pageNo}">${pageNo}</a></li>
								</c:if>
								<c:if test="${expressPage.pageNo == pageNo}">
									<li class="active"><a>${pageNo}</a></li>
								</c:if>
							</c:forEach>
							<c:choose>
								<c:when test="${expressPage.pageNo >= expressPage.getTotalPages()}">
									<li class="disabled"><a aria-label="下一页">下一页</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="${action}?pageNo=${expressPage.pageNo+1}" aria-label="下一页">下一页</a></li>
								</c:otherwise>
							</c:choose>
						</ul>
					</nav>
				</div>
			</div>
		</div>

		<div class="row footer"></div>
		<script>
			function showNewExpDialog() {
				$('#expressDialog').modal('show');
			}
			function createExpress() {
				var $form = $('#expressForm');
				var bv = $form.data('bootstrapValidator');
				bv.validate();
				if (bv.isValid()) {
					$.post($form.attr('action'), $form.serialize(), function(
							result) {
						$('#expressDialog div.alert-success').fadeIn();
						$('#expressForm').bootstrapValidator('resetForm', true);
					});
				}
			}
			function tableToolbarControl(checkedCount){
				$("#btnEdit").prop('disabled', (checkedCount == 0 || checkedCount > 1));
				$("#btnRemove").prop('disabled', (checkedCount == 0));
			}
			
			function initTableCheckbox() {
				var $thr = $('table thead tr');
				var $checkAllTh = $('<th class="text-center" style="width:36px;"><input type="checkbox" id="checkAll" name="checkAll" /></th>');
				/*将全选/反选复选框添加到表头最前，即增加一列*/
				$thr.prepend($checkAllTh);

				var $checkAll = $thr.find('input');
				$checkAll
						.click(function(event) {
							/*将所有行的选中状态设成全选框的选中状态*/
							$tbr.find('input').prop('checked',
									$(this).prop('checked'));
							/*并调整所有选中行的CSS样式*/
							if ($(this).prop('checked')) {
								$tbr.find('input').parent().parent().addClass(
										'warning');
								tableToolbarControl($tbr.find('input:checked').length);
							} else {
								$tbr.find('input').parent().parent()
										.removeClass('warning');
								tableToolbarControl($tbr.find('input:checked').length);
							}
							/*阻止向上冒泡，以防再次触发点击操作*/
							event.stopPropagation();
						});
				$checkAllTh.click(function() {
					$(this).find('input').click();
				});

				var $tbr = $('table tbody tr');
				var $checkItemTd = $('<td class="text-center" style="width:36px;"><input type="checkbox" name="checkItem" /></td>');
				$tbr.prepend($checkItemTd);
				$tbr
						.find('input')
						.click(
								function(event) {
									/*调整选中行的CSS样式*/
									$(this).parent().parent().toggleClass(
											'warning');
									/*如果已经被选中行的行数等于表格的数据行数，将全选框设为选中状态，否则设为未选中状态*/
									$checkAll
											.prop(
													'checked',
													$tbr.find('input:checked').length == $tbr.length ? true
															: false);
									tableToolbarControl($tbr.find('input:checked').length);
									/*阻止向上冒泡，以防再次触发点击操作*/
									event.stopPropagation();
								});
				/*点击每一行时也触发该行的选中操作*/
				$tbr.click(function() {
					$(this).find('input').click();
				});
			}
			$(document).ready(
					function() {
						$('#expressForm .input-group.date').datepicker({
							todayBtn : "linked",
							todayHighlight : true,
							autoclose : true,
							format : 'yyyy年mm月dd日',
							language : 'zh-CN'
						});
						$('#expressForm .input-group.date').datepicker('update',
								new Date());
						$('#expressForm .input-group.date').datepicker(
								'setEndDate', new Date());
						$('#searchForm .input-daterange').datepicker({
							todayBtn : "linked",
							todayHighlight : true,
							autoclose : true,
							format : 'yyyy年mm月dd日',
							language : 'zh-CN'
						});
						$("#expressForm input.phoneNumber").typeahead({
							source : function (query, process) {
					            return $.get('${pageContext.request.contextPath}/customer/search?keynumber=' + query, function (data) {
					            	console.log(data);
					                return process(data);
					            });
					        },
					        displayText:function(item){
					        	return typeof item !== 'undefined' && typeof item.phoneNumber != 'undefined' ? item.phoneNumber : item;
					        },
					        afterSelect:function(item){
					        	var $area = $('#expressForm select[name="area"]');
					        	var $name = $('#expressForm input[name="name"]');
					        	$area.val(item.area.code);
					        	$name.val(item.name);
					        	$('#expressDialog div.alert-success').hide();
					        },
							delay : 300
						});
						$('#expressForm').bootstrapValidator({
							feedbackIcons : {
								valid : 'glyphicon glyphicon-ok',
								invalid : 'glyphicon glyphicon-remove',
								validating : 'glyphicon glyphicon-refresh'
							},
							fields : {
								phoneNumber : {
									validators : {
										notEmpty : {
											message : '手机号码不能为空'
										},
										regexp : {
											regexp : /^\d{11}$/,
											message : '无效的手机号码'
										}
									}
								},
								area : {
									validators : {
										notEmpty : {
											message : '地址不能为空'
										}
									}
								},
								name : {
									validators : {
										notEmpty : {
											message : '姓名不能为空'
										}
									}
								}
							}
						});
						
						$('#searchForm').bootstrapValidator({
							feedbackIcons : {
								valid : 'glyphicon glyphicon-ok',
								invalid : 'glyphicon glyphicon-remove',
								validating : 'glyphicon glyphicon-refresh'
							},
							fields : {
								phoneNumber : {
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
						});

						$('#expressForm input.phoneNumber').on(
								'change paste keyup',
								function(e) {
									$('#expressForm').bootstrapValidator(
											'updateStatus', 'phoneNumber',
											'NOT_VALIDATED')
											.bootstrapValidator(
													'validateField',
													'phoneNumber');
								});

						$.ajax({
							type : "POST",
							url : "${pageContext.request.contextPath}/area/list.action",
							data : {},
							success : function(data) {
								for (i in data) {
									var area = data[i];
									$('select.area').append(
											'<option value="'+area.code+'">'
													+ area.name + '</option>');
								}
							}
						});

						initTableCheckbox();
						
						$('#expressDialog').on('hidden.bs.modal',function(){
							location.reload();
							//$('#expressForm').bootstrapValidator('resetForm', true);
						});
					});
		</script>
</body>
</html>