<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>用户设置</title>
<jsp:include page="Incoming/common.jsp"></jsp:include>
<script>
$(function(){
			var s="<%=session.getAttribute("Enter")%>"; 
			checkuserTime(s);
			//判断用户操作
			var info = <%=request.getQueryString()%>;
			checkuserAction(info,'用户','用户名');
			loadsiteInfo();
			//加载视图
			var P_width = document.getElementById("view").style.width;
			var P_height = document.getElementById("view").style.height;
			var tmp_w = P_width.split("px");
			var tmp_h = P_height.split("px");
			var pw = Number(tmp_w[0]);
			var ph = Number(tmp_h[0]);
			$('#test').datagrid({
				title:'用户列表',
				iconCls:'icon-uo',
				width:pw,
				height:ph,
				fit:true,
				nowrap: false,
				striped: true,
				url:'DataPage/getDatas.jsp?&p=userinfo&p=1@2@4@5',
				sortName: 'p0',
				sortOrder: 'desc',
				idField:'p0',
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'p0',title:'用户编号',width:pw*0.2},
					{field:'p1',title:'用户名',width:pw*0.3},
					{field:'p2',title:'用户所属教学点',width:pw*0.3-80},
					{field:'p3',title:'用户角色',width:pw*0.2}
				]],
				pagination:true,
				rownumbers:true,
				singleSelect:true,
				pageList:[5,10,15,20,25,30,35,40,45,50],
				toolbar:[{
					text:'编辑',
					iconCls:'icon-edit',
					handler:function(){
						var rows = $('#test').datagrid('getSelections');
						if(rows.length !=1){
							$.messager.alert('提示','请选择一条要编辑的记录!','warning');return false;
						}
						$('#w').window('open');
						//通过Ajax来读取要编辑的记录
						var myurl="DataPage/getRecordInfo.jsp";
						$.ajax({
							type:"POST",
							url:myurl,
							dataType:"json",
							async:true, 
							data:"params="+rows[0].p0+";userinfo;2@3@4@5",
							timeout:60000,
							error:function(){
								$.messager.alert('提示','数据调用出错!','warning');return false;
							},
							success:function(myjson){
								$("input[name='username1']").val(myjson.p1);
								$("input[name='password1']").val(myjson.p2);
								$("input[name='id1']").val(rows[0].p0);
								//$("#role1").val(rows[0].p4);
								$('#site1').combobox('setValue',myjson.p3); 
								$('#role1').combobox('setValue',myjson.p4); 
								//$("input[name='site1']").val(myjson.p3);
							}
						}); 	
					}
				},'-',{
					text:'删除',
					iconCls:'icon-no',
					handler:function(){
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
				if($("input[name='username']").val()==""){
					$.messager.alert('提示','用户名不能为空!','warning');return false;
				}
				if($("input[name='password']").val()==""){
					$.messager.alert('提示','密码不能为空!','warning');return false;
				}
				//if($("input[name='site']").val()==""){
					//$.messager.alert('提示','教学点不能为空!','warning');return false;
				//}
				//$("input[name='keyvalue']").val($("input[name='username']").val());
				document.userform.submit();
			});
			//修改记录
			$("#update1").click(function(){
				if($("input[name='username1']").val()==""){
					$.messager.alert('提示','用户名不能为空!','warning');return false;
				}
				if($("input[name='password1']").val()==""){
					$.messager.alert('提示','密码不能为空!','warning');return false;
				}
				if($("input[name='site1']").val()==""){
					$.messager.alert('提示','教学点不能为空!','warning');return false;
				}
				document.updateinfo.submit();
			});
		});
</script>
</head>
<body onload="loading()">
<jsp:include page="Incoming/loading.jsp"></jsp:include>
<div class="easyui-layout" id="layoutmain" style="width:100%;height:100%;visibility: hidden">
<div id="form1" region="north" title="用户设置" split="true"
	style="height: 130px; overflow: hidden;">
<form name="userform" method="post" action="FunctionPage/insertRecord.jsp"
	id="userform" style="padding: 5px; margin: 5px;">
<table border="1" width="450px">
	<tr>
		<td width="60px">用户名</td>
		<td><input type="text" name="username" class="easyui-validatebox"
			 /></td>
		<td width="60px">密码</td>
		<td><input type="text" name="password"
			class="easyui-validatebox"  /></td>
	</tr>
	<tr>
		<td>教学点</td>
		<td><select id="site" name="site" class="easyui-combobox"
			 style="width: 150px" listWidth="150px"
			editable="false">

		</select></td>
		<td>角色</td>
		<td align="center">
			<div style="text-align:left"><select name="role" id="role" class="easyui-combobox" style="width: 150px" listWidth="150px"
			editable="false">
  				<option value="教学点辅导员">教学点辅导员</option>
  				<option value="管理员">管理员</option>
  				<option value="员工">员工</option>
			</select></div>
		</td>
	</tr>
</table>
<a class="easyui-linkbutton" id="adduser" icon="icon-add"
	href="javascript:void(0)">添加</a>
	<input type="hidden" name="tablename" value="userinfo" />
	<input type="hidden" name="label" value="1;UserName;username" />
	<input type="hidden" name="returnpage" value = "UserOption.jsp" />
	<input type="hidden" name="fields" value="UserName,UserPwd,UserSite,UserRole" />
	<input type="hidden" name="postparams" value="username;password;site;role" />
	<input type="hidden" name="types" value="0;0;0;0" />
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
<div id="w" class="easyui-window" minimizable="false" maximizable="false" collapsible="false" closed="true" title="修改用户信息"
	icon="icon-save"
	style="width: 520px; height: 190px; padding: 5px; background: #fafafa;">
<div class="easyui-layout" fit="true">
<div region="center" border="false"
	style="padding: 10px; background: #fff; border: 1px solid #ccc;">
<form name="updateinfo" method="post"
	action="FunctionPage/updateRecord.jsp" id="updateinfo" >
<table border="1" width="450px">
	<tr>
		<td width="60px">用户名</td>
		<td><input type="text" name="username1"
			class="easyui-validatebox" readonly /></td>
		<td width="60px">密码</td>
		<td><input type="text" name="password1"
			class="easyui-validatebox" required="true" /></td>
	</tr>
	<tr>
		<td>教学点</td>
		<td><select id="site1" name="site1" class="easyui-combobox"
			 style="width: 130px" listWidth="130px"
			editable="false">

		</select></td>
		<td>角色</td>
		<td align="center"><div style="text-align:left"><select name="role1" id="role1" class="easyui-combobox" style="width: 130px" listWidth="130px"
			editable="false">
  				<option value="教学点辅导员">教学点辅导员</option>
  				<option value="管理员">管理员</option>
  				<option value="员工">员工</option>
			</select></div></td>
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
	>修改</a> <a class="easyui-linkbutton"
	icon="icon-cancel" href="javascript:void(0)"
	onclick="$('#w').window('close');">取消</a></div>
</div>
</div>
</body>
</html>