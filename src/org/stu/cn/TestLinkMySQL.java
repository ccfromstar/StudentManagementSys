package org.stu.cn;

import java.sql.DriverManager;
import java.sql.SQLException;

import java.sql.*;

import org.json.*;
 

public class TestLinkMySQL {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		JSONObject a = new JSONObject();  
		Connection conn=null; //���ݿ����� 
		Statement stmt=null; 
		ResultSet rs = null; //��ѯ��� 
		try {
			String driver="com.mysql.jdbc.Driver"; 
			Class.forName(driver);
			String url="jdbc:mysql://localhost:3306/student"; //���ݿ�·��
			String sql="SELECT * FROM userinfo"; 
			try {
				conn=DriverManager.getConnection(url,"root","password");
				stmt=conn.createStatement(); 
				rs=stmt.executeQuery(sql);//ִ��sql���
				if(rs!=null){
					while(rs.next()){ 
						System.out.println(rs.getString("UserSite"));
						System.out.println(rs.getString("Id"));
					}
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} //�������
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} //�������� 
	}

}
