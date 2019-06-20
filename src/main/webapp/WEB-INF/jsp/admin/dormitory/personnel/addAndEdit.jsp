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
    <input type="hidden" name="ID" value="${personnel.ID}">
    <div class="form-group has-feedback">
        <label>铺位:</label>
        <input type="hidden" ${fns:validField(TableName.BUS_DORMITORY_PERSONNEL, "BDB_ID")}
               value="${personnel.BDB_ID}">
        <input type="text"
               class="form-control" ${fns:validField(TableName.BUS_DORMITORY_PERSONNEL, "BDB_NAME")}
               value="${personnel.BDB_NAME}" disabled="${fns:trueOrFalse(not empty personnel,true,false)}">
    </div>
    <div class="form-group has-feedback">
        <label>铺位人员:</label>
        <input type="hidden" ${fns:validField(TableName.BUS_DORMITORY_PERSONNEL, "BDP_OPERATOR_ID")}
               value="${personnel.BDP_OPERATOR_ID}">
        <input type="text"
               class="form-control" ${fns:validField(TableName.BUS_DORMITORY_PERSONNEL, "BDP_OPERATOR_NAME")}
               value="${personnel.BDP_OPERATOR_NAME}">
    </div>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
    <c:if test="${empty personnel}">
    //选择铺位
    choiceBox.base({
        title: '选择铺位',
        id: 'BDB_ID',
        name: 'BDB_NAME',
        searchLabel: '连接名称',
        url: '${BASE_URL}${Url.DORMITORY_BERTH_LIST_URL}',
        fields: [
            {
                min_width: 130,
                name: '名称',
                data: 'BDB_NAME',
            },
            {
                min_width: 130,
                name: '楼名称',
                data: 'BDF_NAME',
            },
            {
                min_width: 130,
                name: '室名称',
                data: 'BDR_NAME',
            },
            {
                min_width: 300,
                name: '连接名称',
                data: 'BDB_JOIN_NAME',
            },
        ],
        confirm: function ($model, data) {
            $('#BDB_ID').val(data.ID);
            $('#BDB_NAME').val(data.BDB_NAME);
        }
    });
    </c:if>
    //选择人员
    choiceBox.base({
        title: '选择人员',
        id: 'BDP_OPERATOR_ID',
        name: 'BDP_OPERATOR_NAME',
        searchLabel: '名称',
        url: '${BASE_URL}${Url.OPERATOR_LIST_URL}',
        fields: [
            {
                min_width: 120,
                name: '名称',
                data: 'SAI_NAME',
            },
            {
                min_width: 60,
                name: '用户类型',
                data: 'SAI_TYPE_NAME',
            },
            {
                min_width: 100,
                name: '手机',
                data: 'SAI_PHONE',
            },
            {
                min_width: 130,
                name: '邮箱',
                data: 'SAI_EMAIL',
            },
            {
                min_width: 250,
                name: '现宿舍',
                data: 'BDP_JOIN_NAME',
            },
            {
                min_width: 250,
                name: '登录名',
                data: 'SOS_USERNAME',
            },
        ],
        confirm: function ($model, data) {
            $('#BDP_OPERATOR_ID').val(data.ID);
            $('#BDP_OPERATOR_NAME').val(data.SAI_NAME);
        }
    });

</script>