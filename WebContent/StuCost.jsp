<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>�������</title>
<jsp:include page="Incoming/common.jsp"></jsp:include>
<script>
$(function(){
			var s="<%=session.getAttribute("Enter")%>"; 
			checkuserTime(s);
			
			//�ж��û�����
			var info = <%=request.getQueryString()%>;
			checkuserAction(info,'���Ѽ�¼','���Ѽ�¼');
			
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
			loadcourseInfo();
			$("#form1").css("height",$("#tb1").attr("height"));
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
				title:'ѧԱ�����嵥',
				iconCls:'icon-uo',
				width:pw,
				height:ph,
				fit:true,
				nowrap: false,
				striped: true,
				//url:'DataPage/getDatas.jsp?&p=costinfo&p=1@2@3',
				url:'DataPage/getDatasBysite.jsp?&p=costinfo&q=9@2@3@5@8&r=CostSite&s='+site,
				sortName: 'p0',
				sortOrder: 'desc',
				idField:'p0',
				frozenColumns:[[
					{field:'p4',title:'���ѿ���',width:pw*0.1},
	                {field:'p0',title:'����ѧԱ',width:pw*0.1},
					{field:'p1',title:'��������',width:pw*0.3},
					{field:'p3',title:'���ѿγ�',width:pw*0.2},
					{field:'p2',title:'���ѽ��',width:pw*0.3-60}
				]],
				pagination:true,
				rownumbers:true,
				singleSelect:true,
				pageList:[5,10,15,20,25,30,35,40,45,50],
				toolbar:[{
					text:'�������',
					iconCls:'icon-add',
					handler:function(){
						if($("input[name='cardnumber']").val() == ""){
							$.messager.alert('��ʾ','��ˢ�������뿨��!','warning');return false;
						}
						$("input[name='coststu1']").val($("input[name='cardnumber']").val());
						$("input[name='site1']").val(site);
						var myurl="DataPage/getRecordInfobyKey.jsp";
						$.ajax({
							type:"POST",
							url:myurl,
							dataType:"json",
							async:true, 
							contentType: "application/x-www-form-urlencoded; charset=utf-8",
							data:"params="+$("input[name='cardnumber']").val()+";stuinfo;2@8@12;StuCrdNo",
							timeout:60000,
							error:function(){
								$.messager.alert('��ʾ','���ݵ��ó���!','warning');return false;
							},
							success:function(myjson){
								$("input[name='coststuname1']").val(myjson.p1);
								$("input[name='stucrdtype1']").val(myjson.p2);
								$("input[name='stucrdstatus1']").val(myjson.p3);
							}
						}); 	
						$('#wadd').window('open');
					}
				}]
			});
			}
			else{
			$('#test').datagrid({
				title:'ѧԱ�����嵥',
				iconCls:'icon-uo',
				width:pw,
				height:ph,
				fit:true,
				nowrap: false,
				striped: true,
				url:'DataPage/getDatas.jsp?&p=costinfo&p=1@2@3@4@5@9@8',
				sortName: 'p0',
				sortOrder: 'desc',
				idField:'p0',
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'p0',title:'����ID',width:pw*0.05},
	                {field:'p6',title:'���ѿ���',width:pw*0.15},
	                {field:'p5',title:'����ѧԱ',width:pw*0.1},
					{field:'p1',title:'��������',width:pw*0.2},
					{field:'p4',title:'���ѿγ�',width:pw*0.2-20},
					{field:'p2',title:'���ѽ��',width:pw*0.2-80},
					{field:'p3',title:'���ѵص�',width:pw*0.1}
				]],
				pagination:true,
				rownumbers:true,
				singleSelect:true,
				pageList:[5,10,15,20,25,30,35,40,45,50],
				toolbar:[{
					text:'�������',
					iconCls:'icon-add',
					handler:function(){
						if($("input[name='cardnumber']").val() == ""){
							$.messager.alert('��ʾ','��ˢ�������뿨��!','warning');return false;
						}
						$("input[name='coststu1']").val($("input[name='cardnumber']").val());
						$("input[name='site1']").val(site);
						var myurl="DataPage/getRecordInfobyKey.jsp";
						$.ajax({
							type:"POST",
							url:myurl,
							dataType:"json",
							async:true, 
							contentType: "application/x-www-form-urlencoded; charset=utf-8",
							data:"params="+$("input[name='cardnumber']").val()+";stuinfo;2@8@12;StuCrdNo",
							timeout:60000,
							error:function(){
								$.messager.alert('��ʾ','���ݵ��ó���!','warning');return false;
							},
							success:function(myjson){
								$("input[name='coststuname1']").val(myjson.p1);
								$("input[name='stucrdtype1']").val(myjson.p2);
								$("input[name='stucrdstatus1']").val(myjson.p3);
							}
						}); 	
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
			
			$('#cour').combobox({
				onSelect:function(){
					var val = $('#cour').combobox('getValue');
					if(val==""){$.messager.alert('��ʾ','�γ�������Ϊ��!','warning');return false;}
					var myurl="DataPage/getRecordInfobyKey.jsp";
						$.ajax({
							type:"POST",
							url:myurl,
							dataType:"json",
							async:true, 
							contentType: "application/x-www-form-urlencoded; charset=utf-8",
							data:"params="+val+";courseinfo;3;CourseName",
							timeout:60000,
							error:function(){
								$.messager.alert('��ʾ','���ݵ��ó���!','warning');return false;
							},
							success:function(myjson){
								$("input[name='coursetimes1']").val(myjson.p1);
							}
						}); 	
						$.ajax({
							type:"POST",
							url:myurl,
							dataType:"json",
							async:true, 
							contentType: "application/x-www-form-urlencoded; charset=utf-8",
							data:"params="+$("input[name='stucrdtype1']").val()+"@"+val+";cardinfo;4;CardName@CardCourse",
							timeout:60000,
							error:function(){
								$.messager.alert('��ʾ','���ݵ��ó���!','warning');return false;
							},
							success:function(myjson){
								$("input[name='costpay1']").val(myjson.p1);
							}
						}); 	
				}
			});
			
			//����ѧԱ��Ϣ
			$("#searchuser").click(function(){
				if($("input[name='cardnumber']").val() == ""){
					$.messager.alert('��ʾ','ѧԱ���Ų���Ϊ��!','warning');return false;
				}
				//ͨ��Ajax����ȡҪ�༭�ļ�¼
				var myurl="DataPage/getStuInfo.jsp";
				$.ajax({
						type:"POST",
						url:myurl,
						dataType:"json",
						async:true, 
						data:"params="+$("input[name='cardnumber']").val()+";stuinfo;1@2@3@4@5@6@7@8@9@10@11@12@13@14",
						timeout:60000,
						error:function(){
							$.messager.alert('��ʾ','���ݵ��ó���!','warning');return false;
						},
						success:function(myjson){
							if(myjson.p1=="0"){
								$.messager.alert('��ʾ','�����ҵ�ѧԱ��Ϣ������!','warning');
								$("input[name='stuid']").val(""); 
								$("input[name='stuname']").val("");
								$("input[name='stutel']").val("");
								$("input[name='stusite']").val("");
								$("input[name='stucrdno']").val("");
								$("input[name='stucrdcreatedate']").val("");
								$("input[name='stucrdtype']").val("");
								$("input[name='stucrdbalance']").val("");
								$("input[name='accucusmoney']").val("");
								$("input[name='cosnum']").val("");
								$("input[name='stucrdstatus']").val("");
								$("input[name='stuarea']").val("");
								$("input[name='stubrithday']").val("");
								return false;
							}
							$("input[name='stuid']").val(myjson.p1); 
							$("input[name='stuname']").val(myjson.p2);
							$("input[name='stutel']").val(myjson.p3);
							$("input[name='stusite']").val(myjson.p4);
							$("input[name='stucrdno']").val(myjson.p6);
							$("input[name='stucrdcreatedate']").val(myjson.p7);
							$("input[name='stucrdtype']").val(myjson.p8);
							$("input[name='stucrdbalance']").val(myjson.p9);
							$("input[name='accucusmoney']").val(myjson.p10);
							$("input[name='cosnum']").val(myjson.p11);
							$("input[name='stucrdstatus']").val(myjson.p12);
							$("input[name='stuarea']").val(myjson.p14);
							$("input[name='stubrithday']").val(myjson.p5);
						}
					}); 	
			});
			//�������
			$("#addcost").click(function(){
				$("input[name='topicdate']").val($("#dat").text());
				if($("input[name='stucrdstatus1']").val() == "ͣ��"){
							$.messager.alert('��ʾ','�Բ�������ѧԱ���ѱ�ͣ��!','warning');return false;
				}
				if($('#cour').combobox('getValue')==""){
					$.messager.alert('��ʾ','�γ�������Ϊ��!','warning');return false;
				}
				document.icost.submit();
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
<% 
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
java.util.Date currentTime = new java.util.Date();//�õ���ǰϵͳʱ�� 
String str_date1 = formatter.format(currentTime); //������ʱ���ʽ�� 
String str_date2 = str_date1.toString(); //��Date������ʱ��ת�����ַ�����ʽ 
%> 
<div class="easyui-layout" id="layoutmain" style="width:100%;height:100%;visibility: hidden">
<div id="form1" region="north" title="ѧԱ��Ϣ" split="false"
	style="height: 130px; overflow: hidden;">
<OBJECT id="rd" style="display:none" codeBase="http://localhost:8023/StudentManagementSys/comRD800.dll" classid="clsid:638B238E-EB84-4933-B3C8-854B86140668"></OBJECT>
<form name="userform1" method="post" action="FunctionPage/insertRecord.jsp"
	id="userform" style="padding: 0px; margin: 0px;">
<table id="tb1" border="1" width="100%">
	<tr>
		<td colspan="6" style="background-color: #E0ECFF;text-align:left" >
			&nbsp;<font color="#1F4D6C"><b>��ˢ�������뿨��:</b></font>
			<input type="text" name="cardnumber" style="background-color:white" />
			&nbsp;<a class="easyui-linkbutton" id="searchuser" icon="icon-search"
	href="javascript:void(0)">��ѯ</a>
		</td>
	</tr>
	<tr>
			<td width="12.5%">ѧԱ����</td>
			<td width="12.5%"><input type="text" name="stuname" disabled style="background-color:white;border: none;text-align:left" /></td>
			<td width="12.5%">��ϵ�绰</td>
			<td width="12.5%"><input type="text" name="stutel" disabled style="background-color:white;border: none;text-align:left" /></td>
			<td width="12.5%">ѧԱ��״̬</td>
			<td width="12.5%"><input type="text" name="stucrdstatus" disabled style="background-color:white;border: none;text-align:left"/></td>
	</tr>
	<tr>
			<td width="12.5%">ѧԱ������</td>
			<td width="12.5%"><input type="text" name="stucrdno" disabled style="background-color:white;border: none;text-align:left"/></td>
			<td width="12.5%">ѧԱ������</td>
			<td width="12.5%"><input type="text" name="stucrdtype" disabled style="background-color:white;border: none;text-align:left"/></td>
			<td width="12.5%">��������</td>
			<td width="12.5%"><input type="text" name="stucrdcreatedate" disabled style="background-color:white;border: none;text-align:left"/></td>
	</tr>
	<tr>
			<td width="12.5%">ѧԱ�����</td>
			<td width="12.5%"><input type="text" name="stucrdbalance" disabled style="background-color:white;border: none;text-align:left"/></td>
			<td width="12.5%">�ۼ�����</td>
			<td width="12.5%"><input type="text" name="accucusmoney" disabled style="background-color:white;border: none;text-align:left"/></td>
			<td width="12.5%">���Ѵ���</td>
			<td width="12.5%"><input type="text" name="cosnum" disabled style="background-color:white;border: none;text-align:left"/></td>
	</tr>
</table>
	<input type="hidden" name="stuid" style="background-color:white;border: none;text-align:left" />
	<input type="hidden" name="stusite" style="background-color:white;border: none;text-align:left"/>
	<input type="hidden" name="stuarea" style="background-color:white;border: none;text-align:left"/>
	<input type="hidden" name="stubrithday" style="background-color:white;border: none;text-align:left"/>
	</form>
<form name="delrecord" method="post" action="FunctionPage/delRecord.jsp"
	style="display: none">
	<input type="hidden" name="idstr" />
	<input type="hidden" name="deltablename" value="costinfo" />
	<input type="hidden" name="delreturnpage" value="StuCost.jsp" />
	</form>
</div>
<div id="view" region="center" title=""  split="true">
<table id="test"></table>
</div>
</div>
<div id="w" class="easyui-window" closed="true" title="������Ϣ��ϸ"
	icon="icon-save"
	style="width: 720px; height: 290px; padding: 5px; background: #fafafa;">
<div class="easyui-layout" fit="true">
<div region="center" border="false"
	style="padding: 10px; background: #fff; border: 1px solid #ccc;">
<form name="updateinfo" method="post"
	action="FunctionPage/updateRecord.jsp" id="updateinfo" >
<table border="1" width="650px">
	<tr>
		<td width="70px">��������</td>
		<td><input type="text" name="costdata" class="easyui-validatebox" readonly /></td>
		<td width="70px">���ѽ��</td>
		<td><input type="text" name="costpay" class="easyui-validatebox" readonly /></td>
		<td width="70px">���ѵص�</td>
		<td><input type="text" name="costsite" class="easyui-validatebox" readonly /></td>
	</tr>
	<tr>
		<td>�γ���</td>
		<td><input type="text" name="costname" class="easyui-validatebox" readonly /></td>
		<td>�γ�����</td>
		<td><input type="text" name="costcycle" class="easyui-validatebox" readonly /></td>
		<td>����ѧԱ</td>
		<td><input type="text" name="coststu" class="easyui-validatebox" readonly /></td>
	</tr>
	<tr>
		<td>��ע</td>
		<td colspan="5"><div style="width:100%;text-align:left;"><textarea name="bz" class="easyui-validatebox" style="height:50px;width:520px" readonly></textarea></div></td>
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
	style="text-align: right; height: 30px; line-height: 30px;"></div>
</div>
</div>

<div id="wadd" class="easyui-window" minimizable="false" maximizable="false" collapsible="false" closed="true" title="�������"
	icon="icon-save"
	style="width: 720px; height: 290px; padding: 5px; background: #fafafa;">
<div class="easyui-layout" fit="true">
<div region="center" border="false"
	style="padding: 10px; background: #fff; border: 1px solid #ccc;">
<form name="icost" method="post"
	action="FunctionPage/insertCost.jsp" id="icost" >
<table border="1" width="600px">
	<tr>
		<td width="70px">�γ���</td>
		<td><select id="cour" name="cour" class="easyui-combobox"
			 style="width: 110px" listWidth="110px"
			editable="false">

		</select></td>
		<td width="70px">�γ̴���</td>
		<td><input type="text" name="coursetimes1" readonly class="easyui-numberbox" precision="2"  /></td>
		<td width="70px">���ѽ��</td>
		<td><input type="text" name="costpay1" class="easyui-numberbox" precision="2"  /></td>
	</tr>
	<tr>
		<td>����ѧԱ</td>
		<td><input type="text" name="coststuname1" class="easyui-validatebox" readonly /></td>
		<td>���ѵص�</td>
		<td><div id ="ssite"></div></td>
		<td colspan="2"></td>
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
	<input type="hidden" name="tablename" value="costinfo" />
	<input type="hidden" name="label" value="0" />
	<input type="hidden" name="returnpage" value = "StuCost.jsp" />
	<input type="hidden" name="fields" value="CostDate,CostMoney,CostSite,CostCourse,CostNotes,CourseCycle,StuCrdNo,CostName" />
	<input type="hidden" name="postparams" value="topicdate;costpay1;site1;cour;bz1;costcycle1;coststu1;coststuname1" />
	<input type="hidden" name="types" value="0;1;0;0;0;0;0;0" />
</form>
</div>

<div region="south" border="false"
	style="text-align: right; height: 30px; line-height: 30px;">
	<a
	class="easyui-linkbutton" id="addcost" icon="icon-ok" href="javascript:void(0)"
	>�������</a> <a class="easyui-linkbutton"
	icon="icon-cancel" href="javascript:void(0)"
	onclick="$('#wadd').window('close');">ȡ��</a></div>
</div>
</div>
</body>
</html>