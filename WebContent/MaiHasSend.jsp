<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>个人邮箱(发件箱)</title>
<jsp:include page="Incoming/common.jsp"></jsp:include>
<script>
$(function(){
			var s="<%=session.getAttribute("Enter")%>"; 
			var un = "<%=session.getAttribute("userName")%>"; 
			checkuserTime(s);
			//判断用户操作
			var info = <%=request.getQueryString()%>;
			checkuserAction(info,'邮件','邮件名称');
			loadUserName();
			//加载视图
			var P_width = document.getElementById("view").style.width;
			var P_height = document.getElementById("view").style.height;
			var tmp_w = P_width.split("px");
			var tmp_h = P_height.split("px");
			var pw = Number(tmp_w[0]);
			var ph = Number(tmp_h[0]);
			$('#test').datagrid({
				title:'个人邮箱(发件箱)',
				iconCls:'icon-uo',
				width:pw,
				height:ph,
				fit:true,
				nowrap: false,
				striped: true,
				url:'DataPage/getSearchDatas.jsp?&p=mailinfo&p=1@2@6@5&p=MailPerson&p='+encodeURI(un),
				sortName: 'p0',
				sortOrder: 'desc',
				idField:'p0',
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'p0',title:'主题编号',width:pw*0.1},
	                {field:'p1',title:'邮件主题',width:pw*0.4,formatter:function(value,rec){
							return '<span style="color:blue"><a href="#">'+value+'</a></span>';
						}},
					{field:'p2',title:'收件人',width:pw*0.2},
					{field:'p3',title:'发送日期',width:pw*0.3-80}
				]],
				pagination:true,
				rownumbers:true,
				singleSelect:true,
				pageList:[5,10,15,20,25,30,35,40,45,50],
				onClickRow:function(rowIndex){ 
                    var rows = $('#test').datagrid('getSelections');
						if(rows.length !=1){
							$.messager.alert('提示','请选择一条要查看的主题!','warning');return false;
						}
						//打开主题记录的详细信息和显示对应的回复记录
						window.location = "MailTopic.jsp?p="+rows[0].p0; 
                } ,
				toolbar:[{
					text:'删除',
					iconCls:'icon-no',
					handler:function(){
						var s="<%=session.getAttribute("userRole")%>"; 
						//if(s != "管理员"){$.messager.alert('提示','只有管理员有删除权限!','warning');return false;}
						var ids = [];
						var rows = $('#test').datagrid('getSelections');
						for(var i=0;i<rows.length;i++){
							ids.push(rows[i].p0);
						}
						var idstr = ids.join(';');
						if (idstr == ""){
							$.messager.alert('提示','请选择您要删除的记录!','warning');return false;
						}
						$.messager.confirm('提示', '是否确认删除?', function(r){
							if (r){
								if(r==true){
									$("input[name='idstr']").val(idstr);
									document.delrecord.submit();
								}
							}
						});
					}
				}]
			});
			var p = $('#test').datagrid('getPager');
			//if (p){
				//$(p).pagination({
					//onSelectPage:function(){
						//alert('before refresh');
					//}
				//});
			//}
			//添加记录
			$("#adduser").click(function(){
				if($("input[name='topictitle']").val()==""){
					$.messager.alert('提示','主题标题不能为空!','warning');return false;
				}
				$("input[name='topicdate']").val($("#dat").text());
				document.userform.submit();
			});
			
			//修改记录
			$("#update1").click(function(){
				if($("input[name='cardname1']").val()==""){
					$.messager.alert('提示','学员卡名称不能为空!','warning');return false;
				}
				if($("input[name='cardrate1']").val()==""){
					$.messager.alert('提示','折扣率不能为空!','warning');return false;
				}
				document.updateinfo.submit();
			});
		});
</script>
</head>
<body onload="loading();$('input[name=topictitle]').css('width','99%');">
<jsp:include page="Incoming/loading.jsp"></jsp:include>
<%
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
	String str_date1 = formatter.format(currentTime); //将日期时间格式化 
	String str_date2 = str_date1.toString(); //将Date型日期时间转换成字符串形式
%>
<div class="easyui-layout" id="layoutmain"
	style="width: 100%; height: 100%; visibility: hidden">
<div id="view" region="center" title="" split="true">
<table id="test"></table>
</div>
</div>
<div id="w" class="easyui-window" closed="true" title="新邮件"
	icon="icon-save"
	style="width: 97% px; height: 280px; padding: 5px; background: #fafafa;">
<div class="easyui-layout" fit="true">
<div region="center" border="false" id="form1"
	style="padding: 10px; background: #fff; border: 1px solid #ccc;">
<form name="userform" method="post"
	action="FunctionPage/insertRecord.jsp" id="userform"
	style="padding: 5px; margin: 5px;">
<table border="1" width="98%">
	<tr>
		<td width="100px">主题:</td>
		<td colspan="3">
		<div style="width: 100%; text-align: left;"><input type="text"
			name="topictitle" id="topictitle" class="easyui-validatebox" /></div>
		</td>
	</tr>
	<tr>
		<td>内容:</td>
		<td colspan="3">
		<div style="width: 100%; text-align: left;"><textarea
			name="topicmain" class="easyui-validatebox"
			style="height: 50px; width: 600px"></textarea></div>
		</td>
	</tr>
	<tr>
		<td>收件人:</td>
		<td colspan="3">
		<div style="width: 100%; color: blue; text-align: left;">
			<select id="mailsendto" name="mailsendto" class="easyui-combobox"
			 style="width: 110px" listWidth="110px"
			editable="false">
		</select>
			</div>
		</td>
	</tr>
	<tr>
		<td>发件人:</td>
		<td width="150px">
		<div style="width: 100%; color: blue; text-align: left;"><%=session.getAttribute("userName")%></div>
		</td>
		<td width="100px">发送日期:</td>
		<td>
		<div id="dat" style="width: 100%; color: blue; text-align: left;"><%=str_date2%></div>
		</td>
	</tr>
</table>
<br />
<a class="easyui-linkbutton" id="adduser" icon="icon-add"
	href="javascript:void(0)">发送</a> <input type="hidden"
	name="topicperson" value=<%=session.getAttribute("userName") %> /> <input
	type="hidden" name="topicdate" /> <input type="hidden"
	name="tablename" value="mailinfo" /> <input type="hidden"
	name="label" value="0" /> <input type="hidden" name="returnpage"
	value="Mail.jsp" /> <input type="hidden" name="fields"
	value="MailTitle,MailMain,MailPerson,MailData,MailSendTo" /> <input
	type="hidden" name="postparams"
	value="topictitle;topicmain;topicperson;topicdate;mailsendto" /> <input
	type="hidden" name="types" value="0;0;0;0;0" /></form>
<form name="delrecord" method="post" action="FunctionPage/delRecord.jsp"
	style="display: none"><input type="hidden" name="idstr" /> <input
	type="hidden" name="deltablename" value="mailinfo" /> <input
	type="hidden" name="delreturnpage" value="MaiHasSend.jsp" /></form>
</div>
</div>
</div>
</body>
</html>