<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>ѧԱ���</title>
<jsp:include page="Incoming/common.jsp"></jsp:include>
<script>
$(function(){
			var s="<%=session.getAttribute("Enter")%>"; 
			checkuserTime(s);
			//�ж��û�����
			var info = <%=request.getQueryString()%>;
			checkuserAction(info,'ѧԱ���','ѧԱ���');
			
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
				title:'ѧԱ�����Ϣ�б�',
				iconCls:'icon-uo',
				width:pw,
				height:ph,
				fit:true,
				nowrap: false,
				striped: true,
				//url:'DataPage/getDatas.jsp?&p=arrivedinfo&p=2@3@4',
				url:'DataPage/getDatasBysite.jsp?&p=leaveinfo&q=2@3@4&r=LeaveSite&s='+site,
				sortName: 'p0',
				sortOrder: 'desc',
				idField:'p0',
				frozenColumns:[[
	                {field:'p0',title:'���ѧԱ����',width:pw*0.3},
					{field:'p1',title:'��ٿγ�',width:pw*0.4},
					{field:'p2',title:'�������',width:pw*0.3-80}
				]],
				pagination:true,
				rownumbers:true,
				singleSelect:true,
				pageList:[5,10,15,20,25,30,35,40,45,50]
			});
			}else{
			$('#test').datagrid({
				title:'ѧԱ�����Ϣ�б�',
				iconCls:'icon-uo',
				width:pw,
				height:ph,
				fit:true,
				nowrap: false,
				striped: true,
				url:'DataPage/getDatas.jsp?&p=leaveinfo&p=1@2@3@4@5',
				sortName: 'p0',
				sortOrder: 'desc',
				idField:'p0',
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'p0',title:'��ٱ��',width:pw*0.1},
	                {field:'p1',title:'���ѧԱ����',width:pw*0.2},
					{field:'p2',title:'��ٿγ�',width:pw*0.2},
					{field:'p3',title:'�������',width:pw*0.3-80},
					{field:'p4',title:'��ٵص�',width:pw*0.2}
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
				if($("input[name='txtleave']").val() == "2"){
					$.messager.alert('��ʾ','�Բ��𣬸�ѧԱ�Ŀγ���ٴ�������!','warning');return false;
				}
				//$("input[name='topicdate']").val($("#dats").text());
				document.userform.submit();
			});
			$("#searchuser").click(function(){
				if($("input[name='cardnumber']").val() == ""){
					$.messager.alert('��ʾ','ѧԱ���Ų���Ϊ��!','warning');return false;
				}
				if($('#cour').combobox('getValue') == ""){
					$.messager.alert('��ʾ','��ٿγ̲���Ϊ��!','warning');return false;
				}
				//ͨ��Ajax����ȡҪ�༭�ļ�¼
				var myurl="DataPage/getCourseInfo.jsp";
				$.ajax({
						type:"POST",
						url:myurl,
						dataType:"json",
						async:true, 
						contentType: "application/x-www-form-urlencoded; charset=utf-8",
						data:"params="+$("input[name='cardnumber']").val()+"@"+$('#cour').combobox('getValue'),
						timeout:60000,
						error:function(){
							$.messager.alert('��ʾ','���ݵ��ó���!','warning');return false;
						},
						success:function(myjson){
							if(myjson.p0 == "0"){
								$.messager.alert('��ʾ','�Բ��������ҵ�ѧԱ������!','warning');return false;
							}
							$("input[name='txtleatimes']").val(myjson.p1);
							$("input[name='txtarrived']").val(myjson.p2);
							$("input[name='txtleave']").val(myjson.p3);
							$("input[name='txtcut']").val(myjson.p4);
							if(myjson.p1 == "5"){
								$.messager.alert('��ʾ','��ǰʣ�����Ϊ5��!','warning');return false;
							}
							if(myjson.p3 == "2"){
								$.messager.alert('��ʾ','�ÿγ���ٴ�������!','warning');return false;
							}
						}
					}); 	
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
</script>
</head>
<body onload="loading()">
<jsp:include page="Incoming/loading.jsp"></jsp:include>
<% 
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd"); 
java.util.Date currentTime = new java.util.Date();//�õ���ǰϵͳʱ�� 
String str_date1 = formatter.format(currentTime); //������ʱ���ʽ�� 
String str_date2 = str_date1.toString(); //��Date������ʱ��ת�����ַ�����ʽ 
%>
<div class="easyui-layout" id="layoutmain" style="width:100%;height:100%;visibility: hidden">
<div id="form1" region="north" title="ѧԱ���" split="true"
	style="height: 245px; overflow: hidden;">
<OBJECT id="rd"
	style="display: none"
	codeBase="http://localhost:8023/StudentManagementSys/comRD800.dll"
	classid="clsid:638B238E-EB84-4933-B3C8-854B86140668"></OBJECT>
<form name="userform" method="post" action="FunctionPage/insertRecord.jsp"
	id="userform" style="padding: 5px; margin: 5px;">
<table border="1">
	<tr>
		<td colspan="6" style="background-color: #E0ECFF; text-align: left">
		&nbsp;<font color="#1F4D6C"><b>��ˢ�������뿨��:</b></font> <input type="text"
			name="cardnumber" style="background-color: white" /> &nbsp;&nbsp;&nbsp;<a class="easyui-linkbutton" id="searchuser" icon="icon-search"
	href="javascript:void(0)">��ѯ</a></td>
	</tr>
	<tr>
		<td width="70px">��ٿγ�</td>
		<td><div style="text-align:left"><select id="cour" name="cour" class="easyui-combobox"
			 style="width: 110px" listWidth="110px"
			editable="false">

		</select></div></td>
		<td width="60px">�������</td>
		<td ><div id="dats" style="width:100%;color: blue;text-align:left;"><input type="text" readonly style="cursor:pointer" value="<%=str_date2 %>" name="topicdate" onclick="new Calendar().show(this);"/></td>
		<td width="70px">��ٵص�</td>
		<td style="text-align:left"><div id ="ssite"></div></td>
	</tr>
	<tr>
		<td width="70px">�ѳ��ڴ���</td>
		<td><input name="txtarrived" readonly /></td>
		<td width="60px">����ٴ���</td>
		<td ><input name="txtleave" readonly /></td>
		<td width="60px">�ѿ��δ���</td>
		<td ><input name="txtcut" readonly /></td>
	</tr>
	<tr>
		<td width="70px">ʣ�����</td>
		<td><input name="txtleatimes" readonly /></td>
		<td colspan="4"></td>
	</tr>
	<tr>
		<td width="70px">���ԭ��</td>
		<td colspan="5"><div style="width:100%;text-align:left;"><textarea name="topicmain" class="easyui-validatebox" style="height:40px;width:550px"></textarea></div></td>
	</tr>
</table>
<br/>
<a class="easyui-linkbutton" id="adduser" icon="icon-add"
	href="javascript:void(0)">��  ��</a>
	<input type="hidden" name="tablename" value="leaveinfo" />
	<input type="hidden" name="label" value="0" />
	<input type="hidden" name="returnpage" value = "StuLeave.jsp" />
	<input type="hidden" name="fields" value="LeaveNo,LeaveCourse,LeaveData,LeaveReason,LeaveSite" />
	<input type="hidden" name="postparams" value="cardnumber;cour;topicdate;topicmain;site1" />
	<input type="hidden" name="types" value="0;0;0;0;0" />
	</form>
<form name="delrecord" method="post" action="FunctionPage/delRecord.jsp"
	style="display: none">
	<input type="hidden" name="idstr" />
	<input type="hidden" name="deltablename" value="leaveinfo" />
	<input type="hidden" name="delreturnpage" value="StuLeave.jsp" />
	</form>
</div>
<div id="view" region="center" title=""  split="true">
<table id="test"></table>
</div>
</div>
<div id="w" class="easyui-window" closed="true" title="�޸�ѧԱ����Ϣ"
	icon="icon-save"
	style="width: 520px; height: 190px; padding: 5px; background: #fafafa;">
<div class="easyui-layout" fit="true">
<div region="center" border="false"
	style="padding: 10px; background: #fff; border: 1px solid #ccc;">
<form name="updateinfo" method="post"
	action="FunctionPage/updateRecord.jsp" id="updateinfo" >
<table border="1" width="450px">
	<tr>
		<td width="70px">ѧԱ������</td>
		<td><input type="text" name="cardname1" class="easyui-validatebox"
			required="true" readonly /></td>
		<td width="60px">�ۿ���</td>
		<td><input type="text" name="cardrate1"
			class="easyui-validatebox" required="true" /></td>
	</tr>
</table>
<input type="hidden" name="id1"/>
<input type="hidden" name="tablename1" value="cardinfo" />
<input type="hidden" name="returnpage1" value = "CardOption.jsp" />
<input type="hidden" name="fields1" value="CardName;CardRate" />
<input type="hidden" name="postparams1" value="cardname1;cardrate1" />
<input type="hidden" name="types1" value="0;1" />
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