<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<%@page import="java.sql.*;"%>
<jsp:useBean id="comlink" scope="page" class="org.stu.cn.CommonLink"></jsp:useBean>
<%
	//去缓存
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<%
	//读取MySQL数据库表里的数据，以JSON格式返回
	//@param
	//1.tablename 表名
	//2.colnum[] 要取出的列序号数组
	//3.wheres[] 搜索条件
	//4.wherekey[] 条件不应的值
	//读取GET参数
	request.setCharacterEncoding("GBK");
	String params = request.getQueryString();
	String tmp[] = params.split("&p=");
	String talbename = tmp[1];
	String colnum[] = tmp[2].split("@");
	String wheres[] = tmp[3].split("@");
	String and[] = tmp[4].split("@");
	String wherekey[] = java.net.URLDecoder.decode(tmp[4],"utf-8").split("@");
	String json = null;
	
	System.out.println(and[0]+and[1]);
	
	String sql = "SELECT * FROM " + talbename + " where ";
	
	sql = sql + "(";
	//添加or条件
	for(int i=0;i<wheres.length;i++){
		String tmpSql = wheres[i]+" = '"+wherekey[i]+"'";
		if(i==0){
			sql+=tmpSql;
		}else{
			sql+=" or "+tmpSql;
		}
	}
	sql = sql + ")";
	
	System.out.println(sql);
	
	//读取
	//1.page: 页号，从1计起。 
	//2.rows: 每页记录大小。 
	String jpage = request.getParameter("page");
	String jrows = request.getParameter("rows");
	Statement stmt = comlink.linkmySql();
	int count = 0; //计数器
	if (stmt != null) {
		ResultSet rs = stmt.executeQuery(sql);//执行sql语句
		if (rs != null) {
			rs.last(); //移到最后一行   
			int rowCount = rs.getRow(); //得到当前行号，也就是记录数   
			rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置  
			json = "{\"total\":" + String.valueOf(rowCount)
					+ ",\"rows\":[";
			//返回数据
			//初始记录数=(页号-1)*每页记录大小+1
			//结束记录数
			//1.初始记录数+(每页记录大小-1)>总记录数 --------- 总记录数
			//2.初始记录数+(每页记录大小-1)<总记录数 --------- 初始记录数+(每页记录大小-1)
			int initCount = (Integer.parseInt(jpage) - 1)
					* Integer.parseInt(jrows) + 1;
			int endCount = 0;
			if (initCount + (Integer.parseInt(jrows) - 1) > rowCount) {
				endCount = rowCount;
			} else {
				endCount = initCount + (Integer.parseInt(jrows) - 1);
			}
			while (rs.next()) {
				count++;
				String jsonrow = "{";
				for(int k=0;k<colnum.length;k++){
					String tmpJson = "\"p"+k+"\":\"" + rs.getString(Integer.parseInt(colnum[k]))+ "\"";
					if(k == colnum.length-1){
						jsonrow += tmpJson;
					}else{
						jsonrow += tmpJson + ",";
					}
				}
				jsonrow += "}";

				if((count>=initCount)&&(count<=endCount)){
					if (count == endCount) {
						json += jsonrow;
					} else {
						json += jsonrow + ",";
					}	
				}
			}
			json += "]}";
		}
	}
	out.print(json);
%>
