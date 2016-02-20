package org.stu.cn;

import java.sql.*;
import java.io.*;
import jxl.*;
import jxl.write.*;
public class JXLExcel {
	/*
	 * ����jxl����Excel��
	 */
	public JXLExcel(){
		
	}
	public void exportExcel(String name,OutputStream os){
		try{
			CommonLink comlink = new CommonLink();
			WritableWorkbook wwb=Workbook.createWorkbook(os);
			//һ���ǹ���������ƣ���һ���ǹ������ڹ������е�λ��
			WritableSheet ws=wwb.createSheet(name,0);
			ws.addCell(new Label(0,1,"ѧԱ����"));
			ws.addCell(new Label(1,1,"ѧԱ����"));
			ws.addCell(new Label(2,1,"�Ա�"));
			ws.addCell(new Label(3,1,"��������"));
			ws.addCell(new Label(4,1,"������"));
			ws.addCell(new Label(5,1,"���ڽ��"));
			ws.addCell(new Label(6,1,"���ѽ��"));
			ws.addCell(new Label(7,1,"��ѧ��"));
			String sql = "SELECT * FROM stuinfo";
			Statement stmt = comlink.linkmySql();
			if (stmt != null) {
				ResultSet rs = stmt.executeQuery(sql);//ִ��sql���
				int nRow=2;
				while(rs.next()){
					ws.addCell(new Label(0,nRow,rs.getString("StuCrdNo")));
					ws.addCell(new Label(1,nRow,rs.getString("StuName")));
					ws.addCell(new Label(2,nRow,rs.getString("StuSex")));
					ws.addCell(new Label(3,nRow,rs.getString("StuCrdCreateDate")));
					ws.addCell(new Label(4,nRow,rs.getString("StuCrdType")));
					ws.addCell(new Label(5,nRow,rs.getString("StuCrdBalance")));
					ws.addCell(new Label(6,nRow,rs.getString("AccuCusMoney")));
					ws.addCell(new Label(7,nRow,rs.getString("StuSite")));
					nRow++;
				}
			}
			wwb.write();
			wwb.close();
		}catch(Exception e){
			System.out.println("JXLEXcel.exportExcel()"+e.getMessage());
		}
	}
}

