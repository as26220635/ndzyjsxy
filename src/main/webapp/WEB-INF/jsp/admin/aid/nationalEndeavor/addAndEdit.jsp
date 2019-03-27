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
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>成绩排名总人数:</label>
            <input type="text"
                   class="form-control" ${fns:validField(TableName.BUS_AID_NATIONAL_SCHOLARSHIP, "BANS_SCORE_RANK_TOTAL")}
                   value="${ns.BANS_SCORE_RANK_TOTAL}">
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>成绩排名名次:</label>
            <input type="text"
                   class="form-control" ${fns:validField(TableName.BUS_AID_NATIONAL_SCHOLARSHIP, "BANS_SCORE_RANK")}
                   value="${ns.BANS_SCORE_RANK}">
        </div>
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>必修课及格门数:</label>
            <input type="text"
                   class="form-control" ${fns:validField(TableName.BUS_AID_NATIONAL_SCHOLARSHIP, "BANS_REQUIRED_COURSE_PASS_NUMBER")}
                   value="${ns.BANS_REQUIRED_COURSE_PASS_NUMBER}">
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>必修课门数:</label>
            <input type="text"
                   class="form-control" ${fns:validField(TableName.BUS_AID_NATIONAL_SCHOLARSHIP, "BANS_REQUIRED_COURSE_NUMBER")}
                   value="${ns.BANS_REQUIRED_COURSE_NUMBER}">
        </div>
    </div>
    <div class="form-group has-feedback">
        <label>是否实行综合考评排名:</label>
        <s:combobox sdtCode="SYS_YES_NO"
                    custom='${fns:validField(TableName.BUS_AID_NATIONAL_SCHOLARSHIP,"BANS_IS_COMPREHENSIVE_RANK")}'
                    value="${ns.BANS_IS_COMPREHENSIVE_RANK}"></s:combobox>
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>综合考评排名名次:</label>
            <input type="text"
                   class="form-control" ${fns:validField(TableName.BUS_AID_NATIONAL_SCHOLARSHIP, "BANS_COMPREHENSIVE_RANK")}
                   value="${ns.BANS_COMPREHENSIVE_RANK}">
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>综合考评排名总人数:</label>
            <input type="text"
                   class="form-control" ${fns:validField(TableName.BUS_AID_NATIONAL_SCHOLARSHIP, "BANS_COMPREHENSIVE_RANK_NUMBER")}
                   value="${ns.BANS_COMPREHENSIVE_RANK_NUMBER}">
        </div>
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>实发金额:</label>
            <input type="text"
                   class="form-control" ${fns:validField(TableName.BUS_AID_NATIONAL_SCHOLARSHIP, "BANS_ACTUAL_AMOUNT")}
                   value="${ns.BANS_ACTUAL_AMOUNT}">
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>发放日期:</label>
            <s:datebox
                    type="5"
                    custom='${fns:validField(TableName.BUS_AID_NATIONAL_SCHOLARSHIP, "BANS_ISSUANCE_TIME")}'
                    value="${ns.BANS_ISSUANCE_TIME}"></s:datebox>
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
        url:'${BASE_URL}${Url.STUDENT_LIST_URL}'
    });
</script>