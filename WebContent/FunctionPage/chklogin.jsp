<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>����¼--ҳ����ת</title>
</head>
<body>
<%@page import="java.sql.*;"%>
<jsp:useBean id="comlink" scope="page" class="org.stu.cn.CommonLink"></jsp:useBean>
<%
	String userName = new String(request.getParameter("txtUsername")
			.getBytes("iso8859-1"), "GBK");
	String password = new String(request.getParameter("txtPass")
			.getBytes("iso8859-1"));

	String sql = "SELECT * FROM userinfo WHERE UserName ='" + userName
			+ "' AND UserPwd= '" + password + "'";
	Statement stmt = comlink.linkmySql();
	if (stmt != null) {
		ResultSet rs = stmt.executeQuery(sql);//ִ��sql���
		if (!rs.next()) {
			String errmsg = "error1";
			response.sendRedirect("../login.jsp?errmsg=" + errmsg);
			return;
		}
		request.getSession(true);
		String chk = "true";
		session.setAttribute("Enter", chk);
		session.setAttribute("userName", rs.getString("UserName"));
		session.setAttribute("userSite", rs.getString("UserSite"));
		session.setAttribute("userRole", rs.getString("UserRole"));
		if (rs.getString("UserRole").equals("����Ա")) {
			response.sendRedirect("../HomeAdmin.jsp");
		} else if (rs.getString("UserRole").equals("Ա��")){
			response.sendRedirect("../HomeStu.jsp");
		} else {
			response.sendRedirect("../Home.jsp");
		}
	}
%>
</body>
</html>