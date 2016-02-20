<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>删除记录</title>
</head>
<body>
<%@page import="java.sql.*;"%>
<jsp:useBean id="comlink" scope="page" class="org.stu.cn.CommonLink"></jsp:useBean>
<%
	//在MySQL数据库中删除一条记录
	//@param
	//1.deltablename 要删除记录的表名
	//2.id[] 要删除的记录的主键数组
	//3.delreturnpage 回调页面
	request.setCharacterEncoding("GBK");
	String idstr = request.getParameter("idstr");
	String deltablename = request.getParameter("deltablename");
	String delreturnpage = request.getParameter("delreturnpage");
	String id[] = idstr.split(";");
	int len = id.length;
	Statement stmt = comlink.linkmySql();
	if (stmt != null) {
		for (int i = 0; i < len; i++) {
			String sql = "Delete FROM "+deltablename+" where id=" + id[i];
			int n = stmt.executeUpdate(sql);//执行sql语句
			if (n < 1) {
				response.sendRedirect("../"+delreturnpage+"?info=3");
				return;
			}
		}
		response.sendRedirect("../"+delreturnpage+"?info=4");
	}
%>
</body>
</html>