<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2018/8/13
  Time: 19:09
  To change this template use File | Settings | File Templates.
  excel导入
--%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<table id="diffTable" class="table table-bordered table-striped table-overflow-x">
    <thead>
    <tr>
        <th style="min-width: 100px;">字段</th>
        <th style="min-width: 200px;">旧值</th>
        <th style="min-width: 50px;">类型</th>
        <th style="min-width: 200px;">新值</th>
    </tr>
    </thead>
</table>

<script>
    var $diffTable = $('#diffTable');
    //情况文件上传框
    var $table = tableView.init({
        object: $diffTable,
        paging: false,
        //JSON data
        data: ${data},
        createdRow: function (row, data, dataIndex) {
            //提交
            if (data.type == '添加') {
                $(row).addClass('text-green');
            } else if (data.type == '删除') {
                //退回
                $(row).addClass('text-red');
            } else if (data.type == '修改') {
                //撤回
                $(row).addClass('text-blue');
                $(row).attr('id', 'diff');
            }
        },
        columns: [
            {data: 'field', class: 'text-center'},
            {data: 'oldValue', class: 'text-left'},
            {data: 'type', class: 'text-center'},
            {data: 'newValue', class: 'text-left'},
        ]
    });

    //diff
    $diffTable.find('tbody').on('click', '#diff', function () {
        var data = tableView.rowData($table, this);

        ajax.getHtml('${BASE_URL}${Url.DIFF_URL}', {
                oldValue: data.oldValue,
                newValue: data.newValue,
            }, function (html) {
                model.show({
                    title: data.field + ',变动详细',
                    content: html,
                    size: model.size.LG,
                    footerModel: model.footerModel.ADMIN,
                });
            }
        );
    });
</script>