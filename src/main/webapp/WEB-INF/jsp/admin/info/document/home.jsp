<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    //格式化按钮
    function dataGridButtonFormat(row, btnId, btnStr) {
        if (btnId == 'reply') {
            //如果可以回复和没有超时的话显示回复按钮
            console.log(row)
            if (row.BD_IS_NEED_REPLY == '是' && row.BD_IS_OVER_TIME == STATUS_ERROR) {
                return btnStr;
            }
        }else {
            return btnStr;
        }
        return '';
    }
</script>
<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    //添加
    $('#addBtn').on('click', function () {
        ajax.getHtml('${BASE_URL}${Url.DOCUMENT_ADD_URL}', {SC_ID: '${EXTRA.SC_ID}'}, function (html) {
                model.show({
                    title: '添加文件',
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

                        ajax.post('${BASE_URL}${Url.DOCUMENT_ADD_URL}', params, function (data) {
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
        ajax.getHtml('${BASE_URL}${Url.DOCUMENT_UPDATE_URL}/' + id, {}, function (html) {
                model.show({
                    title: '修改文件',
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                    <shiro:hasPermission name="INFO:DOCUMENT_UPDATE_SAVE">
                    isConfirm: true,
                    confirm: function ($model) {
                        var $form = $('#addAndEditForm');
                        //验证
                        if (!validator.formValidate($form)) {
                            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                            return;
                        }
                        var params = packFormParams($form);

                        ajax.put('${BASE_URL}${Url.DOCUMENT_UPDATE_URL}', params, function (data) {
                            ajaxReturn.data(data, $model, $dataGrid, false);
                        });
                    }
                    </shiro:hasPermission>
                });
            }
        );
    });

    //回复
    $dataGridTable.find('tbody').on('click', '#reply', function () {
        var data = getRowData(this);
        var id = data.ID;

        ajax.getHtml('${BASE_URL}${Url.DOCUMENT_REPLY_URL}/' + id, {}, function (html) {
                model.show({
                    title: '修改文件',
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

                        ajax.put('${BASE_URL}${Url.DOCUMENT_REPLY_URL}', params, function (data) {
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
            title: '删除文件',
            content: '是否删除文件:' + data.BD_TITLE,
            class: model.class.DANGER,
            okBtnName: model.btnName.DEL,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.del('${BASE_URL}${Url.DOCUMENT_DELETE_URL}/' + id, {}, function (data) {
                    ajaxReturn.data(data, $model, $dataGrid, false);
                })
            }
        });
    });
</script>