<%--
      Created by IntelliJ IDEA.
      User: 余庚鑫
      Date: 2017/3/6
      Time: 19:44
      To change this template use File | Settings | File Templates.
--%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form id="addAndEditForm">
    <input type="hidden" name="${SUBMIT_TOKEN_NAME}" value="${token}">
    <input type="hidden" name="ID" value="${MENU.ID}">
    <div class="form-group has-feedback">
        <label>菜单名称:</label>
        <input type="text" class="form-control" ${fns:validField("SYS_MENU","SM_NAME")}
               value="${MENU.SM_NAME}">
    </div>
    <div class="form-group has-feedback">
        <label>父菜单:</label>
        <s:treeBox custom='${fns:validField("SYS_MENU","SM_PARENTID")}'
                   value="${MENU.SM_PARENTID}" nameValue="${MENU.SM_PARENT_NAME}"
                   notId="${MENU.ID}"
                   url="${MENU_TREE_DATA_URL}" title="选择父菜单"></s:treeBox>
    </div>
    <div class="form-group has-feedback">
        <label>权限编码:</label>
        <input type="text" class="form-control" ${fns:validField("SYS_MENU","SM_CODE")} value="${MENU.SM_CODE}">
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>