<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html style="height:100%">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>小飞人学员管理系统</title>
<link rel="stylesheet" type="text/css" href="theme/default/easyui.css">
<link rel="stylesheet" type="text/css" href="theme/icon.css">
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/main.js"></script>
<link href="theme/main.css" type="text/css" rel="stylesheet" />
<script>
		$(function(){
			//判断当前登录用户的权限
			var s="<%=session.getAttribute("userRole")%>"; 
			//if(s != "管理员"){$(".sys").css("display","none");}
			//document.getElementById("Module1").style.background = "url(theme/img/clickbg.jpg) no-repeat 50% 50%";
			selectfalse("内部交流",5);
			$(".panel-title").click(function(){
				var seltext = $(this).text();
				switch(seltext){
					case "学员消费":selectfalse(seltext,1);break;
					case "学员管理":selectfalse(seltext,2);break;
					case "学员考勤":selectfalse(seltext,3);break;
					case "短信发送":selectfalse(seltext,4);break;
					case "内部交流":selectfalse(seltext,5);break;
					case "统计报表":selectfalse(seltext,6);break;
					case "系统设置":selectfalse(seltext,7);break;
				}
			});
			$("input[name='selItem']").val(5);
			$('#tt2').datagrid({
				title:'My Title',
				iconCls:'icon-save',
				width:600,
				height:350,
				nowrap: false,
				striped: true,
				fit: true,
				url:'datagrid_data.json',
				sortName: 'code',
				sortOrder: 'desc',
				idField:'code',
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {title:'code',field:'code',width:80,sortable:true}
				]],
				columns:[[
			        {title:'Base Information',colspan:3},
					{field:'opt',title:'Operation',width:100,align:'center', rowspan:2,
						formatter:function(value,rec){
							return '<span style="color:red">Edit Delete</span>';
						}
					}
				],[
					{field:'name',title:'Name',width:120},
					{field:'addr',title:'Address',width:120,rowspan:2,sortable:true},
					{field:'col4',title:'Col41',width:150,rowspan:2}
				]],
				pagination:true,
				rownumbers:true
			});
		});
		function addmenu(){
			var header = $('.layout-expand .layout-button-down').parent().parent();
			var menu = $('<div style="position:absolute;left:0;top:0;background:#fafafa;"></div>').appendTo(header);
			var btn = $('<a href="#">test</a>').appendTo(menu);
			btn.menubutton({
				menu:'#mymenu'
			});
		}
		//权限判断
		function checkrole(cc){
			var s="<%=session.getAttribute("userRole")%>"; 
			if(s == "管理员")
			{
				changeCenter(cc);
			}
			else
			{
				$.messager.alert('提示','只有管理员可以进行用户设置!','warning');return false;
			}
			
		}
	</script>
</head>
<body
	onload="$('#bgup').hide();$('#layoutmain').css('visibility','visible');$('#iview').attr('src','Discuss.jsp');"
	style="height: 100%; padding: 0px; margin: 0px;">
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<%
	if (session.getAttribute("Enter") != "true") {
		String errmsg = "error2";
		response.sendRedirect("login.jsp?errmsg=" + errmsg);
	}
%>
<div id="bgup">
<div id="bguploading"><img src="theme/img/ajax-loader.gif" /> <span>页面载入中，请稍候...</span>
</div>
</div>
<div class="easyui-layout" id="layoutmain" style="visibility: hidden">
<div id="mymenu" style="width: 150px;">
<div>item1</div>
<div>item2</div>
</div>
<div region="north" title="" split="true"
	style="height: 130px; padding: 10px; background-color: #E6F5FF; overflow: visible">
<table width="100%" border="0">
	<tr valign="top">
		<td align="center"><img src="theme/img/member_consume1.gif" /></td>
		<td align="center"><img src="theme/img/member_manage1.gif" /></td>
		<td align="center"><img src="theme/img/member_manage1.gif" /></td>
		<td align="center"><img src="theme/img/member_manage1.gif" /></td>
		<td align="center"><img src="theme/img/member_manage1.gif" /></td>
		<td align="center"><img src="theme/img/state_report1.gif" /></td>
		<td align="center"><img src="theme/img/exit_sys1.gif" /></td>
		<td align="center">
		</td>
	</tr>
	<tr valign="middle" height="32px">
		<td align="center" id="Module1"><a href="#"
			onclick="$.messager.alert('提示','您无该操作权限!','warning');return false;" class="link1" onmouseover="mouseover(1)"
			onmouseout="mouseout(1)">学员消费</a></td>
		<td align="center" id="Module2"><a href="#"
			onclick="$.messager.alert('提示','您无该操作权限!','warning');return false;" class="link1" onmouseover="mouseover(2)"
			onmouseout="mouseout(2)">学员管理</a></td>
		<td align="center" id="Module3"><a href="#"
			onclick="$.messager.alert('提示','您无该操作权限!','warning');return false;" class="link1" onmouseover="mouseover(3)"
			onmouseout="mouseout(3)">学员考勤</a></td>
		<td align="center" id="Module4"><a href="#"
			onclick="$.messager.alert('提示','您无该操作权限!','warning');return false;" class="link1" onmouseover="mouseover(4)"
			onmouseout="mouseout(4)">短信发送</a></td>
		<td align="center" id="Module5"><a href="#"
			onclick="select('内部交流',5)" class="link1" onmouseover="mouseover(5)"
			onmouseout="mouseout(5)">内部交流</a></td>
		<td align="center" id="Module6"><a href="#"
			onclick="$.messager.alert('提示','您无该操作权限!','warning');return false;" class="link1" onmouseover="mouseover(6)"
			onmouseout="mouseout(6)">统计报表</a></td>
		<td align="center" id="Module8"><a href="FunctionPage/logout.jsp"
			class="link1" onmouseover="mouseover(8)" onmouseout="mouseout(8)">退出系统</a></td>
		<td align="center" id="Module7">
		</td>
	</tr>
</table>
</div>
<div region="south" title="" split="true"
	style="height: 40px; padding: 10px; background: #E6F5FF; overflow: visible">
<table width="100%" border="0">
	<tr valign="top">
		<td align="left"><font color="gray">&nbsp;当前用户: <%=session.getAttribute("userName")%>&nbsp;|&nbsp;用户角色:<%=session.getAttribute("userRole")%>&nbsp;|&nbsp;当前教学点:<%=session.getAttribute("userSite")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;全屏显示：F11</font></td>
		<td align="right"><font color="gray">郑陈工工作室 版权所有</font></td>
	</tr>
</table>
</div>
<div region="west" split="false" title="功能导航"
	style="width: 190px; padding1: 1px; overflow: hidden;">
<div id="Navigation" class="easyui-accordion" fit="true" border="false">
<div title="内部交流" style="padding: 10px;">
<table width="90%" border="0" style="padding: 0px; margin: 0px">
	<tr valign="middle">
		<td class="natd"><img src="theme/img/subbranch_setting_ico.gif" /></td>
		<td id="sz_16"><a class="link1" href="#"
			onmouseover="sz_mouseover(16)" onmouseout="sz_mouseout(16)"
			onclick="changeCenter('Discuss.jsp')">内部交流</a></td>
	</tr>
	<tr valign="middle">
		<td class="natd99"><img src="theme/img/subbranch_setting_ico.gif" /></td>
		<td id="sz_99">个人邮箱</td>
	</tr>
	<tr valign="middle">
		<td class="natd"></td>
		<td id="sz_22"><a class="link1" href="#"
			onmouseover="sz_mouseover(22)" onmouseout="sz_mouseout(22)"
			onclick="changeCenter('Mail.jsp')"><font size="1px"> 收件箱</font></a></td>
	</tr>
	<tr valign="middle">
		<td class="natd"></td>
		<td id="sz_23"><a class="link1" href="#"
			onmouseover="sz_mouseover(23)" onmouseout="sz_mouseout(23)"
			onclick="changeCenter('MaiHasSend.jsp')"><font size="1px"> 发件箱</font></a></td>
	</tr>
</table>
</div>
</div>
</div>
<div id="center" region="center" title="" style="overflow: hidden;">
<iframe id="iview" width="100%" height="100%" frameborder="0"></iframe>
</div>
</div>
<input type="hidden" name="selItem" />
<input type="hidden" name="selNav" />
</body>
</html>