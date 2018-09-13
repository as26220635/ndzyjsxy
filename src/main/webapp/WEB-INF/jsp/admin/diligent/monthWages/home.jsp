<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    //查询额外参数
    function searchParams(param) {
        param.BDSS_ID = '${EXTRA.BDSS_ID}';
    }
</script>

<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    <c:choose>
    <c:when test="${empty EXTRA.BDSS_ID}">
    $('#return,#addBtn').remove();
    </c:when>
    <c:otherwise>
    $('#import').remove();
    </c:otherwise>
    </c:choose>

    //添加
    $('#addBtn').on('click', function () {
        var BDSS_ID = '${EXTRA.BDSS_ID}';
        if (isEmpty(BDSS_ID)) {
            demo.showNotify(ALERT_WARNING, '请从勤工助学页面添加月工资!');
            return;
        }
        var data = {
            ID: '${EXTRA.BDS_ID}',
            BUS_PROCESS: '${EXTRA.BUS_PROCESS}',
            BUS_PROCESS2: '${EXTRA.BUS_PROCESS2}',
        };
        ajax.getHtml('${DILIGENT_STUDY_MONTH_WAGES_ADD_URL}', {BDSS_ID: BDSS_ID}, function (html) {
                model.show({
                    title: '添加勤工助学月工资',
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                    isConfirm: isProcessSubmit(data),
                    confirm: function ($model) {
                        var $form = $('#addAndEditForm');
                        //验证
                        if (!validator.formValidate($form)) {
                            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                            return;
                        }
                        var params = packFormParams($form);

                        ajax.post('${DILIGENT_STUDY_MONTH_WAGES_ADD_URL}', params, function (data) {
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

        ajax.getHtml('${DILIGENT_STUDY_MONTH_WAGES_UPDATE_URL}/' + id, {}, function (html) {
                model.show({
                    title: '修改勤工助学月工资',
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                    <shiro:hasPermission name="DILIGENT:STUDY_MONTH_WAGES_UPDATE_SAVE">
                    isConfirm: isProcessSubmit(data),
                    confirm: function ($model) {
                        var $form = $('#addAndEditForm');
                        //验证
                        if (!validator.formValidate($form)) {
                            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                            return;
                        }
                        var params = packFormParams($form);

                        ajax.put('${DILIGENT_STUDY_MONTH_WAGES_UPDATE_URL}', params, function (data) {
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
            title: '删除勤工助学月工资',
            content: '是否删除勤工助学月工资,名称' + data.BDSP_NAME,
            class: model.class.DANGER,
            okBtnName: model.btnName.DEL,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.del('${DILIGENT_STUDY_MONTH_WAGES_DELETE_URL}/' + id, {}, function (data) {
                    ajaxReturn.data(data, $model, $dataGrid, false);
                })
            }
        });
    });

    /**
     * 导入excel
     */
    function excelImport($form, $model) {
        ajax.file('${DILIGENT_STUDY_MONTH_WAGES_IMPORT_URL}', $form, function (data) {
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