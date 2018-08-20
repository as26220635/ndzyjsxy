<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>

    //详细记录
    $dataGridTable.find('tbody').on('click', '#detailLog', function () {
        var data = getRowData(this);
        var id = data.ID;
        var SVR_TABLE = data.SVR_TABLE;
        var SVR_TABLE_NAME = data.SVR_TABLE_NAME;

        //切换主界面
        loadUrl('${BASE_URL}${fns:getUrlByMenuCode("LOG:VALUE_RECORD_DETAIL")}&SVR_TABLE_ID=' + id + '&TITLE=' + encodeURIComponent("ID:" + SVR_TABLE + ",表名:" + SVR_TABLE_NAME));
    });

</script>