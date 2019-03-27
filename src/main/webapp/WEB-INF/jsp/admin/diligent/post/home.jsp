<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    //查询额外参数
    function searchParams(param) {
        param.BDS_ID = '${EXTRA.BDS_ID}';
    }
</script>

<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    <c:if test="${empty EXTRA.BDS_ID}">
    $('#return,#addBtn').remove();
    </c:if>

    //添加
    $('#addBtn').on('click', function () {
        var BDS_ID = '${EXTRA.BDS_ID}';
        if (isEmpty(BDS_ID)) {
            demo.showNotify(ALERT_WARNING, '请从勤工助学页面添加岗位!');
            return;
        }
        var data = {
            ID: BDS_ID,
            BUS_PROCESS: '${EXTRA.BUS_PROCESS}',
            BUS_PROCESS2: '${EXTRA.BUS_PROCESS2}',
        };
        ajax.getHtml('${BASE_URL}${Url.DILIGENT_STUDY_POST_ADD_URL}', {BDS_ID: BDS_ID}, function (html) {
                model.show({
                    title: '添加勤工助学岗位',
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

                        ajax.post('${BASE_URL}${Url.DILIGENT_STUDY_POST_ADD_URL}', params, function (data) {
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
        data.ID = data.BDS_ID;

        ajax.getHtml('${BASE_URL}${Url.DILIGENT_STUDY_POST_UPDATE_URL}/' + id, {}, function (html) {
                model.show({
                    title: '修改勤工助学岗位',
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                    <shiro:hasPermission name="DILIGENT:STUDY_POST_UPDATE_SAVE">
                    isConfirm: isProcessSubmit(data),
                    confirm: function ($model) {
                        var $form = $('#addAndEditForm');
                        //验证
                        if (!validator.formValidate($form)) {
                            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                            return;
                        }
                        var params = packFormParams($form);

                        ajax.put('${BASE_URL}${Url.DILIGENT_STUDY_POST_UPDATE_URL}', params, function (data) {
                            ajaxReturn.data(data, $model, $dataGrid, false);
                        });
                    }
                    </shiro:hasPermission>
                });
            }
        );
    });


    //设置学生
    $dataGridTable.find('tbody').on('click', '#setStudent', function () {
        var data = getRowData(this);
        var param = {
            TITLE: data.BDSP_NAME + ',编号:' + data.BDSP_NUMBER,
            BDSP_ID: data.ID,
            BDS_ID: data.BDS_ID,
            BUS_PROCESS: data.BUS_PROCESS,
            BUS_PROCESS2: data.BUS_PROCESS2,
        };
        //切换主界面
        loadUrl('${BASE_URL}${fns:getUrlByMenuCode("DILIGENT:STUDY_STUDENT")}' + urlEncode(param));
    });

    //删除
    $dataGridTable.find('tbody').on('click', '#del', function () {
        var data = getRowData(this);
        var id = data.ID;

        model.show({
            title: '删除勤工助学岗位',
            content: '是否删除勤工助学岗位,名称' + data.BDSP_NAME,
            class: model.class.DANGER,
            okBtnName: model.btnName.DEL,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.del('${BASE_URL}${Url.DILIGENT_STUDY_POST_DELETE_URL}/' + id, {}, function (data) {
                    ajaxReturn.data(data, $model, $dataGrid, false);
                })
            }
        });
    });
</script>