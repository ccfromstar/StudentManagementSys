<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>ѧԱע��</title>
<jsp:include page="Incoming/common.jsp"></jsp:include>
<script>
$(function(){
			var s="<%=session.getAttribute("Enter")%>"; 
			checkuserTime(s);
			
			//�ж��û�����
			var info = <%=request.getQueryString()%>;
			checkuserAction(info,'ѧԱ','ѧԱ����');
			var s="<%=session.getAttribute("userRole")%>"; 
			if(s != "����Ա"){
				var site = "<%=session.getAttribute("userSite")%>"; 
				var htmltext ="<input name='site1' readonly value='"+site+"'>";
				$("#ssite").html(htmltext);
			}else{
				var htmltext = "<select id='site1' name='site1' class='easyui-combobox' style='width: 150px' listWidth='150px' editable='false'></select>";
				$("#ssite").html(htmltext);
				loadsiteInfo();
			}
			
			loadcourseInfo();
			loadcardInfo();
			$("#form1").css("height",$("#tb1").attr("height"));
			//������ͼ
			var P_width = document.getElementById("view").style.width;
			var P_height = document.getElementById("view").style.height;
			var tmp_w = P_width.split("px");
			var tmp_h = P_height.split("px");
			var pw = Number(tmp_w[0]);
			var ph = Number(tmp_h[0]);
			$('#test').datagrid({
				title:'ѧԱ�����嵥',
				iconCls:'icon-uo',
				width:pw,
				height:ph,
				fit:true,
				nowrap: false,
				striped: true,
				url:'DataPage/getDatas.jsp?&p=costinfo&p=1@2@3@4',
				sortName: 'p0',
				sortOrder: 'desc',
				idField:'p0',
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'p0',title:'����ID',width:pw*0.2},
					{field:'p1',title:'��������',width:pw*0.3},
					{field:'p2',title:'���ѽ��',width:pw*0.3-80},
					{field:'p3',title:'���ѵص�',width:pw*0.2}
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
						$('#wadd').window('open');
					}
				},'-',{
					text:'��ϸ',
					iconCls:'icon-edit',
					handler:function(){
						var rows = $('#test').datagrid('getSelections');
						if(rows.length !=1){
							$.messager.alert('��ʾ','��ѡ��һ��Ҫ�鿴�ļ�¼!','warning');return false;
						}
						$('#w').window('open');
						//ͨ��Ajax����ȡҪ�༭�ļ�¼
						var myurl="DataPage/getRecordInfo.jsp";
						$.ajax({
							type:"POST",
							url:myurl,
							dataType:"json",
							async:true, 
							data:"params="+rows[0].p0+";costinfo;2@3@4@5@6@7@8",
							timeout:60000,
							error:function(){
								$.messager.alert('��ʾ','���ݵ��ó���!','warning');return false;
							},
							success:function(myjson){
								$("input[name='costdata']").val(myjson.p1);
								$("input[name='costpay']").val(myjson.p2);
								$("input[name='id1']").val(rows[0].p0);
								$("input[name='costsite']").val(myjson.p3);
								
								$("input[name='costname']").val(myjson.p4);
								$("input[name='costcycle']").val(myjson.p6);
								$("input[name='coststu']").val(myjson.p7);
								$("textarea[name='bz']").val(myjson.p5);
								//$('#site1').combobox('setValue',myjson.p3); 
								//$('#role1').combobox('setValue',myjson.p4); 
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
			$("#addstu").click(function(){
				if($("input[name='stuname']").val()==""){
					$.messager.alert('��ʾ','ѧԱ��������Ϊ��!','warning');return false;
				}
				if($("input[name='stubrithday']").val()==""){
					$.messager.alert('��ʾ','���ղ���Ϊ��!','warning');return false;
				}
				if($("input[name='stutel']").val()==""){
					$.messager.alert('��ʾ','��ϵ�绰����Ϊ��!','warning');return false;
				}
				if($("input[name='stucrdno']").val()==""){
					$.messager.alert('��ʾ','ѧԱ�����Ų���Ϊ��!','warning');return false;
				}
				if($("input[name='crd']").val()==""){
					$.messager.alert('��ʾ','ѧԱ�����Ͳ���Ϊ��!','warning');return false;
				}
				if($("input[name='site1']").val()==""){
					$.messager.alert('��ʾ','������ѧ�㲻��Ϊ��!','warning');return false;
				}
				$("input[name='topicdate']").val($("#dats").text());
				document.userform1.submit();
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
			//var timename=setInterval("ReadCardNo();",3000); 
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
<% 
java.text.SimpleDateFormat formatter1 = new java.text.SimpleDateFormat("yyyy-MM-dd"); 
java.util.Date currentTime1 = new java.util.Date();//�õ���ǰϵͳʱ�� 
String str_date3 = formatter1.format(currentTime1); //������ʱ���ʽ�� 
String str_date4 = str_date3.toString(); //��Date������ʱ��ת�����ַ�����ʽ 
%> 
<div class="easyui-layout" id="layoutmain" style="width:100%;height:100%;visibility: hidden">
<div id="form1" region="north" title="ѧԱע��" split="true"
	style="height: 700px; overflow: hidden;">
<form name="userform1" method="post" action="FunctionPage/insertRecord.jsp"
	id="userform" style="padding: 0px; margin: 0px;">
<table id="tb1" border="1" width="100%">
	<tr>
			<td width="12.5%">ѧԱ����</td>
			<td width="12.5%" style="text-align:left"><input type="text" name="stuname"   /></td>
			<td width="12.5%">�Ա�</td>
			<td width="12.5%" style="text-align:left"><select name="sex" id="sex"  class="easyui-combobox"
			 style="width: 150px" listWidth="150px"
			editable="false">
  <option value="��">��</option>
  <option value="Ů">Ů</option>
</select></td>
	</tr>
	<tr>
			<td width="12.5%">����</td>
			<td width="12.5%" style="text-align:left"><input type="text" readonly style="cursor:pointer" name="stubrithday" onclick="new Calendar().show(this);"/></td>
			<td width="12.5%">��ϵ�绰</td>
			<td width="12.5%" style="text-align:left"><input type="text" name="stutel"   /></td>
			</tr>
	<tr>
			<td width="12.5%">ѧԱ������</td>
			<td width="12.5%" style="text-align:left"><input type="text" name="stucrdno" /></td>
			<td width="12.5%">ѧԱ������</td>
			<td width="12.5%" style="text-align:left"><select id="crd" name="crd" class="easyui-combobox"
			 style="width: 150px" listWidth="150px"
			editable="false">

		</select></td>
			</tr>
	<tr>
			<td width="12.5%">������ѧ��</td>
			<td width="12.5%" style="text-align:left"><div id ="ssite"></div></td>
			<td width="12.5%">����</td>
			<td width="12.5%" style="text-align:left"><select name="stuarea" id="stuarea" >
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
	</tr>
	<tr>
			<td width="12.5%" height="25px">��ͥ��ַ</td>
			<td colspan="3" height="25px" style="text-align:left"><input type="text" name="stuaddress" style="width: 99%" /></td>
	</tr>
	<tr>
			<td width="12.5%" height="25px">��������</td>
			<td colspan="3" ><div id="dats" style="width:100%;color: blue;text-align:left;"><%=str_date4 %></div></td>
	</tr>
</table>
<br/><br/>
&nbsp;&nbsp;<a class="easyui-linkbutton" id="addstu" icon="icon-add"
	href="javascript:void(0)">ע��ѧԱ</a>
	<br/>
	<input type="hidden" name="accucusmoney"  value="0"/>
	<input type="hidden" name="stucrdstatus" value="����"/>
	<input type="hidden" name="stucrdbalance" value="0" />
	<input type="hidden" name="cosnum"  value="0"/>
	<input type="hidden" name="topicdate" />
	<input type="hidden" name="tablename" value="stuinfo" />
	<input type="hidden" name="label" value="1;StuCrdNo;stucrdno" />
	<input type="hidden" name="returnpage" value = "StuRegister.jsp" />
	<input type="hidden" name="fields" value="StuName,StuLinkTel,StuSite,StuBrithday,StuCrdNo,StuCrdCreateDate,StuCrdType,StuCrdBalance,AccuCusMoney,CosNum,StuCrdStatus,StuNBrithday,StuArea,StuSex,StuAddress" />
	<input type="hidden" name="postparams" value="stuname;stutel;site1;stubrithday;stucrdno;topicdate;crd;stucrdbalance;accucusmoney;cosnum;stucrdstatus;stubrithday;stuarea;sex;stuaddress" />
	<input type="hidden" name="types" value="0;0;0;0;0;0;0;1;1;1;0;0;0;0;0" />
	</form>
<form name="delrecord" method="post" action="FunctionPage/delRecord.jsp"
	style="display: none">
	<input type="hidden" name="idstr" />
	<input type="hidden" name="deltablename" value="costinfo" />
	<input type="hidden" name="delreturnpage" value="StuCost.jsp" />
	</form>
</div>
<div id="view" region="center" style="display:none" title=""  split="true">
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
</form>
</div>
<div region="south" border="false"
	style="text-align: right; height: 30px; line-height: 30px;"></div>
</div>
</div>

<div id="wadd" class="easyui-window" closed="true" title="�������"
	icon="icon-save"
	style="width: 720px; height: 290px; padding: 5px; background: #fafafa;">
<div class="easyui-layout" fit="true">
<div region="center" border="false"
	style="padding: 10px; background: #fff; border: 1px solid #ccc;">
<form name="icost" method="post"
	action="FunctionPage/insertCost.jsp" id="icost" >
<table border="1" width="650px">
	<tr>
		<td width="70px">��������</td>
		<td><div id="dat" style="width:100%;color: blue;text-align:left;"><%=str_date2 %></div></td>
		<td width="70px">���ѽ��</td>
		<td><input type="text" name="costpay1" class="easyui-numberbox" precision="2" required="true" /></td>
		<td width="70px">���ѵص�</td>
		<td><select id="site1" name="site1" class="easyui-combobox"
			required="true" style="width: 110px" listWidth="110px"
			editable="false">

		</select></td>
	</tr>
	<tr>
		<td>�γ���</td>
		<td><select id="cour" name="cour" class="easyui-combobox"
			required="true" style="width: 110px" listWidth="110px"
			editable="false">

		</select></td>
		<td>�γ�����</td>
		<td><input type="text" name="costcycle1" class="easyui-validatebox" /></td>
		<td>����ѧԱ</td>
		<td><input type="text" name="coststu1" class="easyui-validatebox" readonly /></td>
	</tr>
	<tr>
		<td>��ע</td>
		<td colspan="5"><div style="width:100%;text-align:left;"><textarea name="bz1" class="easyui-validatebox" style="height:50px;width:520px" ></textarea></div></td>
	</tr>
</table>
	
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