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

<%--错误table--%>
<div class="modal fade" id="showDataGridFileModal" data-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                文件下载
            </div>
            <div class="modal-body">
                <table id="dataGridFileTable" class="table table-bordered table-striped table-overflow-x">
                    <thead>
                    <tr>
                        <th style="min-width: 300px;">文件名称</th>
                        <th style="min-width: 150px;">添加时间</th>
                        <th style="min-width: 70px;">操作</th>
                    </tr>
                    </thead>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<script>
    $('#dataGridFileBtn').on('click', function () {
        //情况文件上传框
        tableView.init({
            object: $('#dataGridFileTable'),
            data: ${fns:toJSONString(FILE_LIST)},
            columns: [
                {data: 'SCF_NAME', class: 'text-center'},
                {data: 'SCF_ENTRY_TIME', class: 'text-center'},
                {class: 'text-center'},
            ],
            columnDefs: [
                <%--操作按钮--%>
                {
                    targets: -1,
                    data: "SF_ID",
                    //按钮
                    render: function (data, type, row, meta) {
                        return '<a href="${BASE_URL}${AttributePath.FILE_DOWNLOAD_URL}' + data + '" class="btn btn-info btn-xs" >下载</a>';
                    }
                }
            ]
        });
        $('#showDataGridFileModal').modal('show');
    });
</script>