<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>���ŷ���</title>
<jsp:include page="Incoming/common.jsp"></jsp:include>
<script>
$(function(){
			var s="<%=session.getAttribute("Enter")%>"; 
			checkuserTime(s);
			//�ж��û�����
			var info = <%=request.getQueryString()%>;
			checkuserAction(info,'����','����');
			loadsiteInfo();
			loadcourseInfo();
			//loadStu();
			//������ͼ
			var P_width = document.getElementById("view").style.width;
			var P_height = document.getElementById("view").style.height;
			var tmp_w = P_width.split("px");
			var tmp_h = P_height.split("px");
			var pw = Number(tmp_w[0]);
			var ph = Number(tmp_h[0]);
			var s="<%=session.getAttribute("userRole")%>"; 
			var site = "<%=session.getAttribute("userSite")%>"; 
			if(s != "����Ա"){
			$('#test').datagrid({
				title:'��ǰ��ѧ��ѧԱ�б�',
				iconCls:'icon-uo',
				width:pw,
				height:ph,
				fit:true,
				nowrap: false,
				striped: true,
				//url:'DataPage/getDatas.jsp?&p=stuinfo&p=1@2@3',
				url:'DataPage/getDatasBysite.jsp?&p=stuinfo&q=1@2@3&r=StuSite&s='+site,
				sortName: 'p0',
				sortOrder: 'desc',
				idField:'p0',
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'p0',title:'ѧԱ���',width:pw*0.3},
					{field:'p1',title:'ѧԱ����',width:pw*0.4},
					{field:'p2',title:'ѧԱ�ֻ���',width:pw*0.3-80}
				]],
				pagination:true,
				rownumbers:true,
				singleSelect:true,
				pageList:[5,10,15,20,25,30,35,40,45,50],
				toolbar:[{
					text:'���',
					iconCls:'icon-add',
					handler:function(){
						var ids = [];
						var names =[];
						var rows = $('#test').datagrid('getSelections');
						for(var i=0;i<rows.length;i++){
							ids.push(rows[i].p2);
							names.push(rows[i].p1);
						}
						var idstr = ids.join(';');
						var namestr = names.join(';');
						if (idstr == ""){
							$.messager.alert('��ʾ','��ѡ����Ҫ��ӵ������˵�ѧԱ!','warning');return false;
						}
						$("input[name='sendtolistid']").val(idstr);
						$("input[name='sendtolist']").val(namestr);
					}
				}]
			});
			}else{
			$('#test').datagrid({
				title:'��ǰ��ѧ��ѧԱ�б�',
				iconCls:'icon-uo',
				width:pw,
				height:ph,
				fit:true,
				nowrap: false,
				striped: true,
				url:'DataPage/getDatas.jsp?&p=stuinfo&p=1@2@3',
				//url:'DataPage/getDatasBysite.jsp?&p=stuinfo&q=1@2@3&r=StuSite&s='+site,
				sortName: 'p0',
				sortOrder: 'desc',
				idField:'p0',
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'p0',title:'ѧԱ���',width:pw*0.3},
					{field:'p1',title:'ѧԱ����',width:pw*0.4},
					{field:'p2',title:'ѧԱ�ֻ���',width:pw*0.3-80}
				]],
				pagination:true,
				rownumbers:true,
				singleSelect:true,
				pageList:[5,10,15,20,25,30,35,40,45,50],
				toolbar:[{
					text:'���',
					iconCls:'icon-add',
					handler:function(){
						var ids = [];
						var names =[];
						var rows = $('#test').datagrid('getSelections');
						for(var i=0;i<rows.length;i++){
							ids.push(rows[i].p2);
							names.push(rows[i].p1);
						}
						var idstr = ids.join(';');
						var namestr = names.join(';');
						if (idstr == ""){
							$.messager.alert('��ʾ','��ѡ����Ҫ��ӵ������˵�ѧԱ!','warning');return false;
						}
						$("input[name='sendtolistid']").val(idstr);
						$("input[name='sendtolist']").val(namestr);
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
			//��Ӽ�¼
			$("#adduser").click(function(){
				if($("input[name='sendtolist']").val()==""){
					$.messager.alert('��ʾ','�����˲���Ϊ��!','warning');return false;
				}
				$("input[name='topicdate']").val($("#dats").text());
				document.userform.submit();
			});
			
			$('#site').combobox({
				onSelect:function(){
					var val = $('#site').combobox('getValue');
					//���ݽ�ѧ��õ���ѧ�������ѧԱ
					$('#lstu').combobox({
						url:'DataPage/getComboStuBySite.jsp?&p='+val,
						valueField:'id',
						textField:'text'
					});
				}
			});
			
			
			//�޸ļ�¼
			$("#update1").click(function(){
				if($("input[name='cardname1']").val()==""){
					$.messager.alert('��ʾ','ѧԱ�����Ʋ���Ϊ��!','warning');return false;
				}
				if($("input[name='cardrate1']").val()==""){
					$.messager.alert('��ʾ','�ۿ��ʲ���Ϊ��!','warning');return false;
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
java.util.Date currentTime = new java.util.Date();//�õ���ǰϵͳʱ�� 
String str_date1 = formatter.format(currentTime); //������ʱ���ʽ�� 
String str_date2 = str_date1.toString(); //��Date������ʱ��ת�����ַ�����ʽ 
%>
<div class="easyui-layout" id="layoutmain" style="width:100%;height:100%;visibility: hidden">
<div id="form1" region="north" title="���ŷ���" split="true"
	style="height: 195px; overflow: hidden;">
<OBJECT id="rd"
	style="display: none"
	codeBase="http://localhost:8023/StudentManagementSys/comRD800.dll"
	classid="clsid:638B238E-EB84-4933-B3C8-854B86140668"></OBJECT>
<form name="userform" method="post" action="FunctionPage/send.jsp"
	id="userform" style="padding: 5px; margin: 5px;">
<table border="1" width="720px">
	<tr>
		<td >��������:</td>
		<td colspan="3"><div style="width:100%;text-align:left;"><textarea name="topicmain" class="easyui-validatebox" style="height:50px;width:620px"></textarea></div></td>
	</tr>
	<tr>
		<td width="70px">������</td>
		<td colspan="3"><div style="text-align:left"><input name="sendtolist" readonly value="" style="width:99%" /></div></td>
	</tr>
	<tr>
		<td width="70px">��������</td>
		<td ><div id="dats" style="width:100%;color: blue;text-align:left;"><%=str_date2 %></td>
		<td width="70px">������</td>
		<td ><div id="dats" style="width:100%;color: blue;text-align:left;"><%=session.getAttribute("userName") %></td>
	</tr>
</table>
<br/>
<a class="easyui-linkbutton" id="adduser" icon="icon-save"
	href="javascript:void(0)">ȷ�Ϸ���</a>
	<input type="hidden" name="sendtype" value="0" />
	<input type="hidden" name="sendtolistid" />
	<input type="hidden" name="topicdate" />
	<input type="hidden" name="tablename" value="smsrecord" />
	<input type="hidden" name="label" value="0" />
	<input type="hidden" name="returnpage" value = "SendSMS.jsp" />
	<input type="hidden" name="fields" value="SMSName,SMSDetail,SMSData,SMSType" />
	<input type="hidden" name="postparams" value="sendtolistid@topicmain@topicdate@sendtype" />
	<input type="hidden" name="types" value="0;0;0;0" />
	</form>
<form name="delrecord" method="post" action="FunctionPage/delRecord.jsp"
	style="display: none">
	<input type="hidden" name="idstr" />
	<input type="hidden" name="deltablename" value="cardinfo" />
	<input type="hidden" name="delreturnpage" value="CardOption.jsp" />
	</form>
</div>
<div id="view" region="center" title=""  split="true">
<table id="test"></table>
</div>
</div>
<div id="w" class="easyui-window" closed="true" title="ѡ��Ҫ���͵�ѧԱ"
	icon="icon-save"
	style="width:800px; height:290px; padding: 5px; background: #fafafa;">
	<select id="site" name="site" class="easyui-combobox"
			 style="width: 110px" listWidth="110px" editable="false">
	</select>
</div>
</body>
</html>