<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>短信发送</title>
<jsp:include page="Incoming/common.jsp"></jsp:include>
<script>
$(function(){
			var s="<%=session.getAttribute("Enter")%>"; 
			checkuserTime(s);
			//判断用户操作
			var info = <%=request.getQueryString()%>;
			checkuserAction(info,'短信','短信');
			loadsiteInfo();
			loadcourseInfo();
			//loadStu();
			//加载视图
			var P_width = document.getElementById("view").style.width;
			var P_height = document.getElementById("view").style.height;
			var tmp_w = P_width.split("px");
			var tmp_h = P_height.split("px");
			var pw = Number(tmp_w[0]);
			var ph = Number(tmp_h[0]);
			var s="<%=session.getAttribute("userRole")%>"; 
			var site = "<%=session.getAttribute("userSite")%>"; 
			if(s != "管理员"){
			$('#test').datagrid({
				title:'短信记录列表',
				iconCls:'icon-uo',
				width:pw,
				height:ph,
				fit:true,
				nowrap: false,
				striped: true,
				url:'DataPage/getDatas.jsp?&p=smsrecord&p=2@3@4',
				sortName: 'p0',
				sortOrder: 'desc',
				idField:'p0',
				frozenColumns:[[
	                {field:'p0',title:'短信接收人',width:pw*0.3},
					{field:'p1',title:'短信内容',width:pw*0.4},
					{field:'p2',title:'发送日期',width:pw*0.3-80}
				]],
				pagination:true,
				rownumbers:true,
				singleSelect:true,
				pageList:[5,10,15,20,25,30,35,40,45,50]
			});
			}else{
			$('#test').datagrid({
				title:'短信记录列表',
				iconCls:'icon-uo',
				width:pw,
				height:ph,
				fit:true,
				nowrap: false,
				striped: true,
				url:'DataPage/getDatas.jsp?&p=smsrecord&p=1@2@3@4',
				sortName: 'p0',
				sortOrder: 'desc',
				idField:'p0',
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'p0',title:'短信编号',width:pw*0.1},
	                {field:'p1',title:'短信接收人',width:pw*0.2},
					{field:'p2',title:'短信内容',width:pw*0.4},
					{field:'p3',title:'发送日期',width:pw*0.3-80}
				]],
				pagination:true,
				rownumbers:true,
				singleSelect:true,
				pageList:[5,10,15,20,25,30,35,40,45,50],
				toolbar:[{
					text:'删除',
					iconCls:'icon-no',
					handler:function(){
						var s="<%=session.getAttribute("userRole")%>"; 
						if(s != "管理员"){$.messager.alert('提示','只有管理员有删除权限!','warning');return false;}
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
			}
			
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
				$("input[name='topicdate']").val($("#dats").text());
				document.userform.submit();
			});
			
			$('#site').combobox({
				onSelect:function(){
					var val = $('#site').combobox('getValue');
					//根据教学点得到教学点的所有学员
					$('#lstu').combobox({
						url:'DataPage/getComboStuBySite.jsp?&p='+val,
						valueField:'id',
						textField:'text'
					});
				}
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
			var timename=setInterval("ReadCardNo();",3000); 
		});

function showfs(){
	$('#w').window('open');
}
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
<div id="form1" region="north" title="" split="true"
	style="height: 1px; overflow: hidden;display:none">
<OBJECT id="rd"
	style="display: none"
	codeBase="http://localhost:8023/StudentManagementSys/comRD800.dll"
	classid="clsid:638B238E-EB84-4933-B3C8-854B86140668"></OBJECT>
<form name="userform" method="post" action="FunctionPage/send.jsp"
	id="userform" style="padding: 5px; margin: 5px;">
<table border="1" width="520px">
	<tr>
		<td >短信内容:</td>
		<td colspan="3"><div style="width:100%;text-align:left;"><textarea name="topicmain" class="easyui-validatebox" style="height:50px;width:420px"></textarea></div></td>
	</tr>
	<tr>
		<td width="70px">发送人</td>
		<td><a href="#" onclick="showfs();return false;">选择发送人</a></td>
		<td width="60px">发送日期</td>
		<td ><div id="dats" style="width:100%;color: blue;text-align:left;"><%=str_date2 %></td>
	</tr>
</table>
<br/>
<a class="easyui-linkbutton" id="adduser" icon="icon-save"
	href="javascript:void(0)">确认发送</a>
	<input type="hidden" name="topicdate" />
	<input type="hidden" name="tablename" value="smsrecord" />
	<input type="hidden" name="label" value="0" />
	<input type="hidden" name="returnpage" value = "SendSMS.jsp" />
	<input type="hidden" name="fields" value="SMSName,SMSDetail,SMSData" />
	<input type="hidden" name="postparams" value="lstu;topicmain;topicdate" />
	<input type="hidden" name="types" value="0;0;0" />
	</form>
<form name="delrecord" method="post" action="FunctionPage/delRecord.jsp"
	style="display: none">
	<input type="hidden" name="idstr" />
	<input type="hidden" name="deltablename" value="smsrecord" />
	<input type="hidden" name="delreturnpage" value="SMSList.jsp" />
	</form>
</div>
<div id="view" region="center" title=""  split="true">
<table id="test"></table>
</div>
</div>
<div id="w" class="easyui-window" closed="true" title="选择要发送的学员"
	icon="icon-save"
	style="width:800px; height:290px; padding: 5px; background: #fafafa;">
	<select id="site" name="site" class="easyui-combobox"
			 style="width: 110px" listWidth="110px" editable="false">
	</select>
</div>
</body>
</html>