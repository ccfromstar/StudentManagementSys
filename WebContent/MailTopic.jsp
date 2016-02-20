<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
	<%@page import="java.sql.*"%>
<jsp:useBean id="comlink" scope="page" class="org.stu.cn.CommonLink"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.ArrayList"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>邮件主题内容</title>
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
//查找主题的信息
String idstr = request.getParameter("p");
String p0 = null;String p1 = null;String p2 = null;String p3 = null;
String html = "";
ArrayList<String> al = new ArrayList<String>();
ArrayList<String> bl = new ArrayList<String>();
ArrayList<String> cl = new ArrayList<String>();
String sql = "SELECT * FROM mailinfo where id=" + idstr;
Statement stmt = comlink.linkmySql();
if (stmt != null) {
	ResultSet rs = stmt.executeQuery(sql);//执行sql语句
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
			//判断用户操作
			var info = <%=request.getQueryString()%>;
			//加载主题列表
			var txtHTML;
			//先添加主帖子
			txtHTML = "<table width='97%' border='1'>";
			txtHTML = txtHTML +	"<tr align='left'><td><font style='color:blue'><b>主题:</b></font><%=p0%><br/><font style='color:blue'><b>内容:</b></font><%=p1%><br/><font style='color:blue'><b>发件人:</b></font><%=p2%><br/><font style='color:blue'><b>发送日期:</b></font><%=p3%></td></tr>";
			txtHTML = txtHTML + "</table>";
			//找到该主题下的所有回复
			txtHTML = txtHTML + "<%=html%>";
			$("#topiclist").html(txtHTML);	
			
			//添加回复
			$("#adduser").click(function(){
				if($("textarea[name='topicmain']").val()==""){
					$.messager.alert('提示','回复内容不能为空!','warning');return false;
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
java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
String str_date1 = formatter.format(currentTime); //将日期时间格式化 
String str_date2 = str_date1.toString(); //将Date型日期时间转换成字符串形式 
%> 
<div class="easyui-layout" id="layoutmain" style="width:100%;height:100%;visibility: hidden">
<div id="view" region="north" title="邮件主题内容" split="true"
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
		<td width="100px">回复人:</td>
		<td width="150px" ><div style="width:100%;color: blue;text-align:left;"><%=session.getAttribute("userName")%></div></td>
		<td width="100px">回复日期:</td>
		<td><div id="dat" style="width:100%;color: blue;text-align:left;"><%=str_date2 %></div></td>
	</tr>
</table>
<a class="easyui-linkbutton" id="adduser" icon="icon-add"
	href="javascript:void(0)">回复</a>
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
<div id="w" class="easyui-window" closed="true" title="修改学员卡信息"
	icon="icon-save"
	style="width: 520px; height: 190px; padding: 5px; background: #fafafa;">
<div class="easyui-layout" fit="true">
<div region="center" border="false"
	style="padding: 10px; background: #fff; border: 1px solid #ccc;">
<form name="updateinfo" method="post"
	action="FunctionPage/updateRecord.jsp" id="updateinfo" >
<table border="1" width="450px">
	<tr>
		<td width="70px">学员卡名称</td>
		<td><input type="text" name="cardname1" class="easyui-validatebox"
			required="true" readonly /></td>
		<td width="60px">折扣率</td>
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
	>修改</a> <a class="easyui-linkbutton"
	icon="icon-cancel" href="javascript:void(0)"
	onclick="$('#w').window('close');">取消</a></div>
</div>
</div>
</body>
</html>