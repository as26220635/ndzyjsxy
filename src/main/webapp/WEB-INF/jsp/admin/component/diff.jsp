<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2018/8/20
  Time: 19:09
  To change this template use File | Settings | File Templates.
  文本比对
--%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript"
        src="${BASE_URL}resources/static/plugins/mergely/lib/codemirror/codemirror.min.js?ver=${VERSION}"></script>
<script type="text/javascript"
        src="${BASE_URL}resources/static/plugins/mergely/lib/codemirror/searchcursor.min.js?ver=${VERSION}"></script>
<script type="text/javascript" src="${BASE_URL}resources/static/plugins/mergely/lib/mergely.js?ver=${VERSION}"></script>
<link rel="stylesheet" href="${BASE_URL}resources/static/plugins/mergely/lib/codemirror/codemirror.css?ver=${VERSION}"/>
<link rel="stylesheet" media="all" href="${BASE_URL}resources/static/plugins/mergely/lib/mergely.css?ver=${VERSION}"/>

<div class="row">
    <div class="mergely-full-screen-8">
        <div class="mergely-resizer">
            <div id="mergely"></div>
        </div>
    </div>
</div>


<script>
    $('#mergely').parents('.modal-body:first').css('height','400px');
    $('#mergely').mergely({
        editor_width: "400px",
        editor_height: "400px",
        lhs: function (setValue) {
            setValue('${oldValue}');
        },
        rhs: function (setValue) {
            setValue('${newValue}');
        }
    });

    setTimeout(function () {
        $('#mergely-splash').click();
        $('#mergely').mergely('resize');
    }, 500);

</script>