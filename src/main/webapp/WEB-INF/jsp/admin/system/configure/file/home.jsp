<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    //查询额外参数
    function searchParams(param) {
        param.SC_ID = '${EXTRA.SC_ID}';
    }
</script>
<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    setTimeout(function () {
        setMenuActive('admin-dataGrid-${MENU.SM_PARENTID}');
        editMenuTitle('${EXTRA.SC_NAME}-' + getMenuTitle());
    }, 50);

    //添加
    $('#addBtn').on('click', function () {
        ajax.getHtml('${BASE_URL}${Url.CONFIGURE_FILE_ADD_URL}', {SC_ID: '${EXTRA.SC_ID}'}, function (html) {
                model.show({
                    title: '添加配置列表文件',
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

                       ajax.file('${BASE_URL}${Url.CONFIGURE_FILE_ADD_URL}', $form, function (data) {
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

        ajax.getHtml('${BASE_URL}${Url.CONFIGURE_FILE_UPDATE_URL}/' + id, {}, function (html) {
                model.show({
                    title: '修改配置列表文件',
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                    <shiro:hasPermission name="SYSTEM:CONFIGURE_SET_FILE_UPDATE_SAVE">
                    isConfirm: true,
                    confirm: function ($model) {
                        var $form = $('#addAndEditForm');
                        //验证
                        if (!validator.formValidate($form)) {
                            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                            return;
                        }

                       ajax.file('${BASE_URL}${Url.CONFIGURE_FILE_UPDATE_URL}', $form, function (data) {
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
            title: '删除配置列表文件',
            content: '是否删除配置列表文件:' + data.SCF_NAME,
            class: model.class.DANGER,
            okBtnName: model.btnName.DEL,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.del('${BASE_URL}${Url.CONFIGURE_FILE_DELETE_URL}/' + id, {}, function (data) {
                    ajaxReturn.data(data, $model, $dataGrid, false);
                })
            }
        });
    });

    //切换状态
    function onSwitchChange($this, field, check, IS_STATUS) {
        showLoadingContentDiv();
        ajax.put('${BASE_URL}${Url.CONFIGURE_FILE_SWITCH_STATUS_URL}', {ID: $this.val(), IS_STATUS: IS_STATUS}, function (data) {
            if (data.code == STATUS_SUCCESS) {
                demo.showNotify(ALERT_SUCCESS, '状态修改成功!');
            } else {
                $this.bootstrapSwitch('toggleState', true);
                demo.showNotify(ALERT_WARNING, '状态修改失败!');
            }
            removeLoadingDiv();
        });
    }
</script>