<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html style="height:100%">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>С����ѧԱ����ϵͳ</title>
<link rel="stylesheet" type="text/css" href="theme/default/easyui.css">
<link rel="stylesheet" type="text/css" href="theme/icon.css">
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/main.js"></script>
<link href="theme/main.css" type="text/css" rel="stylesheet" />
<script>
		$(function(){
			//�жϵ�ǰ��¼�û���Ȩ��
			var s="<%=session.getAttribute("userRole")%>"; 
			//if(s != "����Ա"){$(".sys").css("display","none");}
			//document.getElementById("Module1").style.background = "url(theme/img/clickbg.jpg) no-repeat 50% 50%";
			selectfalse("ѧԱ����",1);
			$(".panel-title").click(function(){
				var seltext = $(this).text();
				switch(seltext){
					case "ѧԱ����":selectfalse(seltext,1);break;
					case "ѧԱ����":selectfalse(seltext,2);break;
					case "ѧԱ����":selectfalse(seltext,3);break;
					case "���ŷ���":selectfalse(seltext,4);break;
					case "�ڲ�����":selectfalse(seltext,5);break;
					case "ͳ�Ʊ���":selectfalse(seltext,6);break;
					case "ϵͳ����":selectfalse(seltext,7);break;
				}
			});
			$("input[name='selItem']").val(1);
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
		//Ȩ���ж�
		function checkrole(cc){
			var s="<%=session.getAttribute("userRole")%>"; 
			if(s == "����Ա")
			{
				changeCenter(cc);
			}
			else
			{
				$.messager.alert('��ʾ','ֻ�й���Ա���Խ����û�����!','warning');return false;
			}
			
		}
	</script>
</head>
<body
	onload="$('#bgup').hide();$('#layoutmain').css('visibility','visible');$('#iview').attr('src','StuCost.jsp');"
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
<div id="bguploading"><img src="theme/img/ajax-loader.gif" /> <span>ҳ�������У����Ժ�...</span>
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
			onclick="select('ѧԱ����',1)" class="link1" onmouseover="mouseover(1)"
			onmouseout="mouseout(1)">ѧԱ����</a></td>
		<td align="center" id="Module2"><a href="#"
			onclick="select('ѧԱ����',2)" class="link1" onmouseover="mouseover(2)"
			onmouseout="mouseout(2)">ѧԱ����</a></td>
		<td align="center" id="Module3"><a href="#"
			onclick="select('ѧԱ����',3)" class="link1" onmouseover="mouseover(3)"
			onmouseout="mouseout(3)">ѧԱ����</a></td>
		<td align="center" id="Module4"><a href="#"
			onclick="select('���ŷ���',4)" class="link1" onmouseover="mouseover(4)"
			onmouseout="mouseout(4)">���ŷ���</a></td>
		<td align="center" id="Module5"><a href="#"
			onclick="select('�ڲ�����',5)" class="link1" onmouseover="mouseover(5)"
			onmouseout="mouseout(5)">�ڲ�����</a></td>
		<td align="center" id="Module6"><a href="#"
			onclick="select('ͳ�Ʊ���',6)" class="link1" onmouseover="mouseover(6)"
			onmouseout="mouseout(6)">ͳ�Ʊ���</a></td>
		<td align="center" id="Module8"><a href="FunctionPage/logout.jsp"
			class="link1" onmouseover="mouseover(8)" onmouseout="mouseout(8)">�˳�ϵͳ</a></td>
		<td align="center" id="Module7">
		</td>
	</tr>
</table>
</div>
<div region="south" title="" split="true"
	style="height: 40px; padding: 10px; background: #E6F5FF; overflow: visible">
<table width="100%" border="0">
	<tr valign="top">
		<td align="left"><font color="gray">&nbsp;��ǰ�û�: <%=session.getAttribute("userName")%>&nbsp;|&nbsp;�û���ɫ:<%=session.getAttribute("userRole")%>&nbsp;|&nbsp;��ǰ��ѧ��:<%=session.getAttribute("userSite")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ȫ����ʾ��F11</font></td>
		<td align="right"><font color="gray">֣�¹������� ��Ȩ����</font></td>
	</tr>
</table>
</div>
<div region="west" split="false" title="���ܵ���"
	style="width: 190px; padding1: 1px; overflow: hidden;">
<div id="Navigation" class="easyui-accordion" fit="true" border="false">
<div id="a1" title="ѧԱ����" selected="true"
	style="overflow: auto; padding: 10px;">
<table width="60%" border="0" style="padding: 0px; margin: 0px">
	<tr valign="middle">
		<td class="natd"><img src="theme/img/member_card_setting_ico.gif" /></td>
		<td id="sz_5"><a class="link1" href="#"
			onmouseover="sz_mouseover(5)" onmouseout="sz_mouseout(5)"
			onclick="changeCenter('StuCost.jsp')">�������</a></td>
	</tr>
	<tr valign="middle">
		<td class="natd"><img src="theme/img/subbranch_setting_ico.gif" /></td>
		<td id="sz_6"><a class="link1" href="#"
			onmouseover="sz_mouseover(6)" onmouseout="sz_mouseout(6)"
			onclick="changeCenter('StuSearch.jsp')">ѧԱ��ѯ</a></td>
	</tr>
</table>
</div>
<div title="ѧԱ����" style="padding: 10px;">
<table width="60%" border="0" style="padding: 0px; margin: 0px">
	<tr valign="middle">
		<td class="natd"><img src="theme/img/member_card_setting_ico.gif" /></td>
		<td id="sz_7"><a class="link1" href="#"
			onmouseover="sz_mouseover(7)" onmouseout="sz_mouseout(7)"
			onclick="changeCenter('StuRegister.jsp')">ѧԱע��</a></td>
	</tr>
	<tr valign="middle">
		<td class="natd"><img src="theme/img/member_list_ico.gif" /></td>
		<td id="sz_8"><a class="link1" href="#"
			onmouseover="sz_mouseover(8)" onmouseout="sz_mouseout(8)"
			onclick="changeCenter('StuList.jsp')">ѧԱ�б�</a></td>
	</tr>
	<tr valign="middle">
		<td class="natd"><img src="theme/img/member_case_statis_ico.gif" /></td>
		<td id="sz_9"><a class="link1" href="#"
			onmouseover="sz_mouseover(9)" onmouseout="sz_mouseout(9)"
			onclick="changeCenter('StuRecharge.jsp')">ѧԱ��ֵ</a></td>
	</tr>
	<tr valign="middle">
		<td class="natd"><img src="theme/img/subbranch_setting_ico.gif" /></td>
		<td id="sz_10"><a class="link1" href="#"
			onmouseover="sz_mouseover(10)" onmouseout="sz_mouseout(10)"
			onclick="changeCenter('StuChgCrd.jsp')">ѧԱת��</a></td>
	</tr>
	<tr valign="middle">
		<td class="natd"><img src="theme/img/add_member_ico.gif" /></td>
		<td id="sz_11"><a class="link1" href="#"
			onmouseover="sz_mouseover(11)" onmouseout="sz_mouseout(11)"
			onclick="changeCenter('StuCrdLoss.jsp')">ѧԱ����ʧ</a></td>
	</tr>
</table>
</div>
<div title="ѧԱ����" style="padding: 10px;">
<table width="60%" border="0" style="padding: 0px; margin: 0px">
	<tr valign="middle">
		<td class="natd"><img src="theme/img/member_card_setting_ico.gif" /></td>
		<td id="sz_12"><a class="link1" href="#"
			onmouseover="sz_mouseover(12)" onmouseout="sz_mouseout(12)"
			onclick="changeCenter('StuArrived.jsp')">ѧԱ����</a></td>
	</tr>
	<tr valign="middle">
		<td class="natd"><img src="theme/img/subbranch_setting_ico.gif" /></td>
		<td id="sz_13"><a class="link1" href="#"
			onmouseover="sz_mouseover(13)" onmouseout="sz_mouseout(13)"
			onclick="changeCenter('StuLeave.jsp')">ѧԱ���</a></td>
	</tr>
	<tr valign="middle">
		<td class="natd"><img src="theme/img/subbranch_setting_ico.gif" /></td>
		<td id="sz_98"><a class="link1" href="#"
			onmouseover="sz_mouseover(98)" onmouseout="sz_mouseout(98)"
			onclick="changeCenter('StuCut.jsp')">ѧԱ����</a></td>
	</tr>
</table>
</div>
<div title="���ŷ���" style="padding: 10px;">
<table width="60%" border="0" style="padding: 0px; margin: 0px">
	<tr valign="middle">
		<td class="natd"><img src="theme/img/member_card_setting_ico.gif" /></td>
		<td id="sz_14"><a class="link1" href="#"
			onmouseover="sz_mouseover(14)" onmouseout="sz_mouseout(14)"
			onclick="changeCenter('SendSMS.jsp')">���ŷ���</a></td>
	</tr>
	<tr valign="middle">
		<td class="natd"><img src="theme/img/subbranch_setting_ico.gif" /></td>
		<td id="sz_15"><a class="link1" href="#"
			onmouseover="sz_mouseover(15)" onmouseout="sz_mouseout(15)"
			onclick="changeCenter('BriRemind.jsp')">��������</a></td>
	</tr>
	<tr valign="middle">
		<td class="natd"><img src="theme/img/subbranch_setting_ico.gif" /></td>
		<td id="sz_96"><a class="link1" href="#"
			onmouseover="sz_mouseover(96)" onmouseout="sz_mouseout(96)"
			onclick="changeCenter('Zstu.jsp')">׼ѧԱ����</a></td>
	</tr>
	<tr valign="middle">
		<td class="natd"><img src="theme/img/subbranch_setting_ico.gif" /></td>
		<td id="sz_97"><a class="link1" href="#"
			onmouseover="sz_mouseover(97)" onmouseout="sz_mouseout(97)"
			onclick="changeCenter('SMSList.jsp')">���ż�¼</a></td>
	</tr>
</table>
</div>
<div title="�ڲ�����" style="padding: 10px;">
<table width="90%" border="0" style="padding: 0px; margin: 0px">
	<tr valign="middle">
		<td class="natd"><img src="theme/img/subbranch_setting_ico.gif" /></td>
		<td id="sz_16"><a class="link1" href="#"
			onmouseover="sz_mouseover(16)" onmouseout="sz_mouseout(16)"
			onclick="changeCenter('Discuss.jsp')">�ڲ�����</a></td>
	</tr>
	<tr valign="middle">
		<td class="natd99"><img src="theme/img/subbranch_setting_ico.gif" /></td>
		<td id="sz_99">��������</td>
	</tr>
	<tr valign="middle">
		<td class="natd"></td>
		<td id="sz_22"><a class="link1" href="#"
			onmouseover="sz_mouseover(22)" onmouseout="sz_mouseout(22)"
			onclick="changeCenter('Mail.jsp')"><font size="1px"> �ռ���</font></a></td>
	</tr>
	<tr valign="middle">
		<td class="natd"></td>
		<td id="sz_23"><a class="link1" href="#"
			onmouseover="sz_mouseover(23)" onmouseout="sz_mouseout(23)"
			onclick="changeCenter('MaiHasSend.jsp')"><font size="1px"> ������</font></a></td>
	</tr>
</table>
</div>
<div title="ͳ�Ʊ���" style="padding: 10px;">
<table width="60%" border="0" style="padding: 0px; margin: 0px">
	<tr valign="middle">
		<td class="natd"><img src="theme/img/member_card_setting_ico.gif" /></td>
		<td id="sz_17"><a class="link1" href="#"
			onmouseover="sz_mouseover(17)" onmouseout="sz_mouseout(17)"
			onclick="changeCenter('StuTJ1.jsp')">ѧԱ���ͳ��</a></td>
	</tr>
	<tr valign="middle">
		<td class="natd"><img src="theme/img/member_list_ico.gif" /></td>
		<td id="sz_18"><a class="link1" href="#"
			onmouseover="sz_mouseover(18)" onmouseout="sz_mouseout(18)"
			onclick="changeCenter('StuTJ2.jsp')">ѧԱ�������</a></td>
	</tr>
	<tr valign="middle">
		<td class="natd"><img src="theme/img/subbranch_setting_ico.gif" /></td>
		<td id="sz_20"><a class="link1" href="#"
			onmouseover="sz_mouseover(20)" onmouseout="sz_mouseout(20)"
			onclick="changeCenter('StuTJ4.jsp')">ѧԱ����ͳ��</a></td>
	</tr>
	<tr valign="middle">
		<td class="natd"><img src="theme/img/add_member_ico.gif" /></td>
		<td id="sz_21"><a class="link1" href="#"
			onmouseover="sz_mouseover(21)" onmouseout="sz_mouseout(21)"
			onclick="changeCenter('StuTJ5.jsp')">�ۺ�ͳ��</a></td>
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