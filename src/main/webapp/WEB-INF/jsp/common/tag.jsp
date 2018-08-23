<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cn.kim.common.attr.Attribute " %>
<%@ page import="cn.kim.common.attr.AttributePath" %>
<%@ page import="cn.kim.common.attr.TableName " %>
<%@ page import="cn.kim.common.attr.Tips" %>
<%@ page import="cn.kim.common.eu.SystemEnum" %>
<%@ page import="cn.kim.common.eu.ProcessType" %>
<%@ page import="cn.kim.common.eu.AuthorizationType" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%--自定义--%>
<%@ taglib uri="/WEB-INF/tlds/fns.tld" prefix="fns" %>
<%@ taglib uri="/WEB-INF/tlds/tag.tld" prefix="s" %>
<%--标题参数--%>
<c:set var="HEAD_TITLE" value="XXXXXXXX"/>
<c:set var="LOGIN_TIPS_TITLE" value="XX"/>
<c:set var="MANAGER_HTML_MENU_SMALL_TITLE" value="<b>X</b>X"/>
<c:set var="MANAGER_HTML_MENU_NAME" value="菜单栏"/>
<%--js css版本--%>
<c:set var="VERSION" value="201802241536"/>
<%--pjax地址--%>
<c:set var="CONTAINER" value="container"/>
<%--URL地址--%>
<c:set var="BASE_URL" value="${pageContext.request.contextPath}/"/>