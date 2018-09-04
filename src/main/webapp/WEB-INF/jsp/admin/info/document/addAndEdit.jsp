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
    <input type="hidden" name="ID" value="${document.ID}">
    <input type="hidden" name="insertId" value="${insertId}">
    <div class="form-group has-feedback">
        <label>标题:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_DOCUMENT,"BD_TITLE")}
               value="${document.BD_TITLE}">
    </div>
    <div class="form-group has-feedback">
        <label>文件号:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_DOCUMENT,"BD_NUMBER")}
               value="${document.BD_NUMBER}">
    </div>
    <div class="form-group has-feedback">
        <label>发文类型:</label>
        <s:combobox sdtCode="BUS_DOCUMENT_TYPE" custom='${fns:validField(TableName.BUS_DOCUMENT,"BD_TYPE")}'
                    value="${document.BD_TYPE}"></s:combobox>
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>发文年度:</label>
            <s:datebox custom='${fns:validField(TableName.BUS_DOCUMENT, "BD_YEAR")}'
                       value="${document.BD_YEAR}" studentYear="false"></s:datebox>
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>发文日期:</label>
            <s:datebox custom='${fns:validField(TableName.BUS_DOCUMENT, "BD_DATE")}'
                       value="${document.BD_DATE}" type="3"></s:datebox>
        </div>
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>是否需要回复:</label>
            <s:combobox sdtCode="SYS_YES_NO" custom='${fns:validField(TableName.BUS_DOCUMENT,"BD_IS_NEED_REPLY")}'
                        value="${document.BD_IS_NEED_REPLY}"></s:combobox>
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>回复期限:</label>
            <s:datebox custom='${fns:validField(TableName.BUS_DOCUMENT, "BD_REPLY_TIME")}'
                       value="${document.BD_REPLY_TIME}" type="3"></s:datebox>
        </div>
    </div>
    <div class="form-group has-feedback">
        <label>备注:</label>
        <textarea ${fns:validField(TableName.BUS_DOCUMENT,"BD_REMARKS")}
                class="form-control form-textarea"
                rows="3">${document.BD_REMARKS}</textarea>
    </div>
    <%--附件--%>
    <div class="row">
        <s:fileInput title="附件" sdtCode="BUS_FILE_DEFAULT"
                         tableId="${not empty document ? document.ID: insertId}"
                     tableName="${TableName.BUS_DOCUMENT}" typeCode="${TableName.BUS_DOCUMENT}"
                     allowFile="true"
        ></s:fileInput>
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>