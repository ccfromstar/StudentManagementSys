<%@ page language="java" contentType="text/html; charset=GB2312"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>Insert title here</title>
</head>
<body>
<%
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("MM-dd"); 
java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
String str_date1 = formatter.format(currentTime); //将日期时间格式化 
java.util.Date now1 = formatter.parse(str_date1);
//生日
String str = "09-25";
java.util.Date bri = formatter.parse(str);
long day = (bri.getTime()-now1.getTime())/(24*60*60*1000)>0 ? (bri.getTime()-now1.getTime())/(24*60*60*1000):   (now1.getTime()-bri.getTime())/(24*60*60*1000);
out.println(day);
%>
</body>
</html>