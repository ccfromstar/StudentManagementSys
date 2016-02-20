package org.stu.cn;

import java.sql.*;

public class CommonLink {
	/*
	 * bean功能:连接MySQL数据库
	 */
	public CommonLink(){
		
	}
	private Connection conn=null; // 数据库连接
	private Statement stmt=null; 
	public Statement linkmySql(){
		try {
			String driver="com.mysql.jdbc.Driver"; 
			Class.forName(driver);
			String url="jdbc:mysql://localhost:3306/student?useUnicode=true&characterEncoding=GBK"; // 数据库路径
			//String url="jdbc:mysql://114.80.156.98/sq_xfrsms?useUnicode=true&characterEncoding=GBK"; // 数据库路径
			try {
				conn=DriverManager.getConnection(url,"root","password");
				//conn=DriverManager.getConnection(url,"sq_xfrsms","xfrsms2012");
				stmt=conn.createStatement(); 
				return stmt;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return null;
			} // 获得连接
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		} // 加载驱动
		
	}
	
	
}
