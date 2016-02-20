<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>��ѧ������</title>
<jsp:include page="Incoming/common.jsp"></jsp:include>
<script>
$(function(){
			var s="<%=session.getAttribute("Enter")%>"; 
			checkuserTime(s);
			//�ж��û�����
			var info = <%=request.getQueryString()%>;
			checkuserAction(info,'��ѧ��','��ѧ������');
			//������ͼ
			var P_width = document.getElementById("view").style.width;
			var P_height = document.getElementById("view").style.height;
			var tmp_w = P_width.split("px");
			var tmp_h = P_height.split("px");
			var pw = Number(tmp_w[0]);
			var ph = Number(tmp_h[0]);
			$('#test').datagrid({
				title:'��ѧ���б�',
				iconCls:'icon-uo',
				width:pw,
				height:ph,
				fit:true,
				nowrap: false,
				striped: true,
				url:'DataPage/getDatas.jsp?&p=siteinfo&p=1@2',
				sortName: 'p0',
				sortOrder: 'desc',
				idField:'p0',
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'p0',title:'��ѧ����',width:pw*0.4},
					{field:'p1',title:'��ѧ������',width:pw*0.6-70}
				]],
				pagination:true,
				rownumbers:true,
				singleSelect:true,
				pageList:[5,10,15,20,25,30,35,40,45,50],
				toolbar:[
					/*{
					text:'�༭',
					iconCls:'icon-edit',
					handler:function(){
						var rows = $('#test').datagrid('getSelections');
						if(rows.length !=1){
							$.messager.alert('��ʾ','��ѡ��һ��Ҫ�༭�ļ�¼!','warning');return false;
						}
						$('#w').window('open');
						//ͨ��Ajax����ȡҪ�༭�ļ�¼
						var myurl="DataPage/getUserInfo.jsp";
						$.ajax({
							type:"POST",
							url:myurl,
							dataType:"json",
							async:true, 
							data:"idstr="+rows[0].p0,
							timeout:60000,
							error:function(){
								$.messager.alert('��ʾ','���ݵ��ó���!','warning');return false;
							},
							success:function(myjson){
								$("input[name='username1']").val(myjson.name);
								$("input[name='password1']").val(myjson.pwd);
								$("input[name='id1']").val(rows[0].code);
								$('#site1').combobox('setValue',myjson.site); 
								$('#role1').combobox('setValue',myjson.role); 
							}
						}); 	
					}
				},'-',*/{
					text:'ɾ��',
					iconCls:'icon-no',
					handler:function(){
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
				if($("input[name='sitename']").val()==""){
					$.messager.alert('��ʾ','��ѧ��������Ϊ��!','warning');return false;
				}
				document.userform.submit();
			});
			//�޸ļ�¼
			$("#update1").click(function(){
				if($("input[name='username1']").val()==""){
					$.messager.alert('��ʾ','�û�������Ϊ��!','warning');return false;
				}
				if($("input[name='password1']").val()==""){
					$.messager.alert('��ʾ','���벻��Ϊ��!','warning');return false;
				}
				if($("input[name='site1']").val()==""){
					$.messager.alert('��ʾ','��ѧ�㲻��Ϊ��!','warning');return false;
				}
				document.updateinfo.submit();
			});
		});
</script>
</head>
<body onload="loading()" >
<jsp:include page="Incoming/loading.jsp"></jsp:include>
<div class="easyui-layout" id="layoutmain" style="width:100%;height:100%;visibility: hidden">
<div id="form1" region="north" title="��ѧ������" split="true"
	style="height: 130px; overflow: hidden;">
<form name="userform" method="post" action="FunctionPage/insertRecord.jsp"
	id="userform" style="padding: 5px; margin: 5px;">
<table border="1" width="225px">
	<tr>
		<td width="60px">��ѧ����</td>
		<td><input type="text" name="sitename" class="easyui-validatebox"
			required="true" /></td>
	</tr>
</table>
<br/>
<a class="easyui-linkbutton" id="adduser" icon="icon-add"
	href="javascript:void(0)">���</a>
	<input type="hidden" name="tablename" value="siteinfo" />
	<input type="hidden" name="label" value="1;SiteName;sitename" />
	<input type="hidden" name="returnpage" value = "SiteOption.jsp" />
	<input type="hidden" name="fields" value="SiteName" />
	<input type="hidden" name="postparams" value="sitename" />
	<input type="hidden" name="types" value="0" />
	</form>
<form name="delrecord" method="post" action="FunctionPage/delRecord.jsp"
	style="display: none">
	<input type="hidden" name="idstr" />
	<input type="hidden" name="deltablename" value="siteinfo" />
	<input type="hidden" name="delreturnpage" value="SiteOption.jsp" />
	</form>
</div>
<div id="view" region="center" title=""  split="true">
<table id="test"></table>
</div>
</div>
<div id="w" class="easyui-window" minimizable="false" maximizable="false" collapsible="false" closed="true" title="�޸Ľ�ѧ����Ϣ"
	icon="icon-save"
	style="width: 520px; height: 190px; padding: 5px; background: #fafafa;">
<div class="easyui-layout" fit="true">
<div region="center" border="false"
	style="padding: 10px; background: #fff; border: 1px solid #ccc;">
<form name="updateinfo" method="post"
	action="FunctionPage/updateuser.jsp" id="updateinfo" >
<table border="1" width="450px">
	<tr>
		<td width="60px">�û���</td>
		<td><input type="text" name="username1"
			class="easyui-validatebox" readonly /></td>
		<td width="60px">����</td>
		<td><input type="text" name="password1"
			class="easyui-validatebox" required="true" /></td>
	</tr>
	<tr>
		<td>��ѧ��</td>
		<td><select id="site1" name="site1" class="easyui-combobox"
			required="true" style="width: 130px" listWidth="130px"
			editable="false">

		</select></td>
		<td>��ɫ</td>
		<td align="center"><select id="role1" class="easyui-combobox"
			name="role1" required="true" style="width: 130px" listWidth="130px"
			editable="false">
			<option>��ѧ�㸨��Ա</option>
			<option>����Ա</option>
		</select></td>
	</tr>
</table>
<input type="hidden" name="id1"/>
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