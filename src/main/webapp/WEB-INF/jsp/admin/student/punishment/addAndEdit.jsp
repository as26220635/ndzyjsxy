<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2018/3/27
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form id="addAndEditForm" class="row">
    <input type="hidden" name="${SUBMIT_TOKEN_NAME}" value="${token}">
    <input type="hidden" name="ID" value="${punishment.ID}">
    <input type="hidden" name="insertId" value="${insertId}">
    <div class="form-group has-feedback">
        <label>学生:</label>
        <input type="hidden" ${fns:validField("BUS_STUDENT_PUNISHMENT", "BS_ID")} value="${punishment.BS_ID}">
        <input type="text" class="form-control" ${fns:validField("BUS_STUDENT_PUNISHMENT", "BS_NAME")}
               value="${punishment.BS_NAME}">
    </div>
    <div class="form-group has-feedback">
        <label>标题:</label>
        <input type="text" class="form-control" ${fns:validField("BUS_STUDENT_PUNISHMENT", "BSP_TITLE")}
               value="${punishment.BSP_TITLE}">
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>文件号:</label>
            <input type="text" class="form-control" ${fns:validField("BUS_STUDENT_PUNISHMENT", "BSP_FILE_NUMBER")}
                   value="${punishment.BSP_FILE_NUMBER}">
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>发布时间:</label>
            <s:datebox custom='${fns:validField("BUS_STUDENT_PUNISHMENT", "BSP_RELEASE_TIME")}'
                       value="${punishment.BSP_RELEASE_TIME}" type="3"></s:datebox>
        </div>
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>处分类型:</label>
            <s:combobox sdtCode="BUS_PUNISHMENT" custom='${fns:validField("BUS_STUDENT_PUNISHMENT","BSP_TYPE")}'
                        value="${punishment.BSP_TYPE}"></s:combobox>
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>撤销时间:</label>
            <s:datebox custom='${fns:validField("BUS_STUDENT_PUNISHMENT", "BSP_REVOKE_TIME")}'
                       value="${punishment.BSP_REVOKE_TIME}" type="3"></s:datebox>
        </div>
    </div>
    <div class="form-group has-feedback">
        <label>描述:</label>
        <textarea ${fns:validField("BUS_STUDENT_PUNISHMENT","BSP_DESCRIBE")}
                class="form-control form-textarea"
                rows="3">${punishment.BSP_DESCRIBE}</textarea>
    </div>
    <c:if test="${not empty punishment}">
        <div class="row">
            <div class="form-group has-feedback form-group-md-6">
                <label>是否作废:</label>
                <s:combobox sdtCode="SYS_YES_NO" value="${punishment.BSP_IS_CANCEL}"></s:combobox>
            </div>
            <div class="form-group has-feedback form-group-md-6">
                <label>作废时间:</label>
                <input type="text" class="form-control" value="${punishment.BSP_CANCEL_TIME}">
            </div>
        </div>
    </c:if>
    <%--附件--%>
    <div class="row">
        <s:fileInput title="附件" sdtCode="BUS_FILE_DEFAULT" tableId="${not empty punishment ? punishment.ID: insertId}"
                     tableName="${TableName.BUS_STUDENT_PUNISHMENT}" typeCode="punishment"
                     allowFile="true"></s:fileInput>
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
    //选择学生
    choiceBox.student({
        id: 'BS_ID',
        name: 'BS_NAME',
        url: '${STUDENT_LIST_URL}'
    });
</script>