<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
	<%@page import="java.sql.*"%>
<jsp:useBean id="comlink" scope="page" class="org.stu.cn.CommonLink"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.ArrayList"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>�ʼ���������</title>
<jsp:include page="Incoming/common.jsp"></jsp:include>
<style>
div#topiclist table {
	border: 1px solid #ccc;
	padding: 1px;
	vertical-align: middle;
}
div#topiclist td {
	border: 1px solid #ccc;
	padding: 1px;
	text-align: left;
	vertical-align: middle;
}
</style>
<%
//�����������Ϣ
String idstr = request.getParameter("p");
String p0 = null;String p1 = null;String p2 = null;String p3 = null;
String html = "";
ArrayList<String> al = new ArrayList<String>();
ArrayList<String> bl = new ArrayList<String>();
ArrayList<String> cl = new ArrayList<String>();
String sql = "SELECT * FROM mailinfo where id=" + idstr;
Statement stmt = comlink.linkmySql();
if (stmt != null) {
	ResultSet rs = stmt.executeQuery(sql);//ִ��sql���
	if (rs != null) {
		if (rs.next()) {
			p0 = rs.getString(2);
			p1 = rs.getString(3);
			p2 = rs.getString(4);
			p3 = rs.getString(5);
		}
	}
}

%>
<script>
$(function(){
			var s="<%=session.getAttribute("Enter")%>"; 
			checkuserTime(s);
			//�ж��û�����
			var info = <%=request.getQueryString()%>;
			//���������б�
			var txtHTML;
			//�����������
			txtHTML = "<table width='97%' border='1'>";
			txtHTML = txtHTML +	"<tr align='left'><td><font style='color:blue'><b>����:</b></font><%=p0%><br/><font style='color:blue'><b>����:</b></font><%=p1%><br/><font style='color:blue'><b>������:</b></font><%=p2%><br/><font style='color:blue'><b>��������:</b></font><%=p3%></td></tr>";
			txtHTML = txtHTML + "</table>";
			//�ҵ��������µ����лظ�
			txtHTML = txtHTML + "<%=html%>";
			$("#topiclist").html(txtHTML);	
			
			//��ӻظ�
			$("#adduser").click(function(){
				if($("textarea[name='topicmain']").val()==""){
					$.messager.alert('��ʾ','�ظ����ݲ���Ϊ��!','warning');return false;
				}
				$("input[name='topicdate']").val($("#dat").text());
				document.userform.submit();
			});		
		});
</script>
</head>
<body onload="loading()">
<jsp:include page="Incoming/loading.jsp"></jsp:include>
<% 
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
java.util.Date currentTime = new java.util.Date();//�õ���ǰϵͳʱ�� 
String str_date1 = formatter.format(currentTime); //������ʱ���ʽ�� 
String str_date2 = str_date1.toString(); //��Date������ʱ��ת�����ַ�����ʽ 
%> 
<div class="easyui-layout" id="layoutmain" style="width:100%;height:100%;visibility: hidden">
<div id="view" region="north" title="�ʼ���������" split="true"
	style="height: 500px; overflow: auto;text-align:center">
	<div id="topiclist"></div>
</div>
<div id="form1" region="center" title=""  split="true" style="overflow: hidden;display:none">
<table id="test"></table>
<form name="userform" method="post" action="FunctionPage/insertResponse.jsp"
	id="userform" style="padding: 5px; margin: 5px;">
<table border="1" width="98%">
	<tr>
		<td colspan="4"><div style="width:100%;text-align:left;"><textarea name="topicmain" class="easyui-validatebox" style="height:40px;width:700px"></textarea></div></td>
	</tr>
	<tr>
		<td width="100px">�ظ���:</td>
		<td width="150px" ><div style="width:100%;color: blue;text-align:left;"><%=session.getAttribute("userName")%></div></td>
		<td width="100px">�ظ�����:</td>
		<td><div id="dat" style="width:100%;color: blue;text-align:left;"><%=str_date2 %></div></td>
	</tr>
</table>
<a class="easyui-linkbutton" id="adduser" icon="icon-add"
	href="javascript:void(0)">�ظ�</a>
	<input type="hidden" name="topicperson" value=<%=session.getAttribute("userName") %> />
	<input type="hidden" name="parentid" value=<%=idstr%> />
	<input type="hidden" name="topicdate" />
	
	<input type="hidden" name="tablename" value="responseinfo" />
	<input type="hidden" name="label" value="0" />
	<input type="hidden" name="returnpage" value = "Topic.jsp?p=<%=idstr%>" />
	<input type="hidden" name="fields" value="ResponseMain,ResponsePerson,ResponseData,ParentID" />
	<input type="hidden" name="postparams" value="topicmain;topicperson;topicdate;parentid" />
	<input type="hidden" name="types" value="0;0;0;1" />
</form>
</div>
</div>
<div id="w" class="easyui-window" closed="true" title="�޸�ѧԱ����Ϣ"
	icon="icon-save"
	style="width: 520px; height: 190px; padding: 5px; background: #fafafa;">
<div class="easyui-layout" fit="true">
<div region="center" border="false"
	style="padding: 10px; background: #fff; border: 1px solid #ccc;">
<form name="updateinfo" method="post"
	action="FunctionPage/updateRecord.jsp" id="updateinfo" >
<table border="1" width="450px">
	<tr>
		<td width="70px">ѧԱ������</td>
		<td><input type="text" name="cardname1" class="easyui-validatebox"
			required="true" readonly /></td>
		<td width="60px">�ۿ���</td>
		<td><input type="text" name="cardrate1"
			class="easyui-validatebox" required="true" /></td>
	</tr>
</table>
<input type="hidden" name="id1"/>
<input type="hidden" name="tablename1" value="cardinfo" />
<input type="hidden" name="returnpage1" value = "CardOption.jsp" />
<input type="hidden" name="fields1" value="CardName;CardRate" />
<input type="hidden" name="postparams1" value="cardname1;cardrate1" />
<input type="hidden" name="types1" value="0;1" />
</form>
</div>
<div region="south" border="false"
	style="text-align: right; height: 30px; line-height: 30px;"><a
	class="easyui-linkbutton" id="update1" icon="icon-ok" href="javascript:void(0)"
	>�޸�</a> <a class="easyui-linkbutton"
	icon="icon-cancel" href="javascript:void(0)"
	onclick="$('#w').window('close');">ȡ��</a></div>
</div>
</div>
</body>
</html>