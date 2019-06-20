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
    <input type="hidden" name="BC_ID" value="${cls.ID}">
    <input type="hidden" name="BC_NAME" value="${cls.BC_NAME}">
    <div class="form-group has-feedback">
        <label>辅导员:</label>
        <input type="hidden" ${fns:validField(TableName.BUS_DEPARTMENT_INSTRUCTOR, "BDMP_ID")}
               value="${cls.BDMP_ID}">
        <input type="text"
               class="form-control" ${fns:validField(TableName.BUS_DEPARTMENT_INSTRUCTOR, "BDMP_NAME")}
               value="${cls.BDMP_NAME}">
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
    //选择辅导员
    choiceBox.base({
        title: '选择辅导员',
        id: 'BDMP_ID',
        name: 'BDMP_NAME',
        searchParams:{
            BDM_ID : '${cls.BDM_ID}'
        },
        url: '${BASE_URL}${Url.DEPARTMENT_INSTRUCTOR_LIST_URL}',
        fields: [
            {
                min_width: 150,
                name: '辅导员',
                data: 'BDMP_NAME',
            },
            {
                min_width: 200,
                name: '所属学院',
                data: 'BDM_COLLEGE_NAME',
            },
            {
                min_width: 200,
                name: '系部',
                data: 'BDM_NAME',
            },
            {
                min_width: 100,
                name: '分配数量',
                data: 'DISTRIBUTION_COUNT',
            },
        ],
        confirm: function ($model, data) {
            console.log(data)
            $('#BDMP_ID').val(data.ID);
            $('#BDMP_NAME').val(data.BDMP_NAME);
        }
    });
</script>