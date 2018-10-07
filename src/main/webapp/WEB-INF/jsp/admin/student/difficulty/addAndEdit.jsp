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
    <input type="hidden" name="ID" value="${difficulty.ID}">
    <div class="form-group has-feedback">
        <label>学生:</label>
        <input type="hidden" ${fns:validField(TableName.BUS_STUDENT_DIFFICULTY, "BS_ID")} value="${difficulty.BS_ID}">
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_STUDENT_DIFFICULTY, "BS_NAME")}
               value="${difficulty.BS_NAME}">
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>困难级别:</label>
            <s:combobox sdtCode="BUS_DIFFICULTY_TYPE" custom='${fns:validField(TableName.BUS_STUDENT_DIFFICULTY,"BSD_TYPE")}'
                        value="${difficulty.BSD_TYPE}"></s:combobox>
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>认定时间:</label>
            <s:datebox type="5" custom='${fns:validField(TableName.BUS_STUDENT_DIFFICULTY, "BSD_COGNIZANCE_TIME")}'
                       value="${difficulty.BSD_COGNIZANCE_TIME}"></s:datebox>
        </div>
    </div>
    <div class="form-group has-feedback">
        <label>认定原因:</label>
        <textarea ${fns:validField(TableName.BUS_STUDENT_DIFFICULTY,"BSD_COGNIZANCE_REASON")}
                class="form-control form-textarea"
                rows="2">${difficulty.BSD_COGNIZANCE_REASON}</textarea>
    </div>
    <div class="form-group has-feedback">
        <label>班级认定意见:</label>
        <textarea ${fns:validField(TableName.BUS_STUDENT_DIFFICULTY,"BSD_CLASS_REASON")}
                class="form-control form-textarea"
                rows="2">${difficulty.BSD_CLASS_REASON}</textarea>
    </div>
    <div class="form-group has-feedback">
        <label>年级认定意见:</label>
        <textarea ${fns:validField(TableName.BUS_STUDENT_DIFFICULTY,"BSD_GRADE_REASON")}
                class="form-control form-textarea"
                rows="2">${difficulty.BSD_GRADE_REASON}</textarea>
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