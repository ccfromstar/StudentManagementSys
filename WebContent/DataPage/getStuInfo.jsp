<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<%@page import="java.sql.*;"%>
<jsp:useBean id="comlink" scope="page" class="org.stu.cn.CommonLink"></jsp:useBean>
<%
	//��ȡѧԱ��¼
	//@param
	//1.idstr ��¼������
	//2.tablename ����
	//3.colnum[] Ҫȡ�������������
	String json = null;
	String params[] = request.getParameter("params").split(";");
	String idstr = params[0];
	String tablename = params[1];
	String colnum[] = params[2].split("@");
	String sql = "SELECT * FROM "+tablename+" where StuCrdNo='" + idstr+"'";
	Statement stmt = comlink.linkmySql();
	if (stmt != null) {
		ResultSet rs = stmt.executeQuery(sql);//ִ��sql���
		if (rs != null) {
			if (rs.next()) {
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
			}else{
				json = "{\"p1\":\"0\"}";
			}
		}
	}
	out.print(json);
%>
