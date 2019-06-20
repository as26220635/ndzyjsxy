<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    //查询额外参数
    function searchParams(param) {
        param.BDF_ID = '${EXTRA.BDF_ID}';
    }
</script>
<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    <c:choose>
    <c:when test="${empty EXTRA.BDF_ID}">
    $('#return,#addBtn').remove();
    </c:when>
    <c:otherwise>
    $('#import').remove();
    </c:otherwise>
    </c:choose>

    //添加
    $('#addBtn').on('click', function () {
        var BDF_ID = '${EXTRA.BDF_ID}';
        if (isEmpty(BDF_ID)) {
            demo.showNotify(ALERT_WARNING, '请从楼管理添加室信息!');
            return;
        }
        ajax.getHtml('${BASE_URL}${Url.DORMITORY_ROOM_ADD_URL}', {BDF_ID: BDF_ID}, function (html) {
                model.show({
                    title: '添加室',
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                    isConfirm: true,
                    confirm: function ($model) {
                        var $form = $('#addAndEditForm');
                        //验证
                        if (!validator.formValidate($form)) {
                            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                            return;
                        }
                        var params = packFormParams($form);

                        ajax.post('${BASE_URL}${Url.DORMITORY_ROOM_ADD_URL}', params, function (data) {
                            ajaxReturn.data(data, $model, $dataGrid, true);
                        })
                    }
                });
            }
        );
    });

    //铺位查看
    $dataGridTable.find('tbody').on('click', '#berth', function () {
        var data = getRowData(this);
        var param = {
            BDR_ID: data.ID,
            TITLE: '室:' + data.BDR_NAME,
        };
        //切换主界面
        loadUrl('${BASE_URL}${fns:getUrlByMenuCode("DORMITORY:BERTH")}' + urlEncode(param));
    });

    //日志查看
    $dataGridTable.find('tbody').on('click', '#log', function () {
        var data = getRowData(this);
        var param = {
            BDR_ID: data.ID,
            TITLE: '室:' + data.BDR_NAME,
        };
        //切换主界面
        loadUrl('${BASE_URL}${fns:getUrlByMenuCode("DORMITORY:LOG")}' + urlEncode(param));
    });

    //修改
    $dataGridTable.find('tbody').on('click', '#edit', function () {
        var data = getRowData(this);
        var id = data.ID;

        ajax.getHtml('${BASE_URL}${Url.DORMITORY_ROOM_UPDATE_URL}/' + id, {}, function (html) {
                model.show({
                    title: '修改室',
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                    <shiro:hasPermission name="DORMITORY:ROOM_UPDATE_SAVE">
                    isConfirm: true,
                    confirm: function ($model) {
                        var $form = $('#addAndEditForm');
                        //验证
                        if (!validator.formValidate($form)) {
                            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                            return;
                        }
                        var params = packFormParams($form);

                        ajax.put('${BASE_URL}${Url.DORMITORY_ROOM_UPDATE_URL}', params, function (data) {
                            ajaxReturn.data(data, $model, $dataGrid, false);
                        });
                    }
                    </shiro:hasPermission>
                });
            }
        );
    });

    //删除
    $dataGridTable.find('tbody').on('click', '#del', function () {
        var data = getRowData(this);
        var id = data.ID;

        model.show({
            title: '删除室',
            content: '是否删除室:' + data.BDR_NAME,
            class: model.class.DANGER,
            okBtnName: model.btnName.DEL,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.del('${BASE_URL}${Url.DORMITORY_ROOM_DELETE_URL}/' + id, {}, function (data) {
                    ajaxReturn.data(data, $model, $dataGrid, false);
                })
            }
        });
    });
</script>