<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link rel="shortcut icon"
	href="<%=basePath%>resources/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet"
	href="<%=basePath%>resources/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="<%=basePath%>resources/css/bootstrapValidator.min.css" />
<link rel="stylesheet"
	href="<%=basePath%>resources/css/bootstrap-datepicker.min.css" />

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

.pagination-info {
	margin: 25px 0;
}

.panel-footer {
	padding: 50px 0;
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/expressdialog.jsp" />

	<div class="container">
		<nav class="navbar navbar-default" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand"> <img
						src="<%=basePath%>resources/images/logo.svg" width="25"
						height="25" alt="">
					</a>
				</div>
				<div>
					<ul class="nav navbar-nav navbar-left">
						<li class="nav-item active"><a class="nav-link"
							href="${pageContext.request.contextPath}/index">首页 <span
								class="sr-only">(current)</span></a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/customer/index">收件人管理
								<span class="sr-only">(current)</span>
						</a></li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li><a
							href="${pageContext.request.contextPath}/user/logout.action"><span
								class="glyphicon glyphicon-off"></span> 锁定</a></li>
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
										name="status" value="" checked>全部
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
									class="form-control phoneNumber" type="text" name="phoneNumber"
									autofocus />
							</div>
						</div>
					</div>
					<div class="text-center">
						<div class="btn-group" role="group" aria-label="Basic example">
							<button class="btn btn-md btn-primary" type="submit">
								<span class="glyphicon glyphicon-search"></span> 搜索
							</button>
							<a href="${pageContext.request.contextPath}/index"
								class="btn btn-md btn-default"> <span
								class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
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
						<div class="btn-group" role="group">
							<button class="btn btn-primary" type="button"
								onclick="showExpressDialog()">
								<span class="glyphicon glyphicon-plus"></span> 增加
							</button>
							<button id="batchSign" class="btn btn-primary" type="button"
								onclick="batchSignExpress();" disabled>
								<span class="glyphicon glyphicon-pencil"></span> 批量签收
							</button>
							<button id="batchRemove" class="btn btn-primary" type="button"
								onclick="showConfirmDialog(DEFAULT_TITLE, '是否删除选中的快递信息（若收件人拥有的快递信息一并删除）？', batchRemoveExpress);"
								disabled>
								<span class="glyphicon glyphicon-trash"></span> 批量删除
							</button>
						</div>
					</div>
					<div class="col-md-4 col-md-offset-4">
						<div class="text-right">
							<a href="${pageContext.request.contextPath}/express/export.action" class="btn btn-primary">
								<span class="glyphicon glyphicon-export"></span> 导出
							</a>
						</div>
					</div>
				</div>
			</div>
			<table id="expressTable" class="table table-bordered table-hober">
				<thead>
					<tr class="primary">
						<th class="text-center" style="width: 36px;"><input
							type="checkbox" id="checkAll" name="checkAll" /></th>
						<th class="text-center">姓名</th>
						<th class="text-center">地址</th>
						<th class="text-center">手机号码</th>
						<th class="text-center">到达日期</th>
						<th class="text-center">状态</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${expressPage.list}" var="item">
						<tr>
							<td class="text-center" style="width: 36px;"><input
								id="${item.id}" type="checkbox" name="checkItem" /></td>
							<td class="text-center">${item.recipient.name}</td>
							<td class="text-center">${item.dest.name}</td>
							<td class="text-center">${item.recipient.phoneNumber}</td>
							<td class="text-center"><fmt:formatDate
									value="${item.arriveDate}" pattern="yyyy-MM-dd" /></td>
							<c:if test="${item.status == 0}">
								<td class="text-center"><button
										class="btn btn-primary btn-sm"
										onclick="signExpress(['${item.id}']);">
										<span class="glyphicon glyphicon-pencil"></span> 签收
									</button></td>
							</c:if>
							<c:if test="${item.status == 1}">
								<td class="text-center"><span class="label label-info">已签收(签收时间:
										<fmt:formatDate value="${item.signTime}"
											pattern="yyyy-MM-dd HH:mm:ss" />)
								</span></td>
							</c:if>
							<td class="text-center">
								<div class="btn-group" role="group">
									<button class="btn btn-primary btn-sm"
										onclick="showExpressDialog('${item.id}');">
										<span class="glyphicon glyphicon-edit"></span>
									</button>
									<button class="btn btn-primary btn-sm"
										onclick="showConfirmDialog(DEFAULT_TITLE, '是否删除快递信息？', ['${item.id}'], removeExpress);">
										<span class="glyphicon glyphicon-trash"></span>
									</button>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<c:if test="${expressPage.list.size() > 0}">
				<div class="pagination-bar">
					<div class="col-md-6">
						<div class="text-left">
							<div class="pagination-info">
								<span class="label label-primary"> <c:choose>
										<c:when test="${expressPage.pageNo <= 1}">
									第1 - 
								</c:when>
										<c:otherwise>
									第${(expressPage.pageNo - 1)*expressPage.pageSize + 1} - 
								</c:otherwise>
									</c:choose> ${(expressPage.pageNo - 1)*expressPage.pageSize + expressPage.list.size()}条
									共${expressPage.totalRecords}条 共${expressPage.getTotalPages()}页
								</span>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="text-right">
							<nav>
								<ul class="pagination pagination-md">
									<c:choose>
										<c:when test="${expressPage.pageNo <= 1}">
											<li class="disabled"><a aria-label="<<"><<</a></li>
											<li class="disabled"><a aria-label="<"><</a></li>
										</c:when>
										<c:otherwise>
											<li><a href="?pageNo=1" aria-label="<<"><<</a></li>
											<li><a href="?pageNo=${expressPage.pageNo-1}"
												aria-label="<"><</a></li>
										</c:otherwise>
									</c:choose>
									<c:forEach begin="1" end="${expressPage.getTotalPages()}"
										var="pageNo">
										<c:if test="${expressPage.pageNo != pageNo}">
											<li><a href="?pageNo=${pageNo}">${pageNo}</a></li>
										</c:if>
										<c:if test="${expressPage.pageNo == pageNo}">
											<li class="active"><a>${pageNo}</a></li>
										</c:if>
									</c:forEach>
									<c:choose>
										<c:when
											test="${expressPage.pageNo >= expressPage.getTotalPages()}">
											<li class="disabled"><a aria-label=">">></a></li>
											<li class="disabled"><a aria-label=">>">>></a></li>
										</c:when>
										<c:otherwise>
											<li><a href="?pageNo=${expressPage.pageNo+1}"
												aria-label=">">></a></li>
											<li><a href="?pageNo=${expressPage.getTotalPages()}"
												aria-label=">>">>></a></li>
										</c:otherwise>
									</c:choose>
								</ul>
							</nav>
						</div>
					</div>


				</div>
			</c:if>
			<c:if test="${expressPage.list.size() == 0}">
				<div class="panel-footer">
					<div class="text-center">无记录</div>
				</div>
			</c:if>
		</div>


		<div class="row footer"></div>
		<script type="text/javascript">
			var AREA_LIST = '${pageContext.request.contextPath}/area/list.action';
			var EXPRESS_URL = '${pageContext.request.contextPath}/express';
			var CREATE_EXPRESS_URL = EXPRESS_URL + '/create.action';
			var UPDATE_EXPRESS_URL = EXPRESS_URL + '/update.action';
			var SIGN_EXPRESS_URL = EXPRESS_URL + '/sign.action';
			var REMOVE_EXPRESS_URL = EXPRESS_URL + '/remove.action';
			var RETRIEVE_EXPRESS_URL = EXPRESS_URL + '/retrieve.action';
		</script>
		<script src="<%=basePath%>resources/js/jquery-1.12.4.min.js"></script>
		<script src="<%=basePath%>resources/js/bootstrap.min.js"></script>
		<script src="<%=basePath%>resources/js/bootstrapValidator.min.js"></script>
		<script src="<%=basePath%>resources/js/bootstrap-datepicker.min.js"></script>
		<script
			src="<%=basePath%>resources/js/locales/bootstrap-datepicker.zh-CN.min.js"></script>
		<script src="<%=basePath%>resources/js/bootstrap-typeahead.min.js"></script>
		<script src="<%=basePath%>resources/js/index.js"></script>
</body>
</html>