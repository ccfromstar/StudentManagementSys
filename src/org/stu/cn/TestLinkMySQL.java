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
		Connection conn=null; //数据库连接 
		Statement stmt=null; 
		ResultSet rs = null; //查询结果 
		try {
			String driver="com.mysql.jdbc.Driver"; 
			Class.forName(driver);
			String url="jdbc:mysql://localhost:3306/student"; //数据库路径
			String sql="SELECT * FROM userinfo"; 
			try {
				conn=DriverManager.getConnection(url,"root","password");
				stmt=conn.createStatement(); 
				rs=stmt.executeQuery(sql);//执行sql语句
				if(rs!=null){
					while(rs.next()){ 
						System.out.println(rs.getString("UserSite"));
						System.out.println(rs.getString("Id"));
					}
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} //获得连接
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} //加载驱动 
	}

}
