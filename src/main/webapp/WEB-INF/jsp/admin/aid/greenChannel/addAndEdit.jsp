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
    <input type="hidden" name="ID" value="${aid.ID}">
    <input type="hidden" name="BUS_PROCESS" value="${BUS_PROCESS}">
    <input type="hidden" name="BUS_PROCESS2" value="${BUS_PROCESS2}">
    <div class="form-group has-feedback">
        <label>学生:</label>
        <input type="hidden" ${fns:validField(TableName.BUS_AID_FINANCIALLY, "BS_ID")} value="${aid.BS_ID}">
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_AID_FINANCIALLY, "BS_NAME")}
               value="${aid.BS_NAME}">
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>学年:</label>
            <s:datebox
                    custom='${fns:validField(TableName.BUS_AID_FINANCIALLY, "BAF_YEAR")}'
                    value="${aid.BAF_YEAR}"></s:datebox>
        </div>
    </div>
    <div class="form-group has-feedback">
        <label>备注:</label>
        <textarea ${fns:validField(TableName.BUS_AID_FINANCIALLY,"BUS_REMARKS")}
                class="form-control form-textarea"
                rows="5">${aid.BUS_REMARKS}</textarea>
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