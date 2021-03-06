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
                        <th style="min-width: 50px;">数据信息</th>
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
    var isImport = $('.btn-import').length > 0 ? true : false;
    var importBtnId;
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
        $('.btn-import').on('click', function () {
            //拿到按钮id
            importBtnId = $(this).attr('id');
            importFileClear();
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
                excelImport($('#importForm'), $('#excelImportModal'), importBtnId);
            }
        });
    }

    /**
     * 清空
     */
    function importFileClear() {
        $("#excelFile").fileinput('clear');
    }

    var errorTableView;
    /**
     * 显示错误
     * @param data
     */
    function showImportError(data) {
        if (isEmpty(data)) {
            return;
        }
        //情况文件上传框
        errorTableView = tableView.init({
            object: $('#errorImportTable'),
            data: data,
            columns: [
                {class: 'text-center'},
                {},
                {
                    render: function (data, type, row, meta) {
                        return '<button class="btn btn-xs btn-info" id="detail">详细数据</button>';
                    }
                },
            ],
        });
        $('#errorImportModal').modal('show');

        $("#errorImportTable").find('tbody').on('click', '#detail', function () {
            var data = tableView.rowData(errorTableView, this);
            var detail = data[2];
            if (detail != undefined){
                model.alert({
                    title: '异常数据',
                    message: detail,
                });
            }else{
                demo.showNotify(ALERT_WARNING, '没有异常数据!');
            }


        });
    }
</script>