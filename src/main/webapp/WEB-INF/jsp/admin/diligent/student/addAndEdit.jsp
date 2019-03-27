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
    <input type="hidden" name="ID" value="${student.ID}">
    <input type="hidden" name="BDSP_ID" value="${fns:trueOrFalse(student != null ,student.BDSP_ID,BDSP_ID)}">
    <div class="form-group has-feedback">
        <label>学生:</label>
        <input type="hidden" ${fns:validField(TableName.BUS_DILIGENT_STUDY_STUDENT, "BS_ID")} value="${student.BS_ID}">
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_DILIGENT_STUDY_STUDENT, "BS_NAME")}
               value="${student.BS_NAME}">
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
        url:'${BASE_URL}${Url.STUDENT_LIST_URL}'
    });
</script>