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
				title:'���ż�¼�б�',
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
	                {field:'p0',title:'���Ž�����',width:pw*0.3},
					{field:'p1',title:'��������',width:pw*0.4},
					{field:'p2',title:'��������',width:pw*0.3-80}
				]],
				pagination:true,
				rownumbers:true,
				singleSelect:true,
				pageList:[5,10,15,20,25,30,35,40,45,50]
			});
			}else{
			$('#test').datagrid({
				title:'���ż�¼�б�',
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
	                {field:'p0',title:'���ű��',width:pw*0.1},
	                {field:'p1',title:'���Ž�����',width:pw*0.2},
					{field:'p2',title:'��������',width:pw*0.4},
					{field:'p3',title:'��������',width:pw*0.3-80}
				]],
				pagination:true,
				rownumbers:true,
				singleSelect:true,
				pageList:[5,10,15,20,25,30,35,40,45,50],
				toolbar:[{
					text:'ɾ��',
					iconCls:'icon-no',
					handler:function(){
						var s="<%=session.getAttribute("userRole")%>"; 
						if(s != "����Ա"){$.messager.alert('��ʾ','ֻ�й���Ա��ɾ��Ȩ��!','warning');return false;}
						var ids = [];
						var rows = $('#test').datagrid('getSelections');
						for(var i=0;i<rows.length;i++){
							ids.push(rows[i].p0);
						}
						var idstr = ids.join(';');
						if (idstr == ""){
							$.messager.alert('��ʾ','��ѡ����Ҫɾ���ļ�¼!','warning');return false;
						}
						$.messager.confirm('��ʾ', '�Ƿ�ȷ��ɾ��?', function(r){
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
			//��Ӽ�¼
			$("#adduser").click(function(){
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
		<td >��������:</td>
		<td colspan="3"><div style="width:100%;text-align:left;"><textarea name="topicmain" class="easyui-validatebox" style="height:50px;width:420px"></textarea></div></td>
	</tr>
	<tr>
		<td width="70px">������</td>
		<td><a href="#" onclick="showfs();return false;">ѡ������</a></td>
		<td width="60px">��������</td>
		<td ><div id="dats" style="width:100%;color: blue;text-align:left;"><%=str_date2 %></td>
	</tr>
</table>
<br/>
<a class="easyui-linkbutton" id="adduser" icon="icon-save"
	href="javascript:void(0)">ȷ�Ϸ���</a>
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
<div id="w" class="easyui-window" closed="true" title="ѡ��Ҫ���͵�ѧԱ"
	icon="icon-save"
	style="width:800px; height:290px; padding: 5px; background: #fafafa;">
	<select id="site" name="site" class="easyui-combobox"
			 style="width: 110px" listWidth="110px" editable="false">
	</select>
</div>
</body>
</html>