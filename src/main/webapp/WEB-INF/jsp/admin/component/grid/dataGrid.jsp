<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2018/3/26
  Time: 11:48
  To change this template use File | Settings | File Templates.
  基础通用列表
--%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cn.kim.common.eu.ProcessShowStatus" %>
<%@ page import="cn.kim.common.eu.ProcessStatus" %>
<style>
    .dataTable-column {
        word-break: break-all;
    }

    .DTFC_LeftBodyLiner {
        top: -15px !important;
    }

    .table-striped > tbody > tr:nth-of-type(even) {
        background-color: #fff;
    }

    .DTFC_LeftHeadWrapper thead tr {
        background-color: #fff;
    }
</style>

<%--设置字段偏移值--%>
<c:set var="FIELD_OFFSET" value="${1 + (CONFIGURE.SC_IS_SELECT == Attribute.STATUS_SUCCESS ? 1 : 0 )}"
       scope="request"></c:set>

<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box" id="dataGridBox${MENU.ID}">
                <div class="box-header">
                    <div class="col-md-12 btn-group-header">
                        <c:forEach items="${TOP_BUTTON}" var="BUTTON">
                            <button id="${BUTTON.SB_BUTTONID}" type="button" class="${BUTTON.SB_CLASS}"
                                    onclick="${BUTTON.SB_FUNC}"><i class="${BUTTON.SB_ICON}"></i>
                                    ${BUTTON.SB_NAME}
                            </button>
                        </c:forEach>
                    </div>
                    <%--流程查询状态 0 查看全部 1待审 2已审--%>
                    <input type="hidden" id="processStatus" name="processStatus"
                           value="${ProcessShowStatus.ALL.toString()}">
                    <form id="queryForm${MENU.ID}" class="form-horizontal">
                        <c:if test="${CONFIGURE.SC_IS_SEARCH == Attribute.STATUS_SUCCESS && SEARCH_LIST ne null && SEARCH_LIST.size() > 0 }">
                            <%--搜索条件--%>
                            <c:forEach items="${SEARCH_LIST}" var="SEARCH" varStatus="status">

                                <c:choose>
                                    <%--文本--%>
                                    <c:when test="${SEARCH.SCS_TYPE eq 1}">
                                        <div class="form-group form-group-search">
                                            <label for="SEARCH_${SEARCH.SCS_FIELD}"
                                                   class="col-sm-4 control-label">${SEARCH.SCS_NAME}</label>
                                            <div class="col-sm-8">
                                                <input id="SEARCH_${SEARCH.SCS_FIELD}" name="${SEARCH.SCS_FIELD}"
                                                       type="text" class="form-control form-control-input-search">
                                            </div>
                                        </div>
                                    </c:when>
                                    <%--选择--%>
                                    <c:when test="${SEARCH.SCS_TYPE eq 2 || SEARCH.SCS_TYPE eq 3}">
                                        <div class="form-group form-group-search">
                                            <label for="SEARCH_${SEARCH.SCS_FIELD}"
                                                   class="col-sm-4 control-label">${SEARCH.SCS_NAME}</label>
                                            <div class="col-sm-8">
                                                <s:combobox sdtCode="${SEARCH.SCS_SDT_CODE}"
                                                            id="SEARCH_${SEARCH.SCS_FIELD}"
                                                            name="${SEARCH.SCS_FIELD}"
                                                            disabled="false"
                                                            single="${fns:trueOrFalse(SEARCH.SCS_TYPE eq 2, true ,false )}"></s:combobox>
                                            </div>

                                        </div>
                                    </c:when>
                                    <%--时间选择--%>
                                    <c:when test="${SEARCH.SCS_TYPE eq 4 || SEARCH.SCS_TYPE eq 5|| SEARCH.SCS_TYPE eq 6|| SEARCH.SCS_TYPE eq 7}">
                                        <div class="form-group form-group-search">
                                            <label for="SEARCH_${SEARCH.SCS_FIELD}"
                                                   class="col-sm-4 control-label">${SEARCH.SCS_NAME}</label>
                                            <div class="col-sm-8">
                                                <s:datebox id="SEARCH_${SEARCH.SCS_FIELD}" name="${SEARCH.SCS_FIELD}"
                                                           type="${SEARCH.SCS_TYPE - 3}"
                                                           placeholder="${SEARCH.SCS_REMARK}"
                                                           clear="true"
                                                           studentYear="${fns:trueOrFalse(SEARCH.SCS_IS_STUDENT_YEAR, 'true' , 'false')}"></s:datebox>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                    </c:otherwise>
                                </c:choose>
                                <%--4个换行--%>
                                <c:if test="${(status.index + 1) % 4 == 0}">
                                    <div class="row"></div>
                                </c:if>
                            </c:forEach>

                            <div class="btn-group-search">
                                <button type="button" class="btn btn-success"
                                        id="searchBtn${MENU.ID}">搜索
                                </button>
                                <button type="button" class="btn btn-danger"
                                        id="resetBtn${MENU.ID}">重置
                                </button>
                            </div>
                        </c:if>
                    </form>
                </div>
                <div class="box-body">
                    <div class="col-md-12">
                        <div class="box box-default">
                            <c:if test="${CONFIGURE.SC_IS_PAGING == Attribute.STATUS_SUCCESS}">
                                <div class="box-header">
                                    <h3 class="box-title">${MENU.SM_NAME}</h3>
                                    <div class="box-tools pull-right">
                                            <%--其他按钮--%>
                                        <c:if test="${CONFIGURE.SC_IS_SELECT ne null && CONFIGURE.SC_IS_SELECT eq Attribute.STATUS_SUCCESS}">
                                            <button type="button" class="btn btn-box-tool"
                                                    id="clearBtn${MENU.ID}"><i
                                                    class="fa fa-trash-o"></i>清选
                                            </button>
                                        </c:if>
                                        <button type="button" class="btn btn-box-tool" data-widget="refresh"
                                                id="refreshBtn${MENU.ID}"><i
                                                class="fa fa-refresh"></i>刷新
                                        </button>
                                            <%--流程查看切换按钮--%>
                                        <c:if test="${!fns:isEmpty(MENU.BUS_PROCESS)}">
                                            <div class="btn-group" data-toggle="btn-toggle">
                                                <button id="processAllBtn" type="button"
                                                        class="btn btn-default btn-sm active"
                                                        data-process-status="${ProcessShowStatus.ALL.toString()}">
                                                    <i class="fa fa-square text-yellow">全部</i>
                                                </button>
                                                <button id="processStayBtn" type="button"
                                                        class="btn btn-default btn-sm"
                                                        data-process-status="${ProcessShowStatus.STAY.toString()}">
                                                    <i class="fa fa-square text-red">待审</i>
                                                </button>
                                                <button id="processAlreadyBtn" type="button"
                                                        class="btn btn-default btn-sm"
                                                        data-process-status="${ProcessShowStatus.ALREADY.toString()}">
                                                    <i class="fa fa-square text-green"></i>已审
                                                </button>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </c:if>
                            <div class="box-body">
                                <table id="dataGrid${MENU.ID}"
                                       class="table table-bordered table-striped
                                    <c:choose>
                                    <c:when test="${FIXED_LENGTH > 0}">
                                    row-border order-column
                                    </c:when>
                                    <c:otherwise>
                                    table-overflow-x
                                    </c:otherwise>
                                    </c:choose>">
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%--设置列表属性--%>
<%--标题--%>
<c:if test="${not empty EXTRA.TITLE}">
    <c:set scope="request" var="MENU_TITLE" value="${EXTRA.TITLE}-"></c:set>
</c:if>
<%@ include file="/WEB-INF/jsp/admin/component/setTitleParams.jsp" %>
<%--excel导入模块--%>
<%@ include file="/WEB-INF/jsp/admin/component/execlImport.jsp" %>
<script>
    $(".select2").select2({language: "zh-CN"});

    var isOpenStatus = false;

    var $dataGridTable = $("#dataGrid${MENU.ID}");

    var $dataGrid = tableView.init({
        //table对象
        object: $dataGridTable,
        //是否开启分页
        paging:${fns:trueOrFalse(CONFIGURE.SC_IS_PAGING, true ,false )},
        //搜索按钮
        searchBtn: $('#searchBtn${MENU.ID}'),
        //重置按钮
        resetBtn: $('#resetBtn${MENU.ID}'),
        //刷新按钮
        refreshBtn: $('#refreshBtn${MENU.ID}'),
        //清空选择按钮
        clearBtn: $('#clearBtn${MENU.ID}'),
        //查询提交的表单
        queryForm: $('#queryForm${MENU.ID}'),
        //后台加载div
        adminLoadingDiv: $('#dataGridBox${MENU.ID}'),
        //查询URL链接
        url: '${DATA_GRID_URL}${CONFIGURE.ID}',
        <%--不分页就把选择显示数选择关掉--%>
        <c:if test="${CONFIGURE.SC_IS_PAGING != Attribute.STATUS_SUCCESS}">
        headLength: false,
        </c:if>
        <c:if test="${CONFIGURE.SC_IS_SELECT == Attribute.STATUS_SUCCESS}">
        <c:choose>
        <%--单选--%>
        <c:when test="${CONFIGURE.SC_IS_SINGLE ne null && CONFIGURE.SC_IS_SINGLE  eq Attribute.STATUS_SUCCESS}">
        select: choiceBox.mode.SINGLE,
        </c:when>
        <%--多选--%>
        <c:otherwise>
        select: choiceBox.mode.MULTIPLE,
        </c:otherwise>
        </c:choose>
        </c:if>
        //固定列
        <c:if test="${FIXED_LENGTH > 0}">
        fixedColumns: ${FIXED_LENGTH},
        </c:if>
        <%--搜索额外参数--%>
        searchParams: function (params) {
            if (typeof searchParams == 'function') {
                searchParams(params);
            }
            //添加按钮ID
            params['SM_ID'] = '${MENU.ID}';
            params['processStatus'] = $('#processStatus').val();
        },
        <%--字段--%>
        columns: [
            <%--开启checkbox--%>
            <c:if test="${CONFIGURE.SC_IS_SELECT == Attribute.STATUS_SUCCESS}">
            {
                data: null,
                width: '20px',
                <c:if test="${CONFIGURE.SC_IS_SINGLE  ne Attribute.STATUS_SUCCESS}">
                className: 'select-checkbox text-center',
                title: '<input type="checkbox" data-id="dataGridSelectAll" onclick="dataGridSwitchSelectAll(this.checked);">',
                </c:if>
            },
            </c:if>
            {
                <%--此列不绑定数据源，用来显示序号--%>
                data: null,
                title: '序号',
                align: 'center',
                width: '35px',
                className: 'text-center dataTable-column-min-width-sort',
                <%--设置列初始化行--%>
                createdCell: function (td, cellData, rowData, row, col) {
                    <%--设置最小宽度--%>
                    $(td).css('min-width', '35px');
                }
            },
            <c:forEach items="${COLUMN_LIST}" var="COLUMN">
            {
                <%--data: <c:if test="${COLUMN.SCC_IS_OPERATION eq Attribute.STATUS_SUCCESS}">null</c:if><c:if test="${COLUMN.SCC_IS_OPERATION ne Attribute.STATUS_SUCCESS}">'${COLUMN.SCC_FIELD}'</c:if>,--%>
                data: '${fns:trueOrFalse(COLUMN.SCC_IS_OPERATION, "ID" ,COLUMN.SCC_FIELD )}',
                title:
                    '${COLUMN.SCC_NAME}',
                <c:if test="${not empty COLUMN.SCC_WIDTH}">
                width: '${COLUMN.SCC_WIDTH}',
                </c:if>
                className: 'dataTable-column text-${COLUMN.SCC_ALIGN} ' + '${fns:trueOrFalse(COLUMN.SCC_IS_OPERATION, "dataTable-column-min-width-operation" , "" )} ' + '${COLUMN.SCC_CLASS}',
                visible: ${fns:trueOrFalse(COLUMN.SCC_IS_VISIBLE, true ,false )},
                <%--设置列初始化行--%>
                createdCell: function (td, cellData, rowData, row, col) {
                    <%--设置最小宽度--%>
                    <c:if test="${not empty COLUMN.SCC_WIDTH}">
                    $(td).css('min-width', '${COLUMN.SCC_WIDTH}');
                    </c:if>
                    <c:if test="${COLUMN.SCC_IS_OPERATION eq Attribute.STATUS_SUCCESS }">
                    <%--是否查询流程操作按钮--%>
                    <c:if test="${!fns:isEmpty(MENU.BUS_PROCESS)}">
                    <%--查询权限菜单--%>
                    if (rowData.SPS_AUDIT_STATUS != ${ProcessStatus.COMPLETE.type}) {
                        ajax.get('${PROCESS_DATAGRID_BTN}', {
                            ID: cellData,
                            BUS_PROCESS: rowData.BUS_PROCESS,
                            BUS_PROCESS2: rowData.BUS_PROCESS2
                        }, function (data) {
                            $(td).append(data.html);
                        });
                    }
                    </c:if>
                    </c:if>
                }
            }
            ,
            </c:forEach>
        ],
        //操作按钮
        columnDefs: [
            <%--开启checkbox--%>
            <c:if test="${CONFIGURE.SC_IS_SELECT == Attribute.STATUS_SUCCESS}">
            {
                className: 'select-checkbox',
                targets: 0,
            },
            </c:if>
            <%--加载列格式化--%>
            <c:forEach items="${COLUMN_LIST}" var="COLUMN" varStatus="status">
            <c:choose>
            <%--格式化函数--%>
            <c:when test="${!fns:isEmpty(COLUMN.SCC_FUNC)}">
            ${fns:formatFunc(COLUMN.SCC_FUNC,status.index + FIELD_OFFSET,COLUMN.SCC_FIELD)},
            </c:when>
            <%--格式化状态列，变成按钮--%>
            <c:when test="${COLUMN.SCC_IS_STATUS eq Attribute.STATUS_SUCCESS}">
            {
                targets: ${status.index + FIELD_OFFSET},
                data: '${COLUMN.SCC_FIELD}',
                render: function (data, type, row, meta) {
                    return '<input type="checkbox" value="' + row.ID + '" data-field="${COLUMN.SCC_FIELD}" data-handle-width="35" name="STATUS_SWITCH" ' + (data == '${Attribute.STATUS_SUCCESS}' ? 'checked' : '') + '>';
                }
            },
            </c:when>
            <c:when test="${COLUMN.SCC_IS_OPERATION eq Attribute.STATUS_SUCCESS }">
            <%--操作按钮--%>
            {
                targets: ${status.index + FIELD_OFFSET},
                data: "ID",
                //按钮
                render: function (data, type, row, meta) {
                    var operate = '';
                    <c:choose>
                    <%--合并操作按钮--%>
                    <c:when test="${COLUMN.SCC_IS_MERGE eq Attribute.STATUS_SUCCESS}">
                    operate += '<div class="btn-group">';
                    operate += '<button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">操作 <span class="caret"></span></button>';
                    operate += '<ul class="dropdown-menu" role="menu">';
                    <c:forEach items="${LIST_BUTTON}" var="BUTTON" varStatus="status">
                    var btn${status.index} = '<li><a href="javascript:void(0);" id="${BUTTON.SB_BUTTONID}" value="' + row.ID + '" onclick="${fns:formatFunc(COLUMN.SCC_FUNC,status.index + 1,COLUMN.SCC_FIELD)}"><i class="${BUTTON.SB_ICON}"></i>${BUTTON.SB_NAME}</button></li>';
                    if (typeof dataGridButtonFormat == 'function') {
                        operate += dataGridButtonFormat(row, '${BUTTON.SB_BUTTONID}', btn${status.index});
                    } else {
                        operate += btn${status.index};
                    }
                    </c:forEach>
                    operate += '</ul>';
                    operate += '</div>';
                    </c:when>
                    <c:otherwise>
                    <c:forEach items="${LIST_BUTTON}" var="BUTTON" varStatus="status">
                    var btn${status.index} = '<button type="button" class="${BUTTON.SB_CLASS} btn-xs" id="${BUTTON.SB_BUTTONID}" value="' + row.ID + '" onclick="${fns:formatFunc(COLUMN.SCC_FUNC,status.index + 1,COLUMN.SCC_FIELD)}"><i class="${BUTTON.SB_ICON}"></i>${BUTTON.SB_NAME}</button>';
                    if (typeof dataGridButtonFormat == 'function') {
                        operate += dataGridButtonFormat(row, '${BUTTON.SB_BUTTONID}', btn${status.index});
                    } else {
                        operate += btn${status.index};
                    }
                    </c:forEach>
                    </c:otherwise>
                    </c:choose>

                    return operate;

                }
            },
            </c:when>
            <c:otherwise>
            </c:otherwise>
            </c:choose>
            </c:forEach>
        ],
        <%--列表刷新完回调--%>
        endCallback: function (api) {
            <%--选择框--%>
            <c:if test="${CONFIGURE.SC_IS_SELECT == Attribute.STATUS_SUCCESS}">
            tableView.choiceBox(api, 0);
            $('.select-checkbox').css('width', '20px');
            </c:if>
            <%--序号--%>
            tableView.orderNumber(api, ${fns:trueOrFalse(CONFIGURE.SC_IS_SELECT, 1 ,0 )});
            $('.dataTable-column-min-width-sort').css('width', '35px');
            <%--切换按钮--%>
            $('[name="STATUS_SWITCH"]').bootstrapSwitch({
                onText: "开启",
                offText: "关闭",
                onColor: "success",
                offColor: "danger",
                size: "mini",
                onSwitchChange: function (el, check) {
                    var $this = $(this);
                    var IS_STATUS = check ? STATUS_SUCCESS : STATUS_ERROR;

                    if (typeof onSwitchChange == 'function') {
                        isOpenStatus = true;
                        <%--确认弹出框--%>
                        model.confirm({
                            message: '是否切换状态为:' + getStatusName(IS_STATUS),
                            callback: function (result) {
                                if (result) {
                                    <%--1、按钮自身 2、按钮当前所属字段 3、按钮的状态 true false 4、格式化成 0 1的状态--%>
                                    onSwitchChange($this, $this.attr('data-field'), check, IS_STATUS);
                                } else {
                                    $this.bootstrapSwitch('toggleState', true);
                                }
                                isOpenStatus = false;
                            }
                        });
                    }
                }
            });
            if (typeof endDataGridCallback == 'function') {
                endDataGridCallback(api);
            }

            //自动计算宽度是否超出表格宽度
            if ($('#dataGrid${MENU.ID}_wrapper').width() < $dataGridTable.find('tbody tr:first').width()) {
                $dataGridTable.css('display', 'inline-block');
            }
        }
    });

    <%--开启checkbox--%>
    <c:if test="${CONFIGURE.SC_IS_SELECT == Attribute.STATUS_SUCCESS}">
    <c:if test="${CONFIGURE.SC_IS_SINGLE  ne Attribute.STATUS_SUCCESS}">

    function dataGridSwitchSelectAll(checked) {
        if (checked) {
            $dataGrid.rows().select();
        } else {
            $dataGrid.rows().deselect();
        }
    }

    //监听选择
    $dataGrid.on('select', function (e, dt, type, indexes) {
        if (type === 'row') {
            var data = getDataGridSelected();
            if (data.length == $dataGrid.rows().data().length) {
                $('input[type="checkbox"][data-id="dataGridSelectAll"]').prop('checked', true);
            }
        }
    });
    //监听取消选择
    $dataGrid.on('deselect', function (e, dt, type, indexes) {
        if (type === 'row') {
            var data = $dataGrid.rows().data();
            var selectData = getDataGridSelected();
            if (data.length == 0 || data.length != selectData.length) {
                $('input[type="checkbox"][data-id="dataGridSelectAll"]').prop('checked', false);
            }
        }
    });
    </c:if>
    </c:if>

    <c:if test="${!fns:isEmpty(MENU.BUS_PROCESS)}">
    //流程批量提交
    $('#processSubmit').on('click', function () {
        var dataArray = getDataGridSelected();
        if (dataArray.length == 0) {
            demo.showNotify(ALERT_WARNING, '请选择流程!');
            return;
        }
        //判断一个流程一个状态
        var IDS = '';
        var BUS_PROCESS;
        var BUS_PROCESS2;
        var SPS_AUDIT_STATUS;
        for (var i = 0; i < dataArray.length; i++) {
            var data = dataArray[i];
            if (i > 0) {
                if (data.BUS_PROCESS != BUS_PROCESS || data.BUS_PROCESS2 != BUS_PROCESS2) {
                    demo.showNotify(ALERT_WARNING, '请选择同一流程!');
                    return;
                }
                if (data.SPS_AUDIT_STATUS != SPS_AUDIT_STATUS) {
                    demo.showNotify(ALERT_WARNING, '请选择处于同一审核状态的流程!');
                    return;
                }
            }

            BUS_PROCESS = data.BUS_PROCESS;
            BUS_PROCESS2 = data.BUS_PROCESS2;
            SPS_AUDIT_STATUS = data.SPS_AUDIT_STATUS;
            if (i > 0) {
                IDS += ",";
            }
            IDS += data.ID;
        }
        process.showProcessHome({
            ID: IDS,
            BUS_PROCESS: BUS_PROCESS,
            BUS_PROCESS2: BUS_PROCESS2,
            SHOW_SO_ID: data.SHOW_SO_ID,
            PROCESS_TYPE: '${ProcessType.SUBMIT.toString()}',
            dataGrid: $dataGrid
        });
    });

    //流程提交
    $dataGridTable.find('tbody').on('click', '#PROCESS_SUBMIT', function () {
        var data = getRowData(this);
        var id = data.ID;
        var BUS_PROCESS = data.BUS_PROCESS;
        var BUS_PROCESS2 = data.BUS_PROCESS2;

        process.showProcessHome({
            ID: id,
            BUS_PROCESS: BUS_PROCESS,
            BUS_PROCESS2: BUS_PROCESS2,
            SHOW_SO_ID: data.SHOW_SO_ID,
            PROCESS_TYPE: '${ProcessType.SUBMIT.toString()}',
            dataGrid: $dataGrid
        });
    });

    //流程退回
    $dataGridTable.find('tbody').on('click', '#PROCESS_BACK', function () {
        var data = getRowData(this);
        var id = data.ID;
        var BUS_PROCESS = data.BUS_PROCESS;
        var BUS_PROCESS2 = data.BUS_PROCESS2;

        process.showProcessHome({
            ID: id,
            BUS_PROCESS: BUS_PROCESS,
            BUS_PROCESS2: BUS_PROCESS2,
            PROCESS_TYPE: '${ProcessType.BACK.toString()}',
            dataGrid: $dataGrid
        });
    });

    //流程撤回
    $dataGridTable.find('tbody').on('click', '#PROCESS_WITHDRAW', function () {
        var data = getRowData(this);
        var id = data.ID;
        var BUS_PROCESS = data.BUS_PROCESS;
        var BUS_PROCESS2 = data.BUS_PROCESS2;

        process.processWithdraw({
            ID: id,
            BUS_PROCESS: BUS_PROCESS,
            BUS_PROCESS2: BUS_PROCESS2,
            dataGrid: $dataGrid
        });
    });

    //流程日志
    $dataGridTable.find('tbody').on('click', '#PROCESS_LOG', function () {
        var data = getRowData(this);
        var id = data.ID;
        var BUS_PROCESS = data.BUS_PROCESS;
        var BUS_PROCESS2 = data.BUS_PROCESS2;

        process.processLog({
            ID: id,
            BUS_PROCESS: BUS_PROCESS,
            BUS_PROCESS2: BUS_PROCESS2,
        });
    });

    </c:if>
    //按钮日志格式化
    function processLogFunc(targets, field) {
        return {
            targets: targets,
            data: field,
            render: function (data, type, full, meta) {
                if (full.SPS_AUDIT_STATUS == undefined || full.SPS_AUDIT_STATUS == 0) {
                    return '<button type="button" class="btn btn-link btn-xs" disabled>' + data + '</button>';
                } else {
                    return '<button type="button" class="btn btn-link btn-xs" id="PROCESS_LOG">' + data + '</button>';
                }
            }
        };
    }

    /**
     *  根据this获取
     * */
    function getRowData(row) {
        return tableView.rowData($dataGrid, row);
    }

    /**
     * 是否到自己审核了
     * */
    function isProcessSubmit(row) {
        return $(row).siblings('#PROCESS_SUBMIT').length > 0;
    }

    /**
     * 获取选中的行
     */
    function getDataGridSelected() {
        return $dataGrid.rows({selected: true}).data();
    }
</script>