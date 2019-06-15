<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    appendTableTile('<span style="color:red;">(当前学期:${EXTRA.studnetYear}${EXTRA.semester})</span>');
</script>
<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    setTimeout(function () {
        setMenuActive('admin-dataGrid-${MENU.SM_PARENTID}');
    }, 50);
    /**
     * 保存选择
     */
    function save() {
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
            BDMP_ID: '${EXTRA.BDMP_ID}'
        };
        model.show({
            title: '分配班级',
            content: '是否分配班级:' + names,
            class: model.class.PRIMARY,
            okBtnName: model.btnName.SAVE,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.post('${BASE_URL}${Url.DEPARTMENT_INSTRUCTOR_CLASS_ADD_URL}', params, function (data) {
                    ajaxReturn.data(data, $model, $dataGrid, false, {
                        success: function () {
                            backHtml();
                        }
                    });
                });
            }
        });
    }
</script>