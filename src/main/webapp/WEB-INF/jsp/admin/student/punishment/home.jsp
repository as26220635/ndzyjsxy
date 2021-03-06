<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    //添加
    $('#addBtn').on('click', function () {
        ajax.getHtml('${BASE_URL}${Url.STUDENT_PUNISHMENT_ADD_URL}', {}, function (html) {
                model.show({
                    title: '添加学生处分',
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                    isConfirm: true,
                    confirm: function ($model) {
                        var $form = $('#addAndEditForm');
                        //验证
                        if (!validator.formValidate($form)) {
                            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                            return;
                        }
                        var params = packFormParams($form);

                        ajax.post('${BASE_URL}${Url.STUDENT_PUNISHMENT_ADD_URL}', params, function (data) {
                            ajaxReturn.data(data, $model, $dataGrid, true);
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

        ajax.getHtml('${BASE_URL}${Url.STUDENT_PUNISHMENT_UPDATE_URL}/' + id, {}, function (html) {
                model.show({
                    title: '修改学生处分',
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                    <shiro:hasPermission name="STUDENT:PUNISHMENT_UPDATE_SAVE">
                    isConfirm: data.BSP_IS_CANCEL == '是' ? false : true,
                    confirm: function ($model) {
                        var $form = $('#addAndEditForm');
                        //验证
                        if (!validator.formValidate($form)) {
                            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                            return;
                        }
                        var params = packFormParams($form);

                        ajax.put('${BASE_URL}${Url.STUDENT_PUNISHMENT_UPDATE_URL}', params, function (data) {
                            ajaxReturn.data(data, $model, $dataGrid, false);
                        });
                    }
                    </shiro:hasPermission>
                });
            }
        );
    });

    //撤销
    $dataGridTable.find('tbody').on('click', '#revoke', function () {
        var data = getRowData(this);
        var id = data.ID;
        if (data.BSP_IS_CANCEL == '是') {
            demo.showNotify(ALERT_WARNING, '已经撤销!');
            return;
        }
        model.show({
            title: '撤销学生处分',
            content: '是否撤销学生处分:' + data.BS_NAME + ',撤销后不能编辑!',
            class: model.class.WARNING,
            okBtnName: model.btnName.OK,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.put('${BASE_URL}${Url.STUDENT_PUNISHMENT_REVOKE_URL}/' + id, {}, function (data) {
                    ajaxReturn.data(data, $model, $dataGrid, false);
                })
            }
        });
    });

    //删除
    $dataGridTable.find('tbody').on('click', '#del', function () {
        var data = getRowData(this);
        var id = data.ID;

        model.show({
            title: '删除学生处分',
            content: '是否删除学生处分:' + data.BS_NAME,
            class: model.class.DANGER,
            okBtnName: model.btnName.DEL,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.del('${BASE_URL}${Url.STUDENT_PUNISHMENT_DELETE_URL}/' + id, {}, function (data) {
                    ajaxReturn.data(data, $model, $dataGrid, false);
                })
            }
        });
    });
</script>