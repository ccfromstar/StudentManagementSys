<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>��Ӽ�¼</title>
</head>
<body>
<%@page import="java.sql.*;"%>
<jsp:useBean id="comlink" scope="page" class="org.stu.cn.CommonLink"></jsp:useBean>
<%
	//��MySQL���ݿ������һ����¼
	//@param
	//1.tablename Ҫ�����¼�ı���
	//2.fields[] Ҫ������ֶ�����
	//3.postparams[] Ҫ������ֶζ�Ӧ��POST������ֵ
	//4.types[] ��Ӧ���ֶε���������(0.--�ַ��� 1.--������ 2.--������)
	//5.label ��־�Ƿ���Ҫ����¼��Ψһ��(0.--����Ҫ 1.--��Ҫ)
	//---�������5. == 1
	//---5-1.keyfield (��Ӧ���ֶ�)
	//---5-2.keyvalue (��Ӧ��POST������ֵ)
	//6.returnpage �ص�ҳ��
	request.setCharacterEncoding("GBK");
	String tablename = request.getParameter("tablename");
	String label = request.getParameter("label");
	String returnpage = request.getParameter("returnpage");
	String labels[] = label.split(";");
	if (labels[0].equals("1")) {
		String keyfield = labels[1];
		String keyvalue = request.getParameter(labels[2]);
		//����keyfield����¼�Ƿ����
		String sqlcheck = "SELECT * FROM " + tablename + " where "
				+ keyfield + "='" + keyvalue + "'";
		Statement stmtcheck = comlink.linkmySql();
		if (stmtcheck != null) {
			ResultSet rs = stmtcheck.executeQuery(sqlcheck);//ִ��sql���
			if (rs != null) {
				if (rs.next()) {
					response.sendRedirect("../" + returnpage
							+ "?info=99");
					return;
				}
			}
		}
	}
	
	//����Ҫ������ֶκͶ�Ӧ��ֵ
	String fields = request.getParameter("fields");
	String postparams[] = request.getParameter("postparams").split(";");
	String types[] = request.getParameter("types").split(";");

	String sql = "INSERT INTO "+tablename+"(" + fields + ")values(";
	String tmpsql = null;
	for(int k=0;k<postparams.length;k++){
		String tmpval = request.getParameter(postparams[k]);
		if(types[k].equals("0")){
			tmpsql = "'"+tmpval+"'";
		}else if(types[k].equals("1")){
			tmpsql = tmpval;
		}
		if(k==(postparams.length-1)){
			sql+=tmpsql;
		}else{
			sql+=tmpsql+",";
		}
	}
	sql+=")"; 
	//System.out.println(sql);
	

	Statement stmt = comlink.linkmySql();
	if (stmt != null) {
		int n = stmt.executeUpdate(sql);//ִ��sql���
		if (n > 0) {
			response.sendRedirect("../" + returnpage + "?info=1");
		} else {
			response.sendRedirect("../" + returnpage + "?info=0");
		}
	}
%>
</body>
</html>