<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<%@page import="java.sql.*;"%>
<jsp:useBean id="comlink" scope="page" class="org.stu.cn.CommonLink"></jsp:useBean>
<%
	//��ȡMySQL���ݿ��������ݣ���JSON��ʽ����
	//@param
	//1.tablename ����
	//2.colnum[] Ҫȡ�������������
	//��ȡGET����
	//String params = new String(request.getQueryString().getBytes("iso8859-1"));
	//String tmp[] = params.split("&p=");
	String talbename = new String(request.getParameter("p").getBytes("iso8859-1"));
	String colnum[] = new String(request.getParameter("q").getBytes("iso8859-1")).split("@");
	String site = new String(request.getParameter("r").getBytes("iso8859-1"),"GBK");
	String json = null;
	String sql = "SELECT * FROM " + talbename + " WHERE StuSite='"+site+"'";
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

			//�õ����������
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
					"MM-dd");
			java.util.Date currentTime = new java.util.Date();//�õ���ǰϵͳʱ�� 
			String str_date1 = formatter.format(currentTime); //������ʱ���ʽ�� 
			java.util.Date now1 = formatter.parse(str_date1);
			int i = 0;
			while (rs.next()) {
				i = 0;
				count++;
				String jsonrow = "";
				//����
				java.util.Date bri = formatter.parse(rs.getString(13).substring(5,10));
				long day = (bri.getTime() - now1.getTime())
						/ (24 * 60 * 60 * 1000);
				if (day < 7 & day > -1) {
					//�Ѿ������ˣ�����������

					String key = rs.getString(3);
					String sql1 = "SELECT * FROM smsrecord WHERE SMSName='"
							+ key + "' AND SMSType = '1'";
					Statement stmt1 = comlink.linkmySql();
					ResultSet rs1 = stmt1.executeQuery(sql1);//ִ��sql���
					if (rs1.next()) {
						i = 1;
					}
					if (i == 0) {
						String tmpJson = "";
						jsonrow = "{";
						for (int k = 0; k < colnum.length; k++) {
							if (Integer.parseInt(colnum[k]) != 13) {
								tmpJson = "\"p"
										+ k
										+ "\":\""
										+ rs.getString(Integer
												.parseInt(colnum[k]))
										+ "\"";
							} else {
								tmpJson = "\"p"
										+ k
										+ "\":\""
										+ rs.getString(Integer
												.parseInt(colnum[k])).substring(5,10)
										+ "\"";
							}
							if (k == colnum.length - 1) {
								jsonrow += tmpJson;
							} else {
								jsonrow += tmpJson + ",";
							}
						}
						jsonrow += "}";

						if ((count >= initCount) && (count <= endCount)) {
							if (count == endCount) {
								json += jsonrow;
							} else {
								json += jsonrow + ",";
							}
						}
						
					}
				}
			}
		}
	}
	json += "]}";
	
	json = json.replace(",]", "]");
	out.print(json);
%>
