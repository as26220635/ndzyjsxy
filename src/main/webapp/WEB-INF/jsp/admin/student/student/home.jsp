<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    //添加
    $('#addBtn').on('click', function () {
        ajax.getHtml('${BASE_URL}${Url.STUDENT_ADD_URL}', {}, function (html) {
                model.show({
                    title: '添加学生',
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

                        ajax.post('${BASE_URL}${Url.STUDENT_ADD_URL}', params, function (data) {
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

        ajax.getHtml('${BASE_URL}${Url.STUDENT_UPDATE_URL}/' + id, {}, function (html) {
                model.show({
                    title: '修改学生',
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                    <shiro:hasPermission name="STUDENT:BASE_UPDATE_SAVE">
                    isConfirm: true,
                    confirm: function ($model) {
                        var $form = $('#addAndEditForm');
                        //验证
                        if (!validator.formValidate($form)) {
                            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                            return;
                        }
                        var params = packFormParams($form);

                        ajax.put('${BASE_URL}${Url.STUDENT_UPDATE_URL}', params, function (data) {
                            ajaxReturn.data(data, $model, $dataGrid, false);
                        });
                    }
                    </shiro:hasPermission>
                });
            }
        );
    });

    //账号信息
    $dataGridTable.find('tbody').on('click', '#accountInfo', function () {
        var data = getRowData(this);
        var SO_ID = data.SO_ID;

        ajax.getHtml('${BASE_URL}${Url.STUDENT_ADDOUNT_INFO_URL}/' + SO_ID, {}, function (html) {
                model.show({
                    title: '账号信息',
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

                        ajax.put('${BASE_URL}${Url.STUDENT_ADDOUNT_INFO_URL}', params, function (data) {
                            ajaxReturn.data(data, $model, $dataGrid, false);
                        });
                    }
                });
            }
        );
    });

    //设置账号
    $dataGridTable.find('tbody').on('click', '#setSub', function () {
        var data = getRowData(this);
        var param = {
            SO_ID: data.SO_ID,
            SAI_NAME: data.BS_NAME,
        };
        //切换主界面
        loadUrl('${BASE_URL}${fns:getUrlByMenuCode("SYSTEM:OPERATOR_SUB")}' + urlEncode(param));
    });


    //设置角色
    $dataGridTable.find('tbody').on('click', '#setRole', function () {
        var data = getRowData(this);
        var id = data.SO_ID;

        treeBox.init({
            title: '选择角色',
            url:'${BASE_URL}${Url.OPERATOR_TREE_ROLE_DATA_URL}',
            searchParams: {
                ID: id,
                SR_TYPE: '${SystemEnum.STUDENT.toString()}',
            },
            isConfirm: true,
            confirm: function ($model, nodes) {
                var roleIds = "";
                for (var i = 0; i < nodes.length; i++) {
                    roleIds += (nodes[i].id + SERVICE_SPLIT);
                }
                var params = {};
                params.ID = id;
                params.ROLEIDS = roleIds;

                ajax.put('${BASE_URL}${Url.OPERATOR_TREE_ROLE_DATA_UPDATE_URL}', params, function (data) {
                    ajaxReturn.data(data, $model, null, null);
                })
            }
        });
    });

    //重置密码
    $dataGridTable.find('tbody').on('click', '#resetPassword', function () {
        var data = getRowData(this);
        var id = data.SO_ID;

        model.show({
            title: '重置密码(' + data.BS_NAME + ')',
            content: model.content.RESET_PASSWORD,
            okBtnName: model.btnName.RESET,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            isPassword: true,
            confirm: function ($model, password) {
                ajax.put('${BASE_URL}${Url.STUDENT_RESET_PWD_URL}', {ID: id, PASSWORD: password}, function (data) {
                    ajaxReturn.data(data, $model, null, null);
                });
            }
        });
    });

    //删除
    $dataGridTable.find('tbody').on('click', '#del', function () {
        var data = getRowData(this);
        var id = data.ID;

        model.show({
            title: '删除学生',
            content: '是否删除学生:' + data.BS_NAME,
            class: model.class.DANGER,
            okBtnName: model.btnName.DEL,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.del('${BASE_URL}${Url.STUDENT_DELETE_URL}/' + id, {}, function (data) {
                    ajaxReturn.data(data, $model, $dataGrid, false);
                })
            }
        });
    });

    /**
     * 导入excel
     */
    function excelImport($form, $model, importBtnId) {
        //导入查询
        if (importBtnId == 'importQuery') {
           ajax.file('${BASE_URL}${Url.STUDENT_IMPORT_QUERY_URL}', $form, function (data) {
                //重置上传框
                importFileClear();
                //下载缓存文件
                ajaxReturn.data(data, $model, null, null, {
                    success: function () {
                        window.location.href = '${BASE_URL}${Url.DOWN_CACHE_URL}' + data.id;
                        <%--window.open('${DOWN_CACHE_URL}' + data.id);--%>
                    }
                });
            });
        }else{
            //导入信息
           ajax.file('${BASE_URL}${Url.STUDENT_IMPORT_URL}', $form, function (data) {
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
    }
</script>