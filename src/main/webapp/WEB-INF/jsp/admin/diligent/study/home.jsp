<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    //添加
    $('#addBtn').on('click', function () {
        ajax.getHtml('${DILIGENT_STUDY_ADD_URL}', {}, function (html) {
                model.show({
                    title: '添加勤工助学',
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

                        ajax.post('${DILIGENT_STUDY_ADD_URL}', params, function (data) {
                            ajaxReturn.data(data, $model, $dataGrid, true);
                        })
                    }
                });
            }
        );
    });

    //修改
    $dataGridTable.find('tbody').on('click', '#edit', function () {
        var row = this;
        var data = getRowData(this);
        var id = data.ID;

        ajax.getHtml('${DILIGENT_STUDY_UPDATE_URL}/' + id, {}, function (html) {
                model.show({
                    title: '修改勤工助学',
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                    <shiro:hasPermission name="DILIGENT:STUDY_UPDATE_SAVE">
                    isConfirm: isProcessSubmit(row),
                    confirm: function ($model) {
                        var $form = $('#addAndEditForm');
                        //验证
                        if (!validator.formValidate($form)) {
                            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                            return;
                        }
                        var params = packFormParams($form);

                        ajax.put('${DILIGENT_STUDY_UPDATE_URL}', params, function (data) {
                            ajaxReturn.data(data, $model, $dataGrid, false);
                        });
                    }
                    </shiro:hasPermission>
                });
            }
        );
    });

    //删除
    $dataGridTable.find('tbody').on('click', '#del', function () {
        var data = getRowData(this);
        var id = data.ID;

        model.show({
            title: '删除勤工助学',
            content: '是否删除勤工助学,部门' + data.TABLE_NAME,
            class: model.class.DANGER,
            okBtnName: model.btnName.DEL,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.del('${DILIGENT_STUDY_DELETE_URL}/' + id, {}, function (data) {
                    ajaxReturn.data(data, $model, $dataGrid, false);
                })
            }
        });
    });

    /**
     * 导入excel
     */
    function excelImport($form, $model) {
        ajax.file('${DILIGENT_STUDY_IMPORT_URL}', $form, function (data) {
            //重置上传框
            importFileClear();
            ajaxReturn.data(data, $model, $dataGrid, true, {
                error: function () {
                    //显示错误列表
                    showImportError(data.data)
                }
            });
        });
    }
</script>