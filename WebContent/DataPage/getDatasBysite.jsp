<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<%@page import="java.sql.*;"%>
<jsp:useBean id="comlink" scope="page" class="org.stu.cn.CommonLink"></jsp:useBean>
<%
	//读取MySQL数据库表里的数据，以JSON格式返回
	//@param
	//1.tablename 表名
	//2.colnum[] 要取出的列序号数组
	//读取GET参数
	//String params = request.getQueryString();
	//String tmp[] = params.split("&p=");
	String talbename = new String(request.getParameter("p").getBytes("iso8859-1"));
	String colnum[] = new String(request.getParameter("q").getBytes("iso8859-1")).split("@");
	String sitename = new String(request.getParameter("r").getBytes("iso8859-1"));
	String site = new String(request.getParameter("s").getBytes("iso8859-1"),"GBK");
	String json = null;
	String sql = "SELECT * FROM " + talbename + " where " + sitename + " = '"+site+"'";
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
