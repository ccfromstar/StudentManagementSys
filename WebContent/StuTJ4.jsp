<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>ѧԱ����ͳ��</title>
<jsp:include page="Incoming/common.jsp"></jsp:include>
<script>
$(function(){
			var s="<%=session.getAttribute("Enter")%>"; 
			checkuserTime(s);
			//�ж��û�����
			var info = <%=request.getQueryString()%>;
			checkuserAction(info,'�û�','�û���');
			loadsiteInfo();
			$("#form1").css("height",$("#tb1").attr("height"));
			//������ͼ
			var P_width = document.getElementById("view").style.width;
			var P_height = document.getElementById("view").style.height;
			var tmp_w = P_width.split("px");
			var tmp_h = P_height.split("px");
			var pw = Number(tmp_w[0]);
			var ph = Number(tmp_h[0]);
			$('#test').datagrid({
				title:'',
				iconCls:'icon-uo',
				width:pw,
				height:ph,
				fit:true,
				nowrap: false,
				striped: true,
				url:'DataPage/getDatas.jsp?&p=arrivedinfo&p=2@3@4',
				sortName: 'p0',
				sortOrder: 'desc',
				idField:'p0',
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'p0',title:'����ѧԱ����',width:pw*0.3},
					{field:'p1',title:'���ڿγ�',width:pw*0.4},
					{field:'p2',title:'��������',width:pw*0.3-80}
				]],
				pagination:true,
				rownumbers:true,
				singleSelect:true,
				pageList:[5,10,15,20,25,30,35,40,45,50],
				toolbar:[{
					text:'�༭',
					iconCls:'icon-edit',
					handler:function(){
						var s="<%=session.getAttribute("userRole")%>"; 
						if(s != "����Ա"){$.messager.alert('��ʾ','ֻ�й���Ա��ɾ��Ȩ��!','warning');return false;}
						var rows = $('#test').datagrid('getSelections');
						if(rows.length !=1){
							$.messager.alert('��ʾ','��ѡ��һ��Ҫ�༭�ļ�¼!','warning');return false;
						}
						$('#w').window('open');
						//ͨ��Ajax����ȡҪ�༭�ļ�¼
						var myurl="DataPage/getRecordInfo.jsp";
						$.ajax({
							type:"POST",
							url:myurl,
							dataType:"json",
							async:true, 
							data:"params="+rows[0].p0+";userinfo;2@3@4@5",
							timeout:60000,
							error:function(){
								$.messager.alert('��ʾ','���ݵ��ó���!','warning');return false;
							},
							success:function(myjson){
								$("input[name='username1']").val(myjson.p1);
								$("input[name='password1']").val(myjson.p2);
								$("input[name='id1']").val(rows[0].p0);
								$('#site1').combobox('setValue',myjson.p3); 
								$('#role1').combobox('setValue',myjson.p4); 
							}
						}); 	
					}
				},'-',{
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
						$("input[name='idstr']").val(idstr);
						document.delrecord.submit();
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
			//����ѧԱ��Ϣ
			$("#searchuser").click(function(){
				if($("input[name='cardnumber']").val() == ""){
					$.messager.alert('��ʾ','ѧԱ���Ż���������Ϊ��!','warning');return false;
				}
				$('#test').datagrid({'url':'DataPage/getSearchDatas.jsp?&p=stuinfo&p=6@2@15@7@8@9@10@4&p=StuName@StuCrdNo&p='+encodeURI($("input[name='cardnumber']").val()+'@'+$("input[name='cardnumber']").val())});
			});
			//����Excel��
			$("#exportXLS").click(function(){
				window.open("FunctionPage/JXLTest.jsp");
			});
			//��Ӽ�¼
			$("#adduser").click(function(){
				if($("input[name='username']").val()==""){
					$.messager.alert('��ʾ','�û�������Ϊ��!','warning');return false;
				}
				if($("input[name='password']").val()==""){
					$.messager.alert('��ʾ','���벻��Ϊ��!','warning');return false;
				}
				if($("input[name='site']").val()==""){
					$.messager.alert('��ʾ','��ѧ�㲻��Ϊ��!','warning');return false;
				}
				//$("input[name='keyvalue']").val($("input[name='username']").val());
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
			var timename=setInterval("ReadCardNo();",3000); 
		});
</script>
</head>
<body onload="loading()">
<jsp:include page="Incoming/loading.jsp"></jsp:include>
<div class="easyui-layout" id="layoutmain" style="width:100%;height:100%;visibility: hidden">
<div id="form1" region="north" title="ѧԱ����ͳ��" split="true"
	style="height: 63px; overflow: hidden;">
<OBJECT id="rd" style="display:none" codeBase="http://localhost:8023/StudentManagementSys/comRD800.dll" classid="clsid:638B238E-EB84-4933-B3C8-854B86140668"></OBJECT>
<form name="userform1" method="post" action="FunctionPage/insertRecord.jsp"
	id="userform" style="padding: 0px; margin: 0px;">
<table id="tb1" border="1" width="100%" height="30">
	<tr>
		<td colspan="6" style="background-color: #E0ECFF;text-align:left" >
			&nbsp;<font color="#1F4D6C"><b>������ѧԱ���Ż�����:</b></font>
			<input type="text" name="cardnumber" />
			&nbsp;<a class="easyui-linkbutton" id="searchuser" icon="icon-search"
	href="javascript:void(0)">��ѯ</a>
		</td>
	</tr>
</table>
	</form>
<form name="delrecord" method="post" action="FunctionPage/delRecord.jsp"
	style="display: none">
	<input type="hidden" name="idstr" />
	<input type="hidden" name="deltablename" value="userinfo" />
	<input type="hidden" name="delreturnpage" value="UserOption.jsp" />
	</form>
</div>
<div id="view" region="center" title=""  split="true">
<table id="test"></table>
</div>
</div>
<div id="w" class="easyui-window" closed="true" title="�޸��û���Ϣ"
	icon="icon-save"
	style="width: 520px; height: 190px; padding: 5px; background: #fafafa;">
<div class="easyui-layout" fit="true">
<div region="center" border="false"
	style="padding: 10px; background: #fff; border: 1px solid #ccc;">
<form name="updateinfo" method="post"
	action="FunctionPage/updateRecord.jsp" id="updateinfo" >
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
<input type="hidden" name="tablename1" value="userinfo" />
<input type="hidden" name="returnpage1" value = "UserOption.jsp" />
<input type="hidden" name="fields1" value="UserName;UserPwd;UserSite;UserRole" />
<input type="hidden" name="postparams1" value="username1;password1;site1;role1" />
<input type="hidden" name="types1" value="0;0;0;0" />
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