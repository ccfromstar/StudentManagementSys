<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<%@page import="java.sql.*;"%>
<jsp:useBean id="comlink" scope="page" class="org.stu.cn.CommonLink"></jsp:useBean>
<%
	//ȥ����
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<%
	//����ѧԱ����Ϣ
	String json = null;
	String sql = "SELECT * FROM cardinfo";
	Statement stmt = comlink.linkmySql();
	String oldstr = "";
	int count = 0; //������
	if (stmt != null) {
		ResultSet rs = stmt.executeQuery(sql);//ִ��sql���
		if (rs != null) {
			rs.last(); //�Ƶ����һ��   
			int rowCount = rs.getRow(); //�õ���ǰ�кţ�Ҳ���Ǽ�¼��   
			rs.beforeFirst(); //��Ҫ�õ���¼�����Ͱ�ָ�����Ƶ���ʼ����λ��  
			json = "[";
			while (rs.next()) {
				count++;
				//�ж�������ظ��ľ�ȥ��
				if (!oldstr.contains(rs.getString(2))) {
					String jsonrow = "{\"id\":\"" + rs.getString(2)
							+ "\",\"text\":\"" + rs.getString(2)
							+ "\"}";
					oldstr = oldstr + rs.getString(2);
					//if () {
					//	json += jsonrow;
					//} else {
						json += jsonrow + ",";
					//}
				}
			}
			json += "]";
		}
	}
	json = json.replace(",]","]");
	out.print(json);
%>
