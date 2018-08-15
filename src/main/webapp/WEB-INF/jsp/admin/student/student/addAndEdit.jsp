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
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>性别:</label>
            <s:combobox sdtCode="BUS_SEX" custom='${fns:validField("BUS_STUDENT","BS_SEX")}'
                        value="${student.BS_SEX}"></s:combobox>
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>民族:</label>
            <s:combobox sdtCode="BUS_NATION" custom='${fns:validField("BUS_STUDENT","BS_NATION")}'
                        value="${student.BS_NATION}"></s:combobox>
        </div>
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>学号:</label>
            <input type="text" class="form-control" ${fns:validField("BUS_STUDENT", "BS_NUMBER")}
                   value="${student.BS_NUMBER}">
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>学制:</label>
            <s:combobox sdtCode="BUS_COLLEGE_LENGTH" custom='${fns:validField("BUS_STUDENT","BS_LENGTH")}'
                        value="${student.BS_LENGTH}" defaultValue="3"></s:combobox>
        </div>
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>入学年度:</label>
            <s:datebox custom='${fns:validField("BUS_STUDENT", "BS_ENROLMENT_YEAR")}'
                       value="${student.BS_ENROLMENT_YEAR}" studentYear="false"></s:datebox>
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>考生号:</label>
            <input type="text" class="form-control" ${fns:validField("BUS_STUDENT", "BS_EXAMINEE_NUMBER")}
                   value="${student.BS_EXAMINEE_NUMBER}">
        </div>
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>身份证:</label>
            <input type="text" class="form-control" ${fns:validField("BUS_STUDENT", "BS_ID_CARD")}
                   value="${student.BS_ID_CARD}">
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>电话号码:</label>
            <input type="text" class="form-control" ${fns:validField("BUS_STUDENT", "BS_PHONE")}
                   value="${student.BS_PHONE}">
        </div>
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>银行:</label>
            <input type="text" class="form-control" ${fns:validField("BUS_STUDENT", "BS_BANK")}
                   value="${student.BS_BANK}">
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>银行卡号:</label>
            <input type="text" class="form-control" ${fns:validField("BUS_STUDENT", "BS_BANK_CARD")}
                   value="${student.BS_BANK_CARD}">
        </div>
    </div>
    <div class="form-group has-feedback">
        <label>户籍地址:</label>
        <input type="text" class="form-control" ${fns:validField("BUS_STUDENT", "BS_PERMANENT_ADDRESS")}
               value="${student.BS_PERMANENT_ADDRESS}">
    </div>
    <div class="form-group has-feedback ">
        <label>家庭住址:</label>
        <input type="text" class="form-control" ${fns:validField("BUS_STUDENT", "BS_HOME_ADDRESS")}
               value="${student.BS_HOME_ADDRESS}">
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
        dVal: '${student.BDM_ID}',
        url: '${CLASS_SELECT_DEPARTMENT_URL}'
    });
</script>