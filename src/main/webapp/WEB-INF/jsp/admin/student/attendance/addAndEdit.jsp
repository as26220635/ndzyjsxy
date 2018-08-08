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
    <input type="hidden" name="ID" value="${attendance.ID}">
    <div class="form-group has-feedback">
        <label>学生:</label>
        <input type="hidden" ${fns:validField("BUS_STUDENT_ATTENDANCE", "BS_ID")} value="${attendance.BS_ID}">
        <input type="text" class="form-control" ${fns:validField("BUS_STUDENT_ATTENDANCE", "BS_NAME")}
               value="${attendance.BS_NAME}">
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>年度:</label>
            <s:datebox custom='${fns:validField("BUS_STUDENT_ATTENDANCE", "BSA_YEAR")}'
                       value="${attendance.BSA_YEAR}"></s:datebox>
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>学期:</label>
            <s:combobox sdtCode="BUS_SEMESTER" custom='${fns:validField("BUS_STUDENT_ATTENDANCE","BSA_SEMESTER")}'
                        value="${attendance.BSA_SEMESTER}"></s:combobox>
        </div>
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>周:</label>
            <input type="text" class="form-control" ${fns:validField("BUS_STUDENT_ATTENDANCE", "BSA_WEEK")}
                   value="${attendance.BSA_WEEK}">
        </div>
    </div>
    <div class="row">
        <div class="form-group has-feedback form-group-md-6">
            <label>迟到节数:</label>
            <input type="text" class="form-control" ${fns:validField("BUS_STUDENT_ATTENDANCE", "BSA_LATE")}
                   value="${attendance.BSA_LATE}">
        </div>
        <div class="form-group has-feedback form-group-md-6">
            <label>旷课节数:</label>
            <input type="text" class="form-control" ${fns:validField("BUS_STUDENT_ATTENDANCE", "BSA_ABSENTEEISM")}
                   value="${attendance.BSA_ABSENTEEISM}">
        </div>
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });

    //选择学生
    $('#BS_NAME').selectInput(function () {
        choiceBox.init({
            modelSize: model.size.LG,
            url: '${STUDENT_LIST_URL}',
            title: '选择学生',
            searchLabel: '学生姓名',
            searchFields:[
                {
                    label:'姓名',
                    name:'BS_NAME',
                },
                {
                    label:'学号',
                    name:'BS_NUMBER',
                },
                {
                    label:'身份证',
                    name:'BS_ID_CARD',
                },
            ],
            fields: [
                {
                    min_width: 100,
                    name: '学生',
                    data: 'BS_NAME',
                },
                {
                    min_width: 150,
                    name: '学号',
                    data: 'BS_NUMBER',
                },
                {
                    min_width: 170,
                    name: '班级名称',
                    data: 'BC_NAME',
                },
            ],
            confirm: function ($model, data) {
                $('#BS_ID').val(data.ID);
                $('#BS_NAME').val(data.BS_NAME);
            }
        })
    });

</script>