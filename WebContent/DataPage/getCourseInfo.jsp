<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<%@page import="java.sql.*;"%>
<jsp:useBean id="comlink" scope="page" class="org.stu.cn.CommonLink"></jsp:useBean>
<%
	//��ȡ���ڼ�¼
	//@param
	//1.idstr ��¼������
	//2.tablename ����
	//3.colnum[] Ҫȡ�������������
	String json = null;
	String params[] = request.getParameter("params").split("@");
	//�û����
	String userid = params[0];
	String p0 = "0";
	String sql = null;
	Statement stmt = comlink.linkmySql();
	//����ѧԱ�Ƿ����
	sql = "SELECT * FROM stuinfo where StuCrdNo='" + userid
			+ "'";
	if (stmt != null) {
		ResultSet rs = stmt.executeQuery(sql);//ִ��sql���
		if (rs != null) {
			if (rs.next()) {
				p0 = "1";
			}
		}
	}
	int p1 = 0;
	int p2 = 0;int p3 = 0;int p4= 0;
	
	if (p0 == "1") {
		//�γ���
		String coursename = params[1];
		//���ҿγ̴���
		sql = "SELECT * FROM courseinfo where CourseName='" + coursename+ "'";
		if (stmt != null) {
			ResultSet rs = stmt.executeQuery(sql);//ִ��sql���
			if (rs != null) {
				if (rs.next()) {
					p1 = rs.getInt(3);
				}
			}
		}
		//���ҳ��ڴ���
		sql = "SELECT * FROM arrivedinfo where ArrNo='" + userid+ "' AND ArrCourse='"+coursename+"'";
		if (stmt != null) {
			ResultSet rs = stmt.executeQuery(sql);//ִ��sql���
			if (rs != null) {
				rs.last(); //�Ƶ����һ��   
				p2 = rs.getRow(); //�õ���ǰ�кţ�Ҳ���Ǽ�¼��   
			}
		}
		//������ٴ���
		sql = "SELECT * FROM leaveinfo where LeaveNo='" + userid+ "' AND LeaveCourse='"+coursename+"'";
		if (stmt != null) {
			ResultSet rs = stmt.executeQuery(sql);//ִ��sql���
			if (rs != null) {
				rs.last(); //�Ƶ����һ��   
				p3 = rs.getRow(); //�õ���ǰ�кţ�Ҳ���Ǽ�¼��   
			}
		}
		//���ҿ��δ���
		sql = "SELECT * FROM lossinfo where LossNo='" + userid+ "' AND LossCourse='"+coursename+"'";
		if (stmt != null) {
			ResultSet rs = stmt.executeQuery(sql);//ִ��sql���
			if (rs != null) {
				rs.last(); //�Ƶ����һ��   
				p4 = rs.getRow(); //�õ���ǰ�кţ�Ҳ���Ǽ�¼��   
			}
		}
		//ʣ��γ̴���
		p1 = p1-p2-p4;
	}
	json = "{\"p0\":\"" + p0 + "\",\"p1\":\"" + String.valueOf(p1) + "\",\"p2\":\"" + String.valueOf(p2) + "\",\"p3\":\"" + String.valueOf(p3) + "\",\"p4\":\"" + String.valueOf(p4) + "\"}";
	out.print(json);
%>
