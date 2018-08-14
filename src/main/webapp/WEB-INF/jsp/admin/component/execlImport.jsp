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

<%--上传file--%>
<div class="modal fade" id="excelImportModal" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">导入excel</h4>
            </div>
            <div class="modal-body">
                <form id="importForm" class="form-horizontal" enctype="multipart/form-data">
                    <input id="excelFile" name="excelFile" type="file" class="file">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="excelImportBtn">上传</button>
            </div>
        </div>
    </div>
</div>

<%--错误table--%>
<div class="modal fade" id="errorImportModal" data-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title text-red">导入excel错误消息,请处理后在次导入!</h4>
            </div>
            <div class="modal-body">
                <table id="errorImportTable" class="table table-bordered table-striped table-overflow-x">
                    <thead>
                    <tr>
                        <th style="min-width: 60px;">行号</th>
                        <th style="min-width: 380px;">错误消息</th>
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
    //是否初始化导入
    var isImport = $('#import').length > 0 ? true : false;
    if (isImport) {
        file.init({
            id: '#excelFile',
            showUpload: false,
            allowedFileExtensions: ['xls', 'xlsx'],
            maxFilesNum: 1,
            showPreview: false,
            nonModel: true,
        });
        //打开模态框
        $('#import').on('click', function () {
            $('#excelImportModal').modal('show');
        });

        $('#excelImportBtn').on('click', function () {
            var count = $('#excelFile').fileinput('getFilesCount');
            if (count == 0) {
                demo.showNotify(ALERT_WARNING, '请选择excel文件上传!');
                return;
            }
            //导入excel
            if (typeof excelImport == 'function') {
                excelImport($('#importForm'), $('#excelImportModal'));
            }
        });
    }

    /**
     * 清空
     */
    function importFileClear() {
        $("#excelFile").fileinput('clear');
    }

    /**
     * 显示错误
     * @param data
     */
    function showImportError(data) {
        if (isEmpty(data)) {
            return;
        }
        //情况文件上传框
        tableView.init({
            object: $('#errorImportTable'),
            data: data,
            columns: [
                {class: 'text-center'},
                {},
            ],
        });
        $('#errorImportModal').modal('show');
    }
</script>