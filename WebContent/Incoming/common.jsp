<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<%--1.加载JS库和样式表--%>
<link rel="stylesheet" type="text/css" href="theme/default/easyui.css">
<link rel="stylesheet" type="text/css" href="theme/icon.css">
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
<link href="theme/page.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="js/main.js"></script>
<script type="text/javascript" src="js/Calendar.js"></script>
<%--2.去除页面缓存--%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
