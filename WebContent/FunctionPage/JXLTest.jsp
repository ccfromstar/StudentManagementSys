<%@ page language="java" contentType="text/html; charset=GB2312"
    pageEncoding="GB2312"%>
<%@ page import="org.stu.cn.JXLExcel"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>����Excel</title>
</head>
<body>
<%
	response.setContentType("application/vnd.ms-excel");
	JXLExcel excel=new JXLExcel();
	excel.exportExcel("ѧԱ��Ϣ��",response.getOutputStream());
%>
</body>
</html>
