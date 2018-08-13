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
    <input type="hidden" name="ID" value="${SPD.ID}">
    <div class="form-group has-feedback">
        <label>流程名称:</label>
        <input type="text" class="form-control" ${fns:validField("SYS_PROCESS_DEFINITION", "SPD_NAME")}
               value="${SPD.SPD_NAME}">
    </div>
    <div class="form-group has-feedback">
        <label>流程版本:</label>
        <input type="text" class="form-control" ${fns:validField("SYS_PROCESS_DEFINITION", "SPD_VERSION")}
               value="${SPD.SPD_VERSION}">
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>流程大类:</label>
            <s:combobox sdtCode="SYS_PROCESS_TYPE" custom='${fns:validField("SYS_PROCESS_DEFINITION","BUS_PROCESS")}'
                        value="${SPD.BUS_PROCESS}"></s:combobox>
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>流程小类:</label>
            <s:combobox sdtCode="SYS_PROCESS_TYPE" custom='${fns:validField("SYS_PROCESS_DEFINITION","BUS_PROCESS2")}'
                        value="${SPD.BUS_PROCESS2}" level="1"></s:combobox>
        </div>
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>流程更新表名:</label>
            <input type="text" class="form-control" ${fns:validField("SYS_PROCESS_DEFINITION", "SPD_UPDATE_TABLE")}
                   value="${SPD.SPD_UPDATE_TABLE}">
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>流程更新表名称字段:</label>
            <input type="text" class="form-control" ${fns:validField("SYS_PROCESS_DEFINITION", "SPD_UPDATE_NAME")}
                   value="${SPD.SPD_UPDATE_NAME}">
        </div>
    </div>
</form>

<script>
    initCombobxSelectDisabled('BUS_PROCESS', 'BUS_PROCESS2','${SPD.BUS_PROCESS2}');

    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>