<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>

    //详细记录
    $dataGridTable.find('tbody').on('click', '#detailLog', function () {
        var data = getRowData(this);
        var param = {
            TITLE: "ID:" + data.SVR_TABLE + ",表名:" + data.SVR_TABLE_NAME,
            SVR_TABLE_ID: data.ID,
        };
        //切换主界面
        loadUrl('${BASE_URL}${fns:getUrlByMenuCode("LOG:VALUE_RECORD_DETAIL")}' + urlEncode(param));
    });

</script>