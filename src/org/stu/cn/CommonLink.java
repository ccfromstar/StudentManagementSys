package org.stu.cn;

import java.sql.*;

public class CommonLink {
	/*
	 * bean����:����MySQL���ݿ�
	 */
	public CommonLink(){
		
	}
	private Connection conn=null; // ���ݿ�����
	private Statement stmt=null; 
	public Statement linkmySql(){
		try {
			String driver="com.mysql.jdbc.Driver"; 
			Class.forName(driver);
			String url="jdbc:mysql://localhost:3306/student?useUnicode=true&characterEncoding=GBK"; // ���ݿ�·��
			//String url="jdbc:mysql://114.80.156.98/sq_xfrsms?useUnicode=true&characterEncoding=GBK"; // ���ݿ�·��
			try {
				conn=DriverManager.getConnection(url,"root","password");
				//conn=DriverManager.getConnection(url,"sq_xfrsms","xfrsms2012");
				stmt=conn.createStatement(); 
				return stmt;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return null;
			} // �������
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		} // ��������
		
	}
	
	
}
