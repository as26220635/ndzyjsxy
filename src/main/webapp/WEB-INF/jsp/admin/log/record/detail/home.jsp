<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    //查询额外参数
    function searchParams(param) {
        param.SVR_TABLE_ID = '${EXTRA.SVR_TABLE_ID}';
    }
</script>
<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    setTimeout(function () {
        setMenuActive('admin-dataGrid-${MENU.SM_PARENTID}');
    }, 50);

    //详细记录
    $dataGridTable.find('tbody').on('click', '#detailLog', function () {
        var data = getRowData(this);
        var id = data.ID;
        // var id = data.ID;
        ajax.getHtml('${BASE_URL}${Url.LOG_VALUE_RECORD_DETAIL_URL}', {
                ID: id,
            }, function (html) {
                model.show({
                    title: '字段变动详细',
                    tips: '点击蓝色修改行可以查看变动详细',
                    content: html,
                    size: model.size.LG,
                    footerModel: model.footerModel.ADMIN,
                });
            }
        );
    });

</script>