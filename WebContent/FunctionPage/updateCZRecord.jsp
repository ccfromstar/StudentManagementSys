<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>���³�ֵ��¼</title>
</head>
<body>
<%@page import="java.sql.*;"%>
<jsp:useBean id="comlink" scope="page" class="org.stu.cn.CommonLink"></jsp:useBean>
<%
	//��MySQL���ݿ��и���һ����¼
	//@param
	//1.tablename Ҫ���¼�¼�ı���
	//2.fields[] Ҫ���µ��ֶ�����
	//3.postparams[] Ҫ���µ��ֶζ�Ӧ��POST������ֵ
	//4.types[] ��Ӧ���ֶε���������(0.--�ַ��� 1.--������ 2.--������)
	//5.returnpage �ص�ҳ��
	request.setCharacterEncoding("GBK");
	String tablename = request.getParameter("tablename1");
	String returnpage = request.getParameter("returnpage1");
	
	//����Ҫ������ֶκͶ�Ӧ��ֵ
	String fields[] = request.getParameter("fields1").split(";");
	String postparams[] = request.getParameter("postparams1").split(";");
	String types[] = request.getParameter("types1").split(";");
	int n1 = 0;
	String id = request.getParameter("id1");
	
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	java.util.Date currentTime = new java.util.Date();//�õ���ǰϵͳʱ�� 
	String str_date1 = formatter.format(currentTime); //������ʱ���ʽ�� 
	String str_date2 = str_date1.toString(); //��Date������ʱ��ת�����ַ�����ʽ 
	
	String czsql = "INSERT INTO moneyrecord(MoneyName,MoneyPrice,MoneyData,MoneySite)values('"+request.getParameter("stuname")+"',"+request.getParameter("czmoney1")+",'"+str_date2+"','"+request.getParameter("stusite")+"')";
	Statement stmt1 = comlink.linkmySql();
	if (stmt1 != null) {
		n1 = stmt1.executeUpdate(czsql);//ִ��sql���
	}
	String sql = "UPDATE "+tablename+" SET ";
	String tmpsql = null;
	for(int k=0;k<postparams.length;k++){
		String tmpval = request.getParameter(postparams[k]);
		if(types[k].equals("0")){
			tmpsql = fields[k]+"='"+tmpval+"'";
		}else if(types[k].equals("1")){
			tmpsql = fields[k]+"="+tmpval;
		}
		if(k==(postparams.length-1)){
			sql+=tmpsql;
		}else{
			sql+=tmpsql+",";
		}
	}
	sql+=" WHERE id=" + id;
			
	Statement stmt = comlink.linkmySql();
	if (stmt != null) {
		int n = stmt.executeUpdate(sql);//ִ��sql���
		if (n > 0 & n1 >0) {
			response.sendRedirect("../"+returnpage+"?info=5");
		} else {
			response.sendRedirect("../"+returnpage+"?info=6");
		}
	}
%>
</body>
</html>