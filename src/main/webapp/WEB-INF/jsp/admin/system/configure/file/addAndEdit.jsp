<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2018/3/30
  Time: 0:26
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form id="addAndEditForm">
    <input type="hidden" name="${SUBMIT_TOKEN_NAME}" value="${token}">
    <input type="hidden" name="ID" value="${FILE.ID}">
    <input type="hidden" name="SC_ID" value="${fns:trueOrFalse(FILE != null ,FILE.SC_ID,SC_ID)}">
    <div class="form-group has-feedback">
        <label>文件名称:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.SYS_CONFIGURE_FILE,"SCF_NAME")}
               value="${FILE.SCF_NAME}">
    </div>
    <%--附件--%>
    <div class="row">
        <s:fileInput title="附件" sdtCode="BUS_FILE_DEFAULT"
                     tableId="${FILE.ID}"
                     tableName="${TableName.SYS_CONFIGURE_FILE}" typeCode="${TableName.SYS_CONFIGURE_FILE}"
                     allowFile="true"
                     showUpload="false"
                     showRemove="false"
                     multiple="false"
                     nonModel="true"
        ></s:fileInput>
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>