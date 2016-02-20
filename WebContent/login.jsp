<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>小飞人学员系统-用户登录</title>
<link rel="stylesheet" type="text/css" href="theme/default/easyui.css">
<link rel="stylesheet" type="text/css" href="theme/icon.css">
<style type="text/css">
input,textarea {
	width: 200px;
	border: 1px solid #ccc;
	padding: 2px;
}
</style>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
<link href="theme/StyleSheet1.css" type="text/css" rel="stylesheet" />
<script>
$(function(){
$("#btnLogin").click(function(){
				if($("input[name='txtUsername']").val()==""){
					$.messager.alert('提示','用户名不能为空!');return false;
				}
				if($("input[name='txtPass']").val()==""){
					$.messager.alert('提示','密码不能为空!');return false;
				}
			});
});
</script>
</head>
<body scroll="no" style="background-color: #e0ecff">
<center style="overflow: hidden;">
<div class="bg_color">
<form name="form1" method="post" action="FunctionPage/chklogin.jsp"
	id="form1">
<div style="height: 150px"></div>
<table border="0" cellpadding="0" cellspacing="0" width="1024"
	align="right">
	<tr height="60">
		<td valign="bottom" class="version" align="right" width="470px">
		<span id="lblVersion"></span></td>
	</tr>
	<tr>
		<td>
		<table width="500" border="0" align="right" cellpadding="3"
			cellspacing="0">
			<tr class="paragraph1">
				<td colspan="3" height="40" align="center"><font color="red"
					size="2px"><b> <%
 	String errmsg = request.getQueryString();
 	if (errmsg != null && errmsg.equals("errmsg=error1")) {
 		out.print("您输入的用户名或密码不正确！请重新输入！");
 	} else if (errmsg != null && errmsg.equals("errmsg=error2")) {
 		out.print("您没有权限进入本页或当前登录用户已过期！<br/>请重新登录或与管理员联系!");
 	}
 %> </b></font></td>
			</tr>
			<tr>
				<td height="16" colspan="3" align="left" valign="top" class="hg03"><marquee
					direction="left" width="80%" scrollamount="5" scrolldelay="100"
					onmouseover="this.stop()" onmouseout="this.start()">温馨提示：程序中使用了弹出窗口，如果您在访问过程中，IE中有阻止的提示，请您选择总是允许。</marquee></td>
			</tr>
			<tr>
				<td height="18" align="left" colspan="2" width="360" style="background-color: white;"><img src="theme/img/tubiao.jpg" ></img> <font size="5px"><b>学员管理信息系统</b></font></td>
				<td align="left" valign="top" width="150" ></td>
			</tr>
			<tr class="paragraph1" >
				<td height="40" align="right" width="180" style="background-color: white;"><font color="black">用户名：</font></td>
				<td align="center" width="180" class="input_link" style="background-color: white;">&nbsp;<input
					name="txtUsername" class="easyui-validatebox" type="text"
					maxlength="22" id="txtUsername"
					style="border-color: #D4D0C8; border-width: 1px; height: 16px; width: 135px;" />
				</td>
				<td align="left" valign="top" width="150" ></td>
			</tr>
			<tr class="paragraph1" >
				<td height="40" align="right" width="180" style="background-color: white;"><font color="black">密&nbsp;
				码：</font></td>
				<td align="center" width="180" class="input_link" style="background-color: white;">&nbsp;<input
					name="txtPass" class="easyui-validatebox" type="password"
					maxlength="22" id="txtPass"
					style="border-color: #D4D0C8; border-width: 1px; height: 16px; width: 135px;" />
				</td>
				<td align="left" valign="top" width="150"></td>
			</tr>
			<tr>
				<td align="left" valign="top" width="100" style="background-color: white;">&nbsp;</td>
				<td align="center" width="180" style="background-color: white;"><input type="submit"
					name="btnLogin" value="" id="btnLogin" class="login"
					style="border-width: 0px;" /></td>
				<td align="left" valign="top" width="260">&nbsp;</td>
			</tr>
			<tr>
				<td align="left" valign="top">&nbsp;</td>
				<td height="20" colspan="2" align="left"><span id="lblMsg"
					style="color: Red; background-color: Transparent;"></span></td>
			</tr>
			<tr>
				<td height="16" colspan="3" align="left" valign="top" class="hg03">为了您更好的使用，建议使用IE6以上、分辩率为1024*768的浏览器&nbsp;</td>
			</tr>
			<tr>
				<td height="30" colspan="3" align="left" class="copyju">版权所有<span
					class="copyhao">&copy;</span> 2012工作室</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</div>
</center>
</body>
</html>