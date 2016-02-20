<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>添加消费记录</title>
</head>
<body>
<%@page import="java.sql.*;"%>
<jsp:useBean id="comlink" scope="page" class="org.stu.cn.CommonLink"></jsp:useBean>
<%
	//在MySQL数据库中添加一条记录
	//@param
	//1.tablename 要插入记录的表名
	//2.fields[] 要插入的字段数组
	//3.postparams[] 要插入的字段对应的POST参数的值
	//4.types[] 对应的字段的数据类型(0.--字符串 1.--数字型 2.--布尔型)
	//5.label 标志是否需要检查记录的唯一性(0.--不需要 1.--需要)
	//---如果参数5. == 1
	//---5-1.keyfield (对应的字段)
	//---5-2.keyvalue (对应的POST参数的值)
	//6.returnpage 回调页面
	request.setCharacterEncoding("GBK");
	String tablename = request.getParameter("tablename");
	String label = request.getParameter("label");
	String returnpage = request.getParameter("returnpage");
	String labels[] = label.split(";");
	int n1 = 0;
	if (labels[0].equals("1")) {
		String keyfield = labels[1];
		String keyvalue = request.getParameter(labels[2]);
		//根据keyfield检查记录是否存在
		String sqlcheck = "SELECT * FROM " + tablename + " where "
				+ keyfield + "='" + keyvalue + "'";
		Statement stmtcheck = comlink.linkmySql();
		if (stmtcheck != null) {
			ResultSet rs = stmtcheck.executeQuery(sqlcheck);//执行sql语句
			if (rs != null) {
				if (rs.next()) {
					response.sendRedirect("../" + returnpage
							+ "?info=99");
					return;
				}
			}
		}
	}

	//解析要插入的字段和对应的值
	String fields = request.getParameter("fields");
	String postparams[] = request.getParameter("postparams").split(";");
	String types[] = request.getParameter("types").split(";");

	//学员信息表余额要扣除
	//1.查找学员信息表的余额
	float leave = 0;
	//累计消费次数
	int times = 0;
	//累计消费金额
	float moneys =0;
	String sql1 = "SELECT * FROM stuinfo where StuCrdNo = '"
			+ request.getParameter("coststu1") + "'";
	Statement stmt1 = comlink.linkmySql();
	if (stmt1 != null) {
		ResultSet rs = stmt1.executeQuery(sql1);//执行sql语句
		if (rs.next()) {
			leave = rs.getFloat("StuCrdBalance");
			times = rs.getInt("CosNum");
			moneys = rs.getFloat("AccuCusMoney");
		}
	}
	//2.余额 = leave - 课程金额
	String courseprice = request.getParameter("costpay1");

	leave = leave - Float.valueOf(courseprice);
	times = times + 1;
	moneys = moneys + Float.valueOf(courseprice);
	
	if (leave < 0) {
		response.sendRedirect("../" + returnpage + "?info=100");
	} else {
		//学员卡里余额 = leave
		String sqlplus = "UPDATE stuinfo SET StuCrdBalance =" + String.valueOf(leave) +",CosNum="+times+",AccuCusMoney="+moneys+ " where StuCrdNo = '"
			+ request.getParameter("coststu1") + "'";;
		Statement stmtp = comlink.linkmySql();
		if (stmtp != null) {
			int n = stmtp.executeUpdate(sqlplus);//执行sql语句
			if (n > 0) {
				n1 = 1;
			}
		}
		
		String sql = "INSERT INTO " + tablename + "(" + fields
				+ ")values(";
		String tmpsql = null;
		for (int k = 0; k < postparams.length; k++) {
			String tmpval = request.getParameter(postparams[k]);
			if (types[k].equals("0")) {
				tmpsql = "'" + tmpval + "'";
			} else if (types[k].equals("1")) {
				tmpsql = tmpval;
			}
			if (k == (postparams.length - 1)) {
				sql += tmpsql;
			} else {
				sql += tmpsql + ",";
			}
		}
		sql += ")";

		Statement stmt = comlink.linkmySql();
		if (stmt != null) {
			int n = stmt.executeUpdate(sql);//执行sql语句
			if (n > 0 & n1 > 0) {
				response.sendRedirect("../" + returnpage + "?info=1");
			} else {
				response.sendRedirect("../" + returnpage + "?info=0");
			}
		}
	}
%>
</body>
</html>