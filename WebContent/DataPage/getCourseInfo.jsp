<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<%@page import="java.sql.*;"%>
<jsp:useBean id="comlink" scope="page" class="org.stu.cn.CommonLink"></jsp:useBean>
<%
	//读取考勤记录
	//@param
	//1.idstr 记录的主键
	//2.tablename 表名
	//3.colnum[] 要取出的列序号数组
	String json = null;
	String params[] = request.getParameter("params").split("@");
	//用户编号
	String userid = params[0];
	String p0 = "0";
	String sql = null;
	Statement stmt = comlink.linkmySql();
	//查找学员是否存在
	sql = "SELECT * FROM stuinfo where StuCrdNo='" + userid
			+ "'";
	if (stmt != null) {
		ResultSet rs = stmt.executeQuery(sql);//执行sql语句
		if (rs != null) {
			if (rs.next()) {
				p0 = "1";
			}
		}
	}
	int p1 = 0;
	int p2 = 0;int p3 = 0;int p4= 0;
	
	if (p0 == "1") {
		//课程名
		String coursename = params[1];
		//查找课程次数
		sql = "SELECT * FROM courseinfo where CourseName='" + coursename+ "'";
		if (stmt != null) {
			ResultSet rs = stmt.executeQuery(sql);//执行sql语句
			if (rs != null) {
				if (rs.next()) {
					p1 = rs.getInt(3);
				}
			}
		}
		//查找出勤次数
		sql = "SELECT * FROM arrivedinfo where ArrNo='" + userid+ "' AND ArrCourse='"+coursename+"'";
		if (stmt != null) {
			ResultSet rs = stmt.executeQuery(sql);//执行sql语句
			if (rs != null) {
				rs.last(); //移到最后一行   
				p2 = rs.getRow(); //得到当前行号，也就是记录数   
			}
		}
		//查找请假次数
		sql = "SELECT * FROM leaveinfo where LeaveNo='" + userid+ "' AND LeaveCourse='"+coursename+"'";
		if (stmt != null) {
			ResultSet rs = stmt.executeQuery(sql);//执行sql语句
			if (rs != null) {
				rs.last(); //移到最后一行   
				p3 = rs.getRow(); //得到当前行号，也就是记录数   
			}
		}
		//查找旷课次数
		sql = "SELECT * FROM lossinfo where LossNo='" + userid+ "' AND LossCourse='"+coursename+"'";
		if (stmt != null) {
			ResultSet rs = stmt.executeQuery(sql);//执行sql语句
			if (rs != null) {
				rs.last(); //移到最后一行   
				p4 = rs.getRow(); //得到当前行号，也就是记录数   
			}
		}
		//剩余课程次数
		p1 = p1-p2-p4;
	}
	json = "{\"p0\":\"" + p0 + "\",\"p1\":\"" + String.valueOf(p1) + "\",\"p2\":\"" + String.valueOf(p2) + "\",\"p3\":\"" + String.valueOf(p3) + "\",\"p4\":\"" + String.valueOf(p4) + "\"}";
	out.print(json);
%>
