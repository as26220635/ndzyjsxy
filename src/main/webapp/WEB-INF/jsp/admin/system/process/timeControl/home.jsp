<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    //查询额外参数
    function searchParams(param) {
        param.SPD_ID = '${EXTRA.SPD_ID}';
    }
</script>

<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    //添加
    $('#addBtn').on('click', function () {
        ajax.getHtml('${BASE_URL}${Url.PROCESS_TIME_CONTROL_ADD_URL}', {SPD_ID: '${EXTRA.SPD_ID}'}, function (html) {
                model.show({
                    title: '添加流程时间控制',
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                    isConfirm: true,
                    confirm: function ($model) {
                        var $form = $('#addAndEditForm');
                        //流程时间控制
                        if (!validator.formValidate($form)) {
                            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                            return;
                        }

                        var params = packFormParams($form);

                        ajax.post('${BASE_URL}${Url.PROCESS_TIME_CONTROL_ADD_URL}', params, function (data) {
                            ajaxReturn.data(data, $model, $dataGrid, false);
                        })
                    }
                });
            }
        );
    });

    //修改
    $dataGridTable.find('tbody').on('click', '#edit', function () {
        var data = getRowData(this);
        var id = data.ID;

        ajax.getHtml('${BASE_URL}${Url.PROCESS_TIME_CONTROL_UPDATE_URL}/' + id, {}, function (html) {
                model.show({
                    title: '修改流程时间控制',
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                    isConfirm: true,
                    confirm: function ($model) {
                        var $form = $('#addAndEditForm');
                        //流程时间控制
                        if (!validator.formValidate($form)) {
                            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                            return;
                        }

                        var params = packFormParams($form);

                        ajax.put('${BASE_URL}${Url.PROCESS_TIME_CONTROL_UPDATE_URL}', params, function (data) {
                            ajaxReturn.data(data, $model, $dataGrid, false);
                        });
                    }
                });
            }
        );
    });

    //删除
    $dataGridTable.find('tbody').on('click', '#del', function () {
        var data = getRowData(this);
        var id = data.ID;

        model.show({
            title: '删除流程时间控制',
            content: '时间范围:' + data.SPDT_START_TIME + '-' + data.SPDT_END_TIME,
            class: model.class.DANGER,
            okBtnName: model.btnName.DEL,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.del('${BASE_URL}${Url.PROCESS_TIME_CONTROL_DELETE_URL}/' + id, {}, function (data) {
                    ajaxReturn.data(data, $model, $dataGrid, false);
                })
            }
        });
    });

    //切换状态
    function onSwitchChange($this, field, check, IS_STATUS) {
        showLoadingContentDiv();
        ajax.put('${BASE_URL}${Url.PROCESS_TIME_CONTROL_SWITCH_STATUS_URL}', {
            ID: $this.val(),
            IS_STATUS: IS_STATUS
        }, function (data) {
            if (data.code == STATUS_SUCCESS) {
                demo.showNotify(ALERT_SUCCESS, '状态修改成功!');
            } else {
                $this.bootstrapSwitch('toggleState', true);
                demo.showNotify(ALERT_WARNING, '状态修改失败!');
            }
            reload();
            removeLoadingDiv();
        });
    }
</script>