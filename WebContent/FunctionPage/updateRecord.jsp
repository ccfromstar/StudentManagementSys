<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>更新记录</title>
</head>
<body>
<%@page import="java.sql.*;"%>
<jsp:useBean id="comlink" scope="page" class="org.stu.cn.CommonLink"></jsp:useBean>
<%
	//在MySQL数据库中更新一条记录
	//@param
	//1.tablename 要更新记录的表名
	//2.fields[] 要更新的字段数组
	//3.postparams[] 要更新的字段对应的POST参数的值
	//4.types[] 对应的字段的数据类型(0.--字符串 1.--数字型 2.--布尔型)
	//5.returnpage 回调页面
	request.setCharacterEncoding("GBK");
	String tablename = request.getParameter("tablename1");
	String returnpage = request.getParameter("returnpage1");
	
	//解析要插入的字段和对应的值
	String fields[] = request.getParameter("fields1").split(";");
	String postparams[] = request.getParameter("postparams1").split(";");
	String types[] = request.getParameter("types1").split(";");
	
	String id = request.getParameter("id1");
	
	String sql = "UPDATE "+tablename+" SET ";
	String tmpsql = null;
	for(int k=0;k<postparams.length;k++){
		String tmpval = request.getParameter(postparams[k]);
		if(types[k].equals("0")){
			tmpsql = fields[k]+"='"+tmpval+"'";
		}else if(types[k].equals("1")){
			tmpsql = fields[k]+"="+tmpval;
		}
		if(k==(postparams.length-1)){
			sql+=tmpsql;
		}else{
			sql+=tmpsql+",";
		}
	}
	sql+=" WHERE id=" + id;
			
	Statement stmt = comlink.linkmySql();
	if (stmt != null) {
		int n = stmt.executeUpdate(sql);//执行sql语句
		if (n > 0) {
			response.sendRedirect("../"+returnpage+"?info=5");
		} else {
			response.sendRedirect("../"+returnpage+"?info=6");
		}
	}
%>
</body>
</html>