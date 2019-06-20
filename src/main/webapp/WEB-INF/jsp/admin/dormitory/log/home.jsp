<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    //查询额外参数
    function searchParams(param) {
        param.BDF_ID = '${EXTRA.BDF_ID}';
        param.BDR_ID = '${EXTRA.BDR_ID}';
        param.BDB_ID = '${EXTRA.BDB_ID}';
    }
</script>
<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    <c:if test="${!(not empty EXTRA.BDF_ID or not empty EXTRA.BDR_ID or not empty EXTRA.BDB_ID)}">
    $('#return').remove();
    </c:if>
</script>