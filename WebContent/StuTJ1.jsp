<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>学员情况统计</title>
<jsp:include page="Incoming/common.jsp"></jsp:include>
<script>
$(function(){
			var s="<%=session.getAttribute("Enter")%>"; 
			checkuserTime(s);
			//判断用户操作
			var info = <%=request.getQueryString()%>;
			checkuserAction(info,'用户','用户名');
			loadsiteInfo();
			$("#form1").css("height",$("#tb1").attr("height"));
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
				title:'',
				iconCls:'icon-uo',
				width:pw,
				height:ph,
				fit:true,
				nowrap: false,
				striped: true,
				url:'DataPage/getDatasBysite.jsp?&p=stuinfo&q=6@2@15@7@14@9@10@4&r=StuSite&s='+site,
				//url:'DataPage/getDatas.jsp?&p=stuinfo&p=6@2@15@7@8@9@10@4',
				sortName: 'p0',
				sortOrder: 'desc',
				idField:'p0',
				frozenColumns:[[
	                {field:'p0',title:'学员卡号',width:pw*0.1},
					{field:'p1',title:'学员姓名',width:pw*0.1},
					{field:'p2',title:'性别',width:pw*0.1},
					{field:'p3',title:'加入日期',width:pw*0.2},
					{field:'p4',title:'区域',width:pw*0.1},
					{field:'p5',title:'卡内金额',width:pw*0.1},
					{field:'p6',title:'消费金额',width:pw*0.1},
					{field:'p7',title:'教学点',width:pw*0.2}
				]],
				pagination:true,
				rownumbers:true,
				singleSelect:true,
				pageList:[5,10,15,20,25,30,35,40,45,50]
			});
			}
			else{
			$('#test').datagrid({
				title:'',
				iconCls:'icon-uo',
				width:pw,
				height:ph,
				fit:true,
				nowrap: false,
				striped: true,
				url:'DataPage/getDatas.jsp?&p=stuinfo&p=6@2@15@7@8@9@10@4',
				sortName: 'p0',
				sortOrder: 'desc',
				idField:'p0',
				frozenColumns:[[
	                {field:'p0',title:'学员卡号',width:pw*0.1},
					{field:'p1',title:'学员姓名',width:pw*0.1},
					{field:'p2',title:'性别',width:pw*0.1},
					{field:'p3',title:'加入日期',width:pw*0.2},
					{field:'p4',title:'卡类型',width:pw*0.1},
					{field:'p5',title:'卡内金额',width:pw*0.1},
					{field:'p6',title:'消费金额',width:pw*0.1},
					{field:'p7',title:'教学点',width:pw*0.2}
				]],
				pagination:true,
				rownumbers:true,
				singleSelect:true,
				pageList:[5,10,15,20,25,30,35,40,45,50]
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
			//查找学员信息
			$("#searchuser").click(function(){
				if($("input[name='cardnumber']").val() == ""){
					$.messager.alert('提示','学员卡号或姓名不能为空!','warning');return false;
				}
				$('#test').datagrid({'url':'DataPage/getTJSearchDatas.jsp?&p=stuinfo&p=6@2@15@7@8@9@10@4&p=StuName@StuCrdNo&p='+encodeURI($("input[name='cardnumber']").val()+'@'+$("input[name='cardnumber']").val())+"&p="+StuArea+"@"+encodeURI($("#stuarea").val())});
			});
			//导出Excel表
			$("#exportXLS").click(function(){
				window.open("FunctionPage/JXLTest.jsp");
			});
			//添加记录
			$("#adduser").click(function(){
				if($("input[name='username']").val()==""){
					$.messager.alert('提示','用户名不能为空!','warning');return false;
				}
				if($("input[name='password']").val()==""){
					$.messager.alert('提示','密码不能为空!','warning');return false;
				}
				if($("input[name='site']").val()==""){
					$.messager.alert('提示','教学点不能为空!','warning');return false;
				}
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
			var timename=setInterval("ReadCardNo();",3000); 
		});
</script>
</head>
<body onload="loading()">
<jsp:include page="Incoming/loading.jsp"></jsp:include>
<div class="easyui-layout" id="layoutmain"
	style="width: 100%; height: 100%; visibility: hidden">
<div id="form1" region="north" title="学员情况统计" split="false"
	style="height: 63px; overflow: hidden;"><OBJECT id="rd"
	style="display: none"
	codeBase="http://localhost:8023/StudentManagementSys/comRD800.dll"
	classid="clsid:638B238E-EB84-4933-B3C8-854B86140668"></OBJECT>
<form name="userform1" method="post"
	action="FunctionPage/insertRecord.jsp" id="userform"
	style="padding: 0px; margin: 0px;">
<table id="tb1" border="1" width="100%" height="64">
	<tr>
		<td colspan="6" style="background-color: #E0ECFF; text-align: left">
		&nbsp;<font color="#1F4D6C"><b>请输入学员卡号或姓名:</b></font> <input
			type="text" name="cardnumber" /> &nbsp;<font color="#1F4D6C"><b>区域:</b></font><select
			name="stuarea" id="stuarea">
			<option value=""></option>
			<option value="浦东新区">浦东新区</option>
			<option value="黄浦区">黄浦区</option>
			<option value="卢湾区">卢湾区</option>
			<option value="徐汇区">徐汇区</option>
			<option value="静安区">静安区</option>
			<option value="长宁区">长宁区</option>
			<option value="闵行区">闵行区</option>
			<option value="闸北区">闸北区</option>
			<option value="虹口区">虹口区</option>
			<option value="杨浦区">杨浦区</option>
			<option value="松江区">松江区</option>
			<option value="嘉定区">嘉定区</option>
			<option value="青浦区">青浦区</option>
			<option value="奉贤区">奉贤区</option>
			<option value="宝山区">宝山区</option>
			<option value="崇明岛">崇明岛</option>
		</select> <br />
		<a class="easyui-linkbutton" id="searchuser" icon="icon-search"
			href="javascript:void(0)">查询</a></td>
	</tr>
</table>
</form>
<form name="delrecord" method="post" action="FunctionPage/delRecord.jsp"
	style="display: none"><input type="hidden" name="idstr" /> <input
	type="hidden" name="deltablename" value="userinfo" /> <input
	type="hidden" name="delreturnpage" value="UserOption.jsp" /></form>
</div>
<div id="view" region="center" title="学员信息列表" split="true">
<table id="test"></table>
</div>
</div>
<div id="w" class="easyui-window" closed="true" title="修改用户信息"
	icon="icon-save"
	style="width: 520px; height: 190px; padding: 5px; background: #fafafa;">
<div class="easyui-layout" fit="true">
<div region="center" border="false"
	style="padding: 10px; background: #fff; border: 1px solid #ccc;">
<form name="updateinfo" method="post"
	action="FunctionPage/updateRecord.jsp" id="updateinfo">
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
			required="true" style="width: 130px" listWidth="130px"
			editable="false">

		</select></td>
		<td>角色</td>
		<td align="center"><select id="role1" class="easyui-combobox"
			name="role1" required="true" style="width: 130px" listWidth="130px"
			editable="false">
			<option>教学点辅导员</option>
			<option>管理员</option>
		</select></td>
	</tr>
</table>
<input type="hidden" name="id1" /> <input type="hidden"
	name="tablename1" value="userinfo" /> <input type="hidden"
	name="returnpage1" value="UserOption.jsp" /> <input type="hidden"
	name="fields1" value="UserName;UserPwd;UserSite;UserRole" /> <input
	type="hidden" name="postparams1"
	value="username1;password1;site1;role1" /> <input type="hidden"
	name="types1" value="0;0;0;0" /></form>
</div>
<div region="south" border="false"
	style="text-align: right; height: 30px; line-height: 30px;"><a
	class="easyui-linkbutton" id="update1" icon="icon-ok"
	href="javascript:void(0)">修改</a> <a class="easyui-linkbutton"
	icon="icon-cancel" href="javascript:void(0)"
	onclick="$('#w').window('close');">取消</a></div>
</div>
</div>
</body>
</html>