<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>׼ѧԱ����</title>
<jsp:include page="Incoming/common.jsp"></jsp:include>
<script>
$(function(){
			var s="<%=session.getAttribute("Enter")%>"; 
			checkuserTime(s);
			//�ж��û�����
			var info = <%=request.getQueryString()%>;
			checkuserAction(info,'׼ѧԱ','׼ѧԱ');
			
			var s="<%=session.getAttribute("userRole")%>"; 
			if(s != "����Ա"){
				var site = "<%=session.getAttribute("userSite")%>"; 
				var htmltext ="<input name='site1' readonly value='"+site+"'>";
				$("#ssite").html(htmltext);
			}else{
				var htmltext = "<select id='site1' name='site1' class='easyui-combobox' style='width: 110px' listWidth='110px' editable='false'></select>";
				$("#ssite").html(htmltext);
				loadsiteInfo();
			}
			
			//loadsiteInfo();
			//loadcourseInfo();
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
				title:'׼ѧԱ�б�',
				iconCls:'icon-uo',
				width:pw,
				height:ph,
				fit:true,
				nowrap: false,
				striped: true,
				//url:'DataPage/getDatas.jsp?&p=zstuinfo&p=2@3@4@6@5',
				url:'DataPage/getDatasBysite.jsp?&p=zstuinfo&q=2@3@4@6@5&r=StuSite&s='+site,
				sortName: 'p0',
				sortOrder: 'desc',
				idField:'p0',
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'p0',title:'׼ѧԱ����',width:pw*0.2},
					{field:'p1',title:'�Ա�',width:pw*0.2},
					{field:'p2',title:'����',width:pw*0.2-80},
					{field:'p3',title:'����',width:pw*0.2},
					{field:'p4',title:'��ϵ�绰',width:pw*0.2}
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
							ids.push(rows[i].p4);
							names.push(rows[i].p0);
						}
						var idstr = ids.join(';');
						var namestr = names.join(';');
						if (idstr == ""){
							$.messager.alert('��ʾ','��ѡ����Ҫ��ӵ������˵�ѧԱ!','warning');return false;
						}
						$("input[name='sendtolistid']").val(idstr);
						$("input[name='sendtolist']").val(namestr);
					}
				},'-',{
					text:'�½�׼ѧԱ',
					iconCls:'icon-add',
					handler:function(){
						$('#wadd').window('open');
					}
				}]
			});
			}else{
			$('#test').datagrid({
				title:'׼ѧԱ�б�',
				iconCls:'icon-uo',
				width:pw,
				height:ph,
				fit:true,
				nowrap: false,
				striped: true,
				url:'DataPage/getDatas.jsp?&p=zstuinfo&p=1@2@3@4@6@5',
				//url:'DataPage/getDatasBysite.jsp?&p=stuinfo&q=1@2@3&r=StuSite&s='+site,
				sortName: 'p0',
				sortOrder: 'desc',
				idField:'p0',
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'p0',title:'���',width:pw*0.05},
	                {field:'p1',title:'׼ѧԱ����',width:pw*0.15},
					{field:'p2',title:'�Ա�',width:pw*0.2},
					{field:'p3',title:'����',width:pw*0.2-80},
					{field:'p4',title:'����',width:pw*0.2},
					{field:'p5',title:'��ϵ�绰',width:pw*0.2}
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
							ids.push(rows[i].p5);
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
				},'-',{
					text:'�½�׼ѧԱ',
					iconCls:'icon-add',
					handler:function(){
						$('#wadd').window('open');
					}
				},'-',{
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
				if($("input[name='sendtolist']").val()==""){
					$.messager.alert('��ʾ','�����˲���Ϊ��!','warning');return false;
				}
				$("input[name='topicdate']").val($("#dats").text());
				document.userform.submit();
			});
			
			//���׼ѧԱ
			$("#addcost").click(function(){
				if($("input[name='stuname']").val()==""){
					$.messager.alert('��ʾ','׼ѧԱ��������Ϊ��!','warning');return false;
				}
				if($("input[name='stuage']").val()==""){
					$.messager.alert('��ʾ','׼ѧԱ���䲻��Ϊ��!','warning');return false;
				}
				if($("input[name='stutel']").val()==""){
					$.messager.alert('��ʾ','׼ѧԱ��ϵ�绰����Ϊ��!','warning');return false;
				}
				document.icost.submit();
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
<div id="form1" region="north" title="׼ѧԱ����" split="true"
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
	<input type="hidden" name="sendtype" value="2" />
	<input type="hidden" name="sendtolistid" />
	<input type="hidden" name="topicdate" />
	<input type="hidden" name="tablename" value="smsrecord" />
	<input type="hidden" name="label" value="0" />
	<input type="hidden" name="returnpage" value = "Zstu.jsp" />
	<input type="hidden" name="fields" value="SMSName,SMSDetail,SMSData,SMSType" />
	<input type="hidden" name="postparams" value="sendtolistid@topicmain@topicdate@sendtype" />
	<input type="hidden" name="types" value="0;0;0;0" />
	</form>
<form name="delrecord" method="post" action="FunctionPage/delRecord.jsp"
	style="display: none">
	<input type="hidden" name="idstr" />
	<input type="hidden" name="deltablename" value="zstuinfo" />
	<input type="hidden" name="delreturnpage" value="Zstu.jsp" />
	</form>
</div>
<div id="view" region="center" title=""  split="true">
<table id="test"></table>
</div>
</div>
<div id="wadd" class="easyui-window" minimizable="false" maximizable="false" collapsible="false" closed="true" title="�½�׼ѧԱ"
	icon="icon-save"
	style="width: 720px; height: 290px; padding: 5px; background: #fafafa;">
<div class="easyui-layout" fit="true">
<div region="center" border="false"
	style="padding: 10px; background: #fff; border: 1px solid #ccc;">
<form name="icost" method="post"
	action="FunctionPage/insertRecord.jsp" id="icost" >
<table border="1" width="660px">
	<tr>
		<td width="90px">׼ѧԱ����</td>
		<td><input type="text" name="stuname"/></td>
		<td width="70px">�Ա�</td>
		<td><select name="sex" id="sex"  class="easyui-combobox"
			 style="width: 100px" listWidth="100px"
			editable="false">
  <option value="��">��</option>
  <option value="Ů">Ů</option>
</select></td>
		<td width="70px">����</td>
		<td><input type="text" name="stuage"/></td>
	</tr>
	<tr>
		<td>��ϵ�绰</td>
		<td><input type="text" name="stutel" /></td>
		<td>����</td>
		<td style="text-align:left"><select name="stuarea" id="stuarea" >
  <option value="�ֶ�����">�ֶ�����</option>
  <option value="������">������</option>
  <option value="¬����">¬����</option>
  <option value="�����">�����</option>
  <option value="������">������</option>
  <option value="������">������</option>
  <option value="������">������</option>
  <option value="բ����">բ����</option>
  <option value="�����">�����</option>
  <option value="������">������</option>
  <option value="�ɽ���">�ɽ���</option>
  <option value="�ζ���">�ζ���</option>
  <option value="������">������</option>
  <option value="������">������</option>
  <option value="��ɽ��">��ɽ��</option>
  <option value="������">������</option>
</select></td>
		<td>��ѧ��</td>
		<td><div id ="ssite"></div></td>
	</tr>
	<tr>
		<td>��ע</td>
		<td colspan="5"><div style="width:100%;text-align:left;"><textarea name="bz1" class="easyui-validatebox" style="height:50px;width:500px" ></textarea></div></td>
	</tr>
</table>
	<input type="hidden" name="stucrdstatus1" class="easyui-validatebox"  />
	<input type="hidden" name="stucrdtype1" class="easyui-validatebox"  />
	<input type="hidden" name="coststu1" class="easyui-validatebox"  />
	<input type="hidden" name="costcycle1" class="easyui-validatebox" />
	<div id="dat" style="display:none;width:100%;color: blue;text-align:left;"><%=str_date2 %></div>
	<input type="hidden" name="topicdate" />
	<input type="hidden" name="tablename" value="zstuinfo" />
	<input type="hidden" name="label" value="0" />
	<input type="hidden" name="returnpage" value = "Zstu.jsp" />
	<input type="hidden" name="fields" value="StuName,StuSex,StuAge,StuTel,StuArea,StuBZ,StuSite" />
	<input type="hidden" name="postparams" value="stuname;sex;stuage;stutel;stuarea;bz1;site1" />
	<input type="hidden" name="types" value="0;0;1;0;0;0;0" />
</form>
</div>

<div region="south" border="false"
	style="text-align: right; height: 30px; line-height: 30px;">
	<a
	class="easyui-linkbutton" id="addcost" icon="icon-ok" href="javascript:void(0)"
	>���׼ѧԱ</a> <a class="easyui-linkbutton"
	icon="icon-cancel" href="javascript:void(0)"
	onclick="$('#wadd').window('close');">ȡ��</a></div>
</div>
</div>
</body>
</html>