<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    //添加
    $('#addBtn').on('click', function () {
        ajax.getHtml('${TEACHER_ADD_URL}', {}, function (html) {
                model.show({
                    title: '添加教师',
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

                        ajax.post('${TEACHER_ADD_URL}', params, function (data) {
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

        ajax.getHtml('${TEACHER_UPDATE_URL}/' + id, {}, function (html) {
                model.show({
                    title: '修改教师',
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                    <shiro:hasPermission name="INFO:TEACHER_UPDATE_SAVE">
                    isConfirm: true,
                    confirm: function ($model) {
                        var $form = $('#addAndEditForm');
                        //验证
                        if (!validator.formValidate($form)) {
                            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                            return;
                        }
                        var params = packFormParams($form);

                        ajax.put('${TEACHER_UPDATE_URL}', params, function (data) {
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

        ajax.getHtml('${TEACHER_ADDOUNT_INFO_URL}/' + SO_ID, {}, function (html) {
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

                        ajax.put('${TEACHER_ADDOUNT_INFO_URL}', params, function (data) {
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
            SAI_NAME: data.BT_NAME,
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
            url: '${OPERATOR_TREE_ROLE_DATA_URL}',
            searchParams: {
                ID: id,
                SR_TYPE: '${SystemEnum.TEACHER.toString()}',
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

                ajax.put('${OPERATOR_TREE_ROLE_DATA_UPDATE_URL}', params, function (data) {
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
            title: '重置密码',
            content: '是否重置教师人员:' + data.BT_NAME + '的密码',
            class: model.class.WARNING,
            okBtnName: model.btnName.RESET,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.put('${TEACHER_RESET_PWD_URL}', {ID: id}, function (data) {
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
            title: '删除教师',
            content: '是否删除教师:' + data.BT_NAME,
            class: model.class.DANGER,
            okBtnName: model.btnName.DEL,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.del('${TEACHER_DELETE_URL}/' + id, {}, function (data) {
                    ajaxReturn.data(data, $model, $dataGrid, false);
                })
            }
        });
    });
</script>