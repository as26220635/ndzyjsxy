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
    <input type="hidden" name="ID" value="${student.ID}">
    <div class="form-group has-feedback">
        <label>学生名称:</label>
        <input type="text" class="form-control" ${fns:validField("BUS_STUDENT", "BS_NAME")}
               value="${student.BS_NAME}">
    </div>
    <div class="form-group has-feedback">
        <label>系部:</label>
        <s:treeBox custom='${fns:validField("BUS_STUDENT","BDM_ID")}'
                   value="${student.BDM_ID}" nameValue="${student.BDM_NAME}"
                   url="${DEPARTMENT_TREE_DATA_URL}" title="选择系部"></s:treeBox>
    </div>
    <div class="form-group has-feedback">
        <label>班级:</label>
        <s:combobox custom='${fns:validField("BUS_STUDENT","BC_ID")}'
                    value="${student.BC_ID}"></s:combobox>
    </div>
    <div class="form-group has-feedback">
        <label>工号:</label>
        <input type="text" class="form-control" ${fns:validField("BUS_STUDENT", "BS_NUMBER")}
               value="${student.BS_NUMBER}">
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
    //班级选择
    classSwitch.init({
        dObj: $('#BDM_ID'),
        cObj: $('#BC_ID'),
        val: '${student.BC_ID}',
        url: '${CLASS_SELECT_DEPARTMENT_URL}'
    });
</script>