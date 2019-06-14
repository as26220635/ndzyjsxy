<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    //查询额外参数
    function searchParams(param) {
        param.BDMP_ID = '${EXTRA.BDMP_ID}';
    }
</script>
<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    /**
     * 选择班级
     */
    function distributionClass() {
        var data = getRowData(this);
        var param = {
            BDMP_ID: '${EXTRA.BDMP_ID}',
            TITLE: '辅导员:${EXTRA.BDMP_NAME}',
        };
        //切换主界面
        loadUrl('${BASE_URL}${fns:getUrlByMenuCode("INFO:DEPARTMENT_INSTRUCTOR_CLASS")}' + urlEncode(param));
    }

    /**
     * 删除班级
     */
    function del() {
        var datas = getDataGridSelected();
        if (isNotNullAndTips(datas, '${Tips.SELECT_NOT}')) {
            return;
        }
        var ids = '';
        var names = '';
        for (var i = 0; i < datas.length; i++) {
            var data = datas[i];
            if (i > 0) {
                ids += SERVICE_SPLIT;
                names += SERVICE_SPLIT;
            }
            ids += data.ID;
            names += data.BC_NAME;
        }
        var params = {
            IDS: ids,
        };

        model.show({
            title: '删除分配班级',
            content: '是否删除分配班级:' + names,
            class: model.class.DANGER,
            okBtnName: model.btnName.DEL,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.del('${BASE_URL}${Url.DEPARTMENT_INSTRUCTOR_CLASS_DELETE}', params, function (data) {
                    ajaxReturn.data(data, $model, $dataGrid, false);
                });
            }
        });
    }
</script>