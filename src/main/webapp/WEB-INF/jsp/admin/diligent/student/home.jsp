<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    //查询额外参数
    function searchParams(param) {
        param.BDSP_ID = '${EXTRA.BDSP_ID}';
    }
</script>

<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    <c:choose>
    <c:when test="${empty EXTRA.BDSP_ID}">
    $('#return,#addBtn').remove();
    </c:when>
    <c:otherwise>
    $('#import').remove();
    </c:otherwise>
    </c:choose>

    //添加
    $('#addBtn').on('click', function () {
        var BDSP_ID = '${EXTRA.BDSP_ID}';
        if (isEmpty(BDSP_ID)) {
            demo.showNotify(ALERT_WARNING, '请从勤工助学页面添加学生!');
            return;
        }
        var data = {
            ID: '${EXTRA.BDS_ID}',
            BUS_PROCESS: '${EXTRA.BUS_PROCESS}',
            BUS_PROCESS2: '${EXTRA.BUS_PROCESS2}',
        };
        ajax.getHtml('${BASE_URL}${Url.DILIGENT_STUDY_STUDENT_ADD_URL}', {BDSP_ID: BDSP_ID}, function (html) {
                model.show({
                    title: '添加勤工助学学生',
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

                        ajax.post('${BASE_URL}${Url.DILIGENT_STUDY_STUDENT_ADD_URL}', params, function (data) {
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
        data.ID = data.BDSP_ID;

        ajax.getHtml('${BASE_URL}${Url.DILIGENT_STUDY_STUDENT_UPDATE_URL}/' + id, {}, function (html) {
                model.show({
                    title: '修改勤工助学学生',
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                    <shiro:hasPermission name="DILIGENT:STUDY_STUDENT_UPDATE_SAVE">
                    isConfirm: isProcessSubmit(data),
                    confirm: function ($model) {
                        var $form = $('#addAndEditForm');
                        //验证
                        if (!validator.formValidate($form)) {
                            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                            return;
                        }
                        var params = packFormParams($form);

                        ajax.put('${BASE_URL}${Url.DILIGENT_STUDY_STUDENT_UPDATE_URL}', params, function (data) {
                            ajaxReturn.data(data, $model, $dataGrid, false);
                        });
                    }
                    </shiro:hasPermission>
                });
            }
        );
    });

    //月工资
    $dataGridTable.find('tbody').on('click', '#monthWages', function () {
        var data = getRowData(this);
        var param = {
            TITLE: data.BS_NAME,
            BDSS_ID: data.ID,
            BDS_ID: data.BDS_ID,
            BUS_PROCESS: data.BUS_PROCESS,
            BUS_PROCESS2: data.BUS_PROCESS2,
        };
        //切换主界面
        loadUrl('${BASE_URL}${fns:getUrlByMenuCode("DILIGENT:STUDY_MONTH_WAGES")}' + urlEncode(param));
    });

    //删除
    $dataGridTable.find('tbody').on('click', '#del', function () {
        var data = getRowData(this);
        var id = data.ID;

        model.show({
            title: '删除勤工助学学生',
            content: '是否删除勤工助学学生,名称' + data.BDSP_NAME,
            class: model.class.DANGER,
            okBtnName: model.btnName.DEL,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.del('${BASE_URL}${Url.DILIGENT_STUDY_STUDENT_DELETE_URL}/' + id, {}, function (data) {
                    ajaxReturn.data(data, $model, $dataGrid, false);
                })
            }
        });
    });

    /**
     * 导入excel
     */
    function excelImport($form, $model) {
       ajax.file('${BASE_URL}${Url.DILIGENT_STUDY_STUDENT_IMPORT_URL}', $form, function (data) {
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