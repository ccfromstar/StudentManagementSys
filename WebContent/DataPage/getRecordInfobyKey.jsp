<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<%@page import="java.sql.*;"%>
<jsp:useBean id="comlink" scope="page" class="org.stu.cn.CommonLink"></jsp:useBean>
<%
	//根据条件读取要编辑的记录信息
	//@param
	//1.idstr 记录的主键
	//2.tablename 表名
	//3.colnum[] 要取出的列序号数组
	String json = null;
	String s = request.getParameter("params");
	//String s = new String(request.getParameter("params").getBytes("iso8859-1"));
	//System.out.println(s);
	String params[] = s.split(";");
	String idstr[] = params[0].split("@");
	String tablename = params[1];
	String colnum[] = params[2].split("@");
	
	String key[] = params[3].split("@");
	
	String sql = "";
	if(key.length==1){
		sql = "SELECT * FROM "+tablename+" where "+key[0]+" = '" + idstr[0] + "'";
	}else if(key.length==2){
		sql = "SELECT * FROM "+tablename+" where "+key[0]+" = '" + idstr[0] + "' AND "+key[1]+" = '" + idstr[1] + "'";
	}
	
	//System.out.println(sql);
	Statement stmt = comlink.linkmySql();
	if (stmt != null) {
		ResultSet rs = stmt.executeQuery(sql);//执行sql语句
		if (rs != null) {
			while (rs.next()) {
				json = "{";
				for(int k=0;k<colnum.length;k++){
					String tmpJson = "\"p"+(k+1)+"\":\"" + rs.getString(Integer.parseInt(colnum[k]))+ "\"";
					if(k == colnum.length-1){
						json += tmpJson;
					}else{
						json += tmpJson + ",";
					}
				}
				json += "}";
			}
		}
	}
	out.print(json);
%>
