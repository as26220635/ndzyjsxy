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
    <input type="hidden" name="ID" value="${teacher.ID}">
    <div class="form-group has-feedback">
        <label>教师名称:</label>
        <input type="text" class="form-control" ${fns:validField("BUS_TEACHER", "BT_NAME")}
               value="${teacher.BT_NAME}">
    </div>
    <div class="form-group has-feedback">
        <label>所属系部:</label>
        <s:treeBox custom='${fns:validField("BUS_TEACHER","BDM_ID")}'
                   value="${teacher.BDM_ID}" nameValue="${teacher.BDM_NAME}"
                   url="${DEPARTMENT_TREE_DATA_URL}" title="选择系部"></s:treeBox>
    </div>
    <div class="form-group has-feedback">
        <label>工号:</label>
        <input type="text" class="form-control" ${fns:validField("BUS_TEACHER", "BT_NUMBER")}
               value="${teacher.BT_NUMBER}">
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>