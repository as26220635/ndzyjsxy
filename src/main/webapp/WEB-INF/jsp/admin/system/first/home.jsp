<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2018/10/8
  Time: 19:44
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<section class="content">
    <div class="row">
        <div class="col-md-3 col-sm-6 col-xs-12">
            <div class="info-box">
                <span class="info-box-icon bg-aqua"><i class="mdi mdi-clipboard-text"></i></span>

                <div class="info-box-content">
                    <span class="info-box-text">待办事项</span>
                    <span class="info-box-number">${backlogNumber}
                        <small>项</small></span>
                </div>
            </div>
        </div>
    </div>

    <%--待办事项清单--%>
    <div class="box box-info">
        <div class="box-header with-border">
            <h3 class="box-title">待办事项详细</h3>

            <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
            </div>
        </div>
        <div class="box-body">
            <table id="backlogTable"
                   class="table table-bordered table-striped table-overflow-x">
                <thead>
                <tr>
                    <th style="min-width: 120px;">流程名称</th>
                    <th style="min-width: 150px;">数量</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</section>

<script>
    tableView.init({
        object: $('#backlogTable'),
        data: ${backlogList},
        columns: [
            {data: 'SPD_NAME', class: 'text-center'},
            {data: 'BACKLOG_NUM', class: 'text-center'},
        ],
    });
</script>