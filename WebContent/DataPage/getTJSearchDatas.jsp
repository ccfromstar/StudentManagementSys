<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<%@page import="java.sql.*;"%>
<jsp:useBean id="comlink" scope="page" class="org.stu.cn.CommonLink"></jsp:useBean>
<%
	//ȥ����
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<%
	//��ȡMySQL���ݿ��������ݣ���JSON��ʽ����
	//@param
	//1.tablename ����
	//2.colnum[] Ҫȡ�������������
	//3.wheres[] ��������
	//4.wherekey[] ������Ӧ��ֵ
	//��ȡGET����
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
	//���or����
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
	
	//��ȡ
	//1.page: ҳ�ţ���1���� 
	//2.rows: ÿҳ��¼��С�� 
	String jpage = request.getParameter("page");
	String jrows = request.getParameter("rows");
	Statement stmt = comlink.linkmySql();
	int count = 0; //������
	if (stmt != null) {
		ResultSet rs = stmt.executeQuery(sql);//ִ��sql���
		if (rs != null) {
			rs.last(); //�Ƶ����һ��   
			int rowCount = rs.getRow(); //�õ���ǰ�кţ�Ҳ���Ǽ�¼��   
			rs.beforeFirst(); //��Ҫ�õ���¼�����Ͱ�ָ�����Ƶ���ʼ����λ��  
			json = "{\"total\":" + String.valueOf(rowCount)
					+ ",\"rows\":[";
			//��������
			//��ʼ��¼��=(ҳ��-1)*ÿҳ��¼��С+1
			//������¼��
			//1.��ʼ��¼��+(ÿҳ��¼��С-1)>�ܼ�¼�� --------- �ܼ�¼��
			//2.��ʼ��¼��+(ÿҳ��¼��С-1)<�ܼ�¼�� --------- ��ʼ��¼��+(ÿҳ��¼��С-1)
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
