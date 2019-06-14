<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    //分配班级
    $dataGridTable.find('tbody').on('click', '#distributionClass', function () {
        var data = getRowData(this);
        var param = {
            BDMP_ID: data.ID,
            BDMP_NAME: data.BDMP_NAME,
            TITLE: '辅导员:'+data.BDMP_NAME,
        };
        //切换主界面
        loadUrl('${BASE_URL}${fns:getUrlByMenuCode("INFO:DEPARTMENT_INSTRUCTOR_DISTRIBUTION")}' + urlEncode(param));
    });
</script>