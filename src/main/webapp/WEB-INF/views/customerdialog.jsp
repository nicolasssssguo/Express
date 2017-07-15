<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal fade" id="customerDialog" tabindex="-1"
	role="dialog" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">客户信息</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="alert collapse" role="alert"></div>
				<form id="customerForm" role="form" action="" method="POST">
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
								url="${pageContext.request.contextPath}/customer/search" />
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon">地址</span> <select name="area"
								class="form-control area">
							</select>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary"
					onclick="createUpdateCustomer()">保存</button>
			</div>
		</div>
	</div>
</div>