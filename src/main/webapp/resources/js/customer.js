var DEFAULT_TITLE = '收件人信息管理';
function createConfirmDialog() {
    // $('#confirmDialog').modal('show');
    var $modal = $('<div class="modal fade bootstrap-confirm" tabindex="-1" role="dialog" aria-hidden="true"></div>');
    var $modaldialog = $('<div class="modal-dialog" role="document"></div>');
    var $modalcontent = $('<div class="modal-content"></div>');
    var $modalheader = $('<div class="modal-header"><h5 class="modal-title"></h5></div>');
    var $modalbody = $('<div class="modal-body"></div>');
    var $modalfooter = $('<div class="modal-footer"></div>');
    var $cancelbtn = $('<button type="button" class="btn btn-secondary cancel" data-dismiss="modal">关闭</button>');
    var $confirmbtn = $('<button type="button" class="btn btn-primary confirm">确定</button>');

    $modaldialog.appendTo($modal);
    $modalcontent.appendTo($modaldialog);
    $modalheader.appendTo($modalcontent);
    $modalbody.appendTo($modalcontent);
    $modalfooter.appendTo($modalcontent);
    $cancelbtn.appendTo($modalfooter);
    $confirmbtn.appendTo($modalfooter);
    $modal.appendTo('body');

    return $modal;
}

function showConfirmDialog(title, message, data, confirmCallback, cancelCallback) {
    var $confirm = $('div.bootstrap-confirm');
    if ($confirm.length == 0) {
        $confirm = createConfirmDialog();
    }
    $confirm.find('h5.modal-title').text(title);
    $confirm.find('div.modal-body').text(message);
    if (confirmCallback != null) {
        $confirm.find('button.confirm').click(function() {
            confirmCallback(data);
        });
    }
    if (cancelCallback != null) {
        $confirm.find('button.cancel').click(function() {
            cancelCallback();
        });
    }
    $confirm.modal('show');
    return $confirm;
}
function batchRemoveCustomer() {
    var ids = new Array();
    var $tbr = $('table tbody tr');
    $tbr.find('input:checked').each(function() {
        ids.push($(this).attr('id'));
    });
    removeCustomer(ids);
}
function removeCustomer(ids){
	$.post(REMOVE_CUSTOMER_URL, {
        "ids[]": ids
    },
    function() {
        document.location.reload();
    })
}
function initSearchForm() {
}
function initTable() {
    var $thr = $('table thead tr');

    var $checkAll = $thr.find('input');
    $checkAll.click(function(event) {
        /* 将所有行的选中状态设成全选框的选中状态 */
        $tbr.find('input').prop('checked', $(this).prop('checked'));
        /* 并调整所有选中行的CSS样式 */
        if ($(this).prop('checked')) {
            $tbr.find('input').parent().parent().addClass('warning');
            tableToolbarControl($tbr.find('input:checked').length);
        } else {
            $tbr.find('input').parent().parent().removeClass('warning');
            tableToolbarControl($tbr.find('input:checked').length);
        }
        /* 阻止向上冒泡，以防再次触发点击操作 */
        event.stopPropagation();
    });
    $checkAll.parent().click(function() {
        $(this).find('input').click();
    });

    var $tbr = $('table tbody tr');
    $tbr.find('input').click(function(event) {
        /* 调整选中行的CSS样式 */
        $(this).parent().parent().toggleClass('warning');
        /* 如果已经被选中行的行数等于表格的数据行数，将全选框设为选中状态，否则设为未选中状态 */
        $checkAll.prop('checked', $tbr.find('input:checked').length == $tbr.length ? true: false);
        tableToolbarControl($tbr.find('input:checked').length);
        /* 阻止向上冒泡，以防再次触发点击操作 */
        event.stopPropagation();
    });
    /* 点击每一行时也触发该行的选中操作 */
    $tbr.click(function() {
        $(this).find('input').click();
    });
}
function initCustomerDialog() {
	var $customerDialog = $('#customerDialog');
	var $form = $('#customerForm');
	var $datepicker = $form.find('.input-group.date');
	var $phoneNumber = $form.find('input[name="phoneNumber"]');
	var $name = $form.find('input[name="name"]');
	var $area = $form.find('select[name="area"]');
	var $status = $form.find('input[name="status"]');
    $customerDialog.on('hidden.bs.modal',
    function() {
        location.reload();
        // $('#customerForm').bootstrapValidator('resetForm', true);
    });
    $customerDialog.on('shown.bs.modal',
    function() {
        var id = $('#customerForm input[name="id"]').val();
        if (id) {
            $.post(RETRIEVE_CUSTOMER_URL, {
                'id': id
            },
            function(data) {
            	$name.val(data.name);
                $phoneNumber.val(data.phoneNumber);
                $area.val(data.area.code);
            });
        }

    });
    
    var $customerForm = $('#customerForm');

    $phoneNumber.on('change paste keyup', function(e) {
    	$customerForm.bootstrapValidator('updateStatus', 'phoneNumber', 'NOT_VALIDATED').bootstrapValidator('validateField', 'phoneNumber');
    });
    
    $customerForm.bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            phoneNumber: {
                validators: {
                    notEmpty: {
                        message: '手机号码不能为空'
                    },
                    regexp: {
                        regexp: /^\d{11}$/,
                        message: '无效的手机号码'
                    }
                }
            },
            area: {
                validators: {
                    notEmpty: {
                        message: '地址不能为空'
                    }
                }
            },
            name: {
                validators: {
                    notEmpty: {
                        message: '姓名不能为空'
                    }
                }
            }
        }
    });

    $area = $('select.area');
    $.ajax({
        type: "POST",
        url: AREA_LIST,
        data: {},
        success: function(data) {
            for (i in data) {
                var area = data[i];
                $area.append('<option value="' + area.code + '">' + area.name + '</option>');
            }
        }
    });
}
function showCustomerDialog(id) {
	var $form = $('#customerForm');
	if(id){
		$form.attr('action', UPDATE_CUSTOMER_URL);
	}else{
		$form.attr('action', CREATE_CUSTOMER_URL);
	}
    $('#customerForm input[name="id"]').val(id);
    $('#customerDialog').modal('show');
}
function createUpdateCustomer() {
    var $form = $('#customerForm');
    var action = $form.find('input[name="id"]').val()==''?'create':'update';
    var bv = $form.data('bootstrapValidator');
    bv.validate();
    if (bv.isValid()) {
    	$.ajax({
    		type:'POST',
    		url:$form.attr('action'),
    		data:$form.serialize(),
    		success:function(result, status, xhr){
    			if ('success' == result) {
    				if(action=='create'){
    					$('#customerDialog div.alert').attr('class','alert alert-success').text('添加成功').fadeIn();
                        $('#customerForm').bootstrapValidator('resetForm', true);
    				}else{
    					$('#customerDialog').modal('hide');
    				}
                } else {
                	$('#customerDialog div.alert').attr('class','alert alert-danger').text(result).fadeIn();
                }
    		},
    		error:function(){
    			$('#customerDialog div.alert').attr('class','alert alert-danger').text('与服务器连接发生错误').fadeIn();
    		}
    	});
    }
}
function tableToolbarControl(checkedCount) {
	$("#batchRemove").prop('disabled', (checkedCount == 0));
	$("#batchSign").prop('disabled', (checkedCount == 0));
}
$(document).ready(function() {
    initSearchForm();
    initTable();
    initCustomerDialog();
});