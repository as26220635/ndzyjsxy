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

<script>
    /**
     * 导出excel表格
     **/
    function exportData() {
        treeBox.init({
            title: '选择导出列',
            data:${EXPORT_LIST},
            okBtnName: model.btnName.EXPORT,
            isConfirm: true,
            confirm: function ($model, data) {
                if (data.length == 0) {
                    demo.showNotify(ALERT_WARNING, '请至少选择一项导出!');
                    return;
                }
                var columnIds = '';
                for (var i in data) {
                    var column = data[i];
                    if (i != 0) {
                        columnIds += SERVICE_SPLIT;
                    }
                    columnIds += column.id;
                }

                //导出
                window.location.href = '${EXPORT_URL}${MENU.ID}/' + columnIds + '?' + urlEncode(dataGridAjaxParams);
                model.hide($model);
            }
        });
    }
</script>