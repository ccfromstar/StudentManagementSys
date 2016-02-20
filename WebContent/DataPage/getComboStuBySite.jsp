<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<%@page import="java.sql.*;"%>
<jsp:useBean id="comlink" scope="page" class="org.stu.cn.CommonLink"></jsp:useBean>
<%
	//去缓存
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<%
	//加载学员手机信息
	request.setCharacterEncoding("GBK");
	String json = null;
	String s = new String(request.getParameter("p").getBytes("iso8859-1"));

	String sql = "SELECT * FROM stuinfo where StuSite = '"+s+"'";
	
	Statement stmt = comlink.linkmySql();
	int count = 0; //计数器
	if (stmt != null) {
		ResultSet rs = stmt.executeQuery(sql);//执行sql语句
		if (rs != null) {
			rs.last(); //移到最后一行   
			int rowCount = rs.getRow(); //得到当前行号，也就是记录数   
			rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置  
			json = "[";
			while (rs.next()) {
				count++;
				String jsonrow = "{\"id\":\"" + rs.getString(3)
				+ "\",\"text\":\""+rs.getString(3)+"\"}";
				if (count == rowCount) {
					json += jsonrow;
				} else {
					json += jsonrow + ",";
				}
			}
			json += "]";
		}
	}
	out.print(json);
	
%>
