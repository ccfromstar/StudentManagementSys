<%@ page language="java" contentType="text/html; charset=GB2312"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>系统注销</title>
</head>
<body>
<%
request.getSession(true);
session.removeAttribute("Enter");
session.removeAttribute("userName");
session.removeAttribute("userSite");
session.removeAttribute("userRole");
response.sendRedirect("../login.jsp");
%>
</body>
</html>