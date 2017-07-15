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
<title>收件人信息管理</title>
<link rel="shortcut icon"
	href="<%=basePath%>resources/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet"
	href="<%=basePath%>resources/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="<%=basePath%>resources/css/bootstrapValidator.min.css" />

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

	<jsp:include page="/WEB-INF/views/customerdialog.jsp" />

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
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/index">首页 <span
								class="sr-only">(current)</span></a></li>
						<li class="nav-item active"><a class="nav-link"
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
					action="${pageContext.request.contextPath}/customer/search.action"
					method="POST">
					<div class="col-md-6">
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon">姓名</span> <input
									class="form-control" type="text" name="name" />
							</div>
						</div>
					</div>
					<div class="col-md-6">
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
							<a href="${pageContext.request.contextPath}/customer/index"
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
			<div class="panel-heading">收件人列表</div>
			<div class="panel-body">
				<div class="toolbar">
					<div class="col-md-4">
						<div class="btn-group" role="group">
							<button class="btn btn-primary" type="button"
								onclick="showCustomerDialog()">
								<span class="glyphicon glyphicon-plus"></span> 增加
							</button>
							<button id="batchRemove" class="btn btn-primary" type="button"
								onclick="showConfirmDialog(DEFAULT_TITLE, '是否删除选中的收件人信息(收件人的所有快递信息也一并删除)？', null, batchRemoveCustomer);"
								disabled>
								<span class="glyphicon glyphicon-trash"></span> 批量删除
							</button>
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
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${customerPage.list}" var="item">
						<tr>
							<td class="text-center" style="width: 36px;"><input
								id="${item.id}" type="checkbox" name="checkItem" /></td>
							<td class="text-center">${item.name}</td>
							<td class="text-center">${item.area.name}</td>
							<td class="text-center">${item.phoneNumber}</td>
							<td class="text-center">
								<div class="btn-group" role="group">
									<button class="btn btn-primary btn-sm"
										onclick="showCustomerDialog('${item.id}');">
										<span class="glyphicon glyphicon-edit"></span>
									</button>
									<button class="btn btn-primary btn-sm"
										onclick="showConfirmDialog(DEFAULT_TITLE, '是否删除收件人信息(收件人的所有快递信息也一并删除)？', ['${item.id}'], removeCustomer);">
										<span class="glyphicon glyphicon-trash"></span>
									</button>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<c:if test="${customerPage.list.size() > 0}">
				<div class="pagination-bar">
					<div class="col-md-6">
						<div class="text-left">
							<div class="pagination-info">

								<span class="label label-primary"> <c:choose>
										<c:when test="${customerPage.pageNo <= 1}">
									第1 - 
								</c:when>
										<c:otherwise>
									第${(customerPage.pageNo - 1)*customerPage.pageSize + 1} - 
								</c:otherwise>
									</c:choose> ${(customerPage.pageNo - 1)*customerPage.pageSize + customerPage.list.size()}条
									共${customerPage.totalRecords}条
									共${customerPage.getTotalPages()}页
								</span>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="text-right">
							<nav>
								<ul class="pagination pagination-md">
									<c:choose>
										<c:when test="${customerPage.pageNo <= 1}">
											<li class="disabled"><a aria-label="<<"><<</a></li>
											<li class="disabled"><a aria-label="<"><</a></li>
										</c:when>
										<c:otherwise>
											<li><a href="?pageNo=1" aria-label="<<"><<</a></li>
											<li><a href="?pageNo=${customerPage.pageNo-1}"
												aria-label="<"><</a></li>
										</c:otherwise>
									</c:choose>
									<c:forEach begin="1" end="${customerPage.getTotalPages()}"
										var="pageNo">
										<c:if test="${customerPage.pageNo != pageNo}">
											<li><a href="?pageNo=${pageNo}">${pageNo}</a></li>
										</c:if>
										<c:if test="${customerPage.pageNo == pageNo}">
											<li class="active"><a>${pageNo}</a></li>
										</c:if>
									</c:forEach>
									<c:choose>
										<c:when
											test="${customerPage.pageNo >= customerPage.getTotalPages()}">
											<li class="disabled"><a aria-label=">">></a></li>
											<li class="disabled"><a aria-label=">>">>></a></li>
										</c:when>
										<c:otherwise>
											<li><a href="?pageNo=${customerPage.pageNo+1}"
												aria-label=">">></a></li>
											<li><a href="?pageNo=${customerPage.getTotalPages()}"
												aria-label=">>">>></a></li>
										</c:otherwise>
									</c:choose>
								</ul>
							</nav>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${customerPage.list.size() == 0}">
				<div class="panel-footer">
					<div class="text-center">无记录</div>
				</div>
			</c:if>
		</div>


		<div class="row footer"></div>
		<script type="text/javascript">
			var AREA_LIST = '${pageContext.request.contextPath}/area/list.action';
			var CUSTOMER_URL = '${pageContext.request.contextPath}/customer';
			var CREATE_CUSTOMER_URL = CUSTOMER_URL + '/create.action';
			var UPDATE_CUSTOMER_URL = CUSTOMER_URL + '/update.action';
			var SIGN_CUSTOMER_URL = CUSTOMER_URL + '/sign.action';
			var REMOVE_CUSTOMER_URL = CUSTOMER_URL + '/remove.action';
			var RETRIEVE_CUSTOMER_URL = CUSTOMER_URL + '/retrieve.action';
		</script>
		<script src="<%=basePath%>resources/js/jquery-1.12.4.min.js"></script>
		<script src="<%=basePath%>resources/js/bootstrap.min.js"></script>
		<script src="<%=basePath%>resources/js/bootstrapValidator.min.js"></script>
		<script src="<%=basePath%>resources/js/customer.js"></script>
</body>
</html>