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
    <input type="hidden" name="ID" value="${post.ID}">
    <input type="hidden" name="BDS_ID" value="${fns:trueOrFalse(post != null ,post.BDS_ID,BDS_ID)}">
    <div class="form-group has-feedback">
        <label>岗位编号:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_DILIGENT_STUDY_POST,"BDSP_NUMBER")}
               value="${post.BDSP_NUMBER}">
    </div>
    <div class="form-group has-feedback">
        <label>岗位名称:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_DILIGENT_STUDY_POST,"BDSP_NAME")}
               value="${post.BDSP_NAME}">
    </div>
    <div class="form-group has-feedback">
        <label>每小时工资:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_DILIGENT_STUDY_POST,"BDSP_HOURLY_WAGE")}
               value="${post.BDSP_HOURLY_WAGE}">
    </div>
    <div class="form-group has-feedback">
        <label>排序:</label>
        <input type="number" class="form-control" ${fns:validField(TableName.BUS_DILIGENT_STUDY_POST,"BDSP_ORDER")}
               value="${post.BDSP_ORDER}">
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>