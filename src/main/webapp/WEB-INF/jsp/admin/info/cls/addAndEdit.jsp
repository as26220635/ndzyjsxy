<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2018/3/27
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form id="addAndEditForm">
    <input type="hidden" name="${SUBMIT_TOKEN_NAME}" value="${token}">
    <input type="hidden" name="ID" value="${cls.ID}">
    <div class="form-group has-feedback">
        <label>班级名称:</label>
        <input type="text" class="form-control" ${fns:validField("BUS_CLASS", "BC_NAME")}
               value="${cls.BC_NAME}">
    </div>
    <div class="form-group has-feedback">
        <label>所属系部:</label>
        <s:treeBox custom='${fns:validField("BUS_CLASS","BDM_ID")}'
                   value="${cls.BDM_ID}" nameValue="${cls.BDM_NAME}"
                   url="${BASE_URL}${Url.DEPARTMENT_TREE_DATA_URL}" title="选择系部"></s:treeBox>
    </div>
    <div class="form-group has-feedback">
        <label>专业:</label>
        <s:treeBox sdtCode="BUS_MAJOR" custom='${fns:validField("BUS_CLASS", "BC_MAJOR")}'
                   value="${cls.BC_MAJOR}" nameValue="${cls.BC_MAJOR_NAME}" title="选择专业"></s:treeBox>
    </div>
    <div class="form-group has-feedback">
        <label>年段:</label>
        <s:datebox custom='${fns:validField("BUS_CLASS", "BC_YEAR")}' value="${cls.BC_YEAR}" studentYear="false"></s:datebox>
    </div>
    <div class="form-group has-feedback">
        <label>学制:</label>
        <s:combobox sdtCode="BUS_COLLEGE_LENGTH" custom='${fns:validField(TableName.BUS_STUDENT,"BC_LENGTH")}'
                    value="${cls.BC_LENGTH}" defaultValue="3"></s:combobox>
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>