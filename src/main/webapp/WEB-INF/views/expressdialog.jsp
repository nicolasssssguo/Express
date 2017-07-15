<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal fade" id="expressDialog" tabindex="-1"
	role="dialog" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">快递信息</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="alert collapse" role="alert"></div>
				<form id="expressForm" role="form" action="" method="POST">
					<input type="hidden" name="id" />
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon">姓名</span> <input
								class="form-control" type="text" name="name" />
						</div>
					</div>

					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon">手机号码</span> <input
								class="form-control phoneNumber" type="text" name="phoneNumber" autocomplete="off"
								url="${pageContext.request.contextPath}/customer/searchbykeynum.action" />
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
							<span class="input-group-addon">到达日期</span> <input type="text"
								name="arriveDate" class="form-control"><span
								class="input-group-addon"><i
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
				<button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary"
					onclick="createUpdateExpress()">保存</button>
			</div>
		</div>
	</div>
</div>