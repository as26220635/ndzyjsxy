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
    <input type="hidden" name="ID" value="${study.ID}">
    <input type="hidden" name="BDS_TABLE_ID" value="${study.BDS_TABLE_ID}">
    <input type="hidden" name="BDS_TABLE_NAME" value="${study.BDS_TABLE_NAME}">
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>学年:</label>
            <s:datebox
                    custom='${fns:validField(TableName.BUS_DILIGENT_STUDY, "BDS_YEAR")}'
                    value="${study.BDS_YEAR}"></s:datebox>
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>学期:</label>
            <s:combobox sdtCode="BUS_SEMESTER"
                        custom='${fns:validField(TableName.BUS_DILIGENT_STUDY,"BDS_SEMESTER")}'
                        value="${study.BDS_SEMESTER}"></s:combobox>
        </div>
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