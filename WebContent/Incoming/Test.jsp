<%@ page language="java" contentType="text/html; charset=GB2312"
    pageEncoding="GB2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>Insert title here</title>
</head>
<body>
<% 
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
java.util.Date currentTime = new java.util.Date();//�õ���ǰϵͳʱ�� 

String str_date1 = formatter.format(currentTime); //������ʱ���ʽ�� 
out.print(str_date1);
String str_date2 = str_date1.toString(); //��Date������ʱ��ת�����ַ�����ʽ 
%> 
<input type="hidden" value=<%=str_date2 %> />
</body>
</html>