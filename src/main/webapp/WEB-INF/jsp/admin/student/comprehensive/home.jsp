<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    //添加
    $('#addBtn').on('click', function () {
        var data = getRowData(this);
        loadUrl('${BASE_URL}${fns:getUrlByMenuCode("STUDENT:COMPREHENSIVE_INSERT_AND_UPDATE")}');
    });

    //修改
    $dataGridTable.find('tbody').on('click', '#edit', function () {
        var data = getRowData(this);
        var id = data.ID;
        var BS_NAME = data.BS_NAME;
        loadUrl('${BASE_URL}${fns:getUrlByMenuCode("STUDENT:COMPREHENSIVE_INSERT_AND_UPDATE")}&ID=' + id + '&BS_NAME=' + encodeURIComponent(BS_NAME));
    });

    //删除
    $dataGridTable.find('tbody').on('click', '#del', function () {
        var data = getRowData(this);
        var id = data.ID;

        model.show({
            title: '删除学生综合素质测评',
            content: '是否删除学生综合素质测评:' + data.BS_NAME + ",学年:" + data.BSC_YEAR + ",学期:" + data.BSC_SEMESTER,
            class: model.class.DANGER,
            okBtnName: model.btnName.DEL,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.del('${STUDENT_COMPREHENSIVE_DELETE_URL}/' + id, {}, function (data) {
                    ajaxReturn.data(data, $model, $dataGrid, false);
                })
            }
        });
    });
</script>