<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<%@page import="java.sql.*;"%>
<jsp:useBean id="comlink" scope="page" class="org.stu.cn.CommonLink"></jsp:useBean>
<%
	//��ȡ��ѧ����Ϣ��
	String json = null;
	String sql = "SELECT * FROM siteinfo";
	Statement stmt = comlink.linkmySql();
	int count = 0; //������
	if (stmt != null) {
		ResultSet rs = stmt.executeQuery(sql);//ִ��sql���
		if (rs != null) {
			rs.last(); //�Ƶ����һ��   
			int rowCount = rs.getRow(); //�õ���ǰ�кţ�Ҳ���Ǽ�¼��   
			rs.beforeFirst(); //��Ҫ�õ���¼�����Ͱ�ָ�����Ƶ���ʼ����λ��  
			json = "{\"total\":" + String.valueOf(rowCount)
					+ ",\"rows\":[";
			while (rs.next()) {
				count++;
				String jsonrow = "{\"code\":\"" + rs.getString(1)
						+ "\",\"name\":\"" + rs.getString(2) + "\"}";
				if (count == rowCount) {
					json += jsonrow;
				} else {
					json += jsonrow + ",";
				}
			}
			json += "]}";
		}
	}
	out.print(json);
%>
