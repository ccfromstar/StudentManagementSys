<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>学员转卡</title>
<jsp:include page="Incoming/common.jsp"></jsp:include>
<script>
$(function(){
			var s="<%=session.getAttribute("Enter")%>"; 
			checkuserTime(s);
			
			//判断用户操作
			var info = <%=request.getQueryString()%>;
			checkuserAction(info,'转卡','转卡');
			loadsiteInfo();
			loadcourseInfo();
			loadcardInfo();
			$("#form1").css("height",$("#tb1").attr("height"));
			//加载视图
			var P_width = document.getElementById("view").style.width;
			var P_height = document.getElementById("view").style.height;
			var tmp_w = P_width.split("px");
			var tmp_h = P_height.split("px");
			var pw = Number(tmp_w[0]);
			var ph = Number(tmp_h[0]);
			$('#test').datagrid({
				title:'学员消费清单',
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
	                {field:'p0',title:'消费ID',width:pw*0.2},
					{field:'p1',title:'消费日期',width:pw*0.3},
					{field:'p2',title:'消费金额',width:pw*0.3-80},
					{field:'p3',title:'消费地点',width:pw*0.2}
				]],
				pagination:true,
				rownumbers:true,
				singleSelect:true,
				pageList:[5,10,15,20,25,30,35,40,45,50],
				toolbar:[{
					text:'添加消费',
					iconCls:'icon-add',
					handler:function(){
						if($("input[name='cardnumber']").val() == ""){
							$.messager.alert('提示','请刷卡或输入卡号!','warning');return false;
						}
						$("input[name='coststu1']").val($("input[name='cardnumber']").val());
						$('#wadd').window('open');
					}
				},'-',{
					text:'详细',
					iconCls:'icon-edit',
					handler:function(){
						var rows = $('#test').datagrid('getSelections');
						if(rows.length !=1){
							$.messager.alert('提示','请选择一条要查看的记录!','warning');return false;
						}
						$('#w').window('open');
						//通过Ajax来读取要编辑的记录
						var myurl="DataPage/getRecordInfo.jsp";
						$.ajax({
							type:"POST",
							url:myurl,
							dataType:"json",
							async:true, 
							data:"params="+rows[0].p0+";costinfo;2@3@4@5@6@7@8",
							timeout:60000,
							error:function(){
								$.messager.alert('提示','数据调用出错!','warning');return false;
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
			//查找学员信息
			$("#searchuser").click(function(){
				if($("input[name='cardnumber']").val() == ""){
					$.messager.alert('提示','学员卡号不能为空!','warning');return false;
				}
				//通过Ajax来读取要编辑的记录
				var myurl="DataPage/getStuInfo.jsp";
				$.ajax({
						type:"POST",
						url:myurl,
						dataType:"json",
						async:true, 
						data:"params="+$("input[name='cardnumber']").val()+";stuinfo;1@2@3@4@5@6@7@8@9@10@11@12@13@14",
						timeout:60000,
						error:function(){
							$.messager.alert('提示','数据调用出错!','warning');return false;
						},
						success:function(myjson){
							if(myjson.p1=="0"){
								$.messager.alert('提示','您查找的学员信息不存在!','warning');
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
			//添加消费
			$("#addcost").click(function(){
				
				if($("input[name='crd']").val()==""){
					$.messager.alert('提示','请选择要转卡的学员!','warning');return false;
				}
				$("input[name='topicdate']").val($("#dat").text());
				document.icost.submit();
			});
			//修改记录
			$("#addmoney").click(function(){
				if($("input[name='stucrdstatus']").val()=="停用"){
					$.messager.alert('提示','对不起，您的学员卡已被停用!','warning');return false;
				}
				if($('#crd').combobox('getValue')==$("input[name='stucrdtype']").val()){
					$.messager.alert('提示','不能转成相同类型的卡!','warning');return false;
				}
				if($("input[name='stuid']").val()==""){
					$.messager.alert('提示','请选择要转卡的学员!','warning');return false;
				}
				if($("input[name='crd']").val()==""){
					$.messager.alert('提示','请选择要转的卡的类型!','warning');return false;
				}
				$("input[name='id1']").val($("input[name='stuid']").val());
				document.userform1.submit();
			});
			var timename=setInterval("ReadCardNo();",3000); 
		});
</script>
</head>
<body onload="loading()">
<jsp:include page="Incoming/loading.jsp"></jsp:include>
<%
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
	String str_date1 = formatter.format(currentTime); //将日期时间格式化 
	String str_date2 = str_date1.toString(); //将Date型日期时间转换成字符串形式
%>
<div class="easyui-layout" id="layoutmain"
	style="width: 100%; height: 100%; visibility: hidden">
<div id="form1" region="north" title="学员转卡" split="true"
	style="height: 185px; overflow: hidden;"><OBJECT id="rd"
	style="display: none"
	codeBase="http://localhost:8023/StudentManagementSys/comRD800.dll"
	classid="clsid:638B238E-EB84-4933-B3C8-854B86140668"></OBJECT>
<form name="userform1" method="post"
	action="FunctionPage/updateRecord.jsp" id="userform"
	style="padding: 0px; margin: 0px;">
<table id="tb1" border="1" width="100%">
	<tr>
		<td colspan="6" style="background-color: #E0ECFF; text-align: left">
		&nbsp;<font color="#1F4D6C"><b>请刷卡或输入卡号:</b></font> <input type="text"
			name="cardnumber" style="background-color: white" /> &nbsp;<a
			class="easyui-linkbutton" id="searchuser" icon="icon-search"
			href="javascript:void(0)">查询</a></td>
	</tr>
	<tr>
		<td width="12.5%">学员姓名</td>
		<td width="12.5%"><input type="text" name="stuname" disabled
			style="background-color: white; border: none; text-align: left" /></td>
		<td width="12.5%">联系电话</td>
		<td width="12.5%"><input type="text" name="stutel" disabled
			style="background-color: white; border: none; text-align: left" /></td>
		<td width="12.5%">学员卡状态</td>
		<td width="12.5%"><input type="text" name="stucrdstatus" disabled
			style="background-color: white; border: none; text-align: left" /></td>
	</tr>
	<tr>
		<td width="12.5%">学员卡卡号</td>
		<td width="12.5%"><input type="text" name="stucrdno" disabled
			style="background-color: white; border: none; text-align: left" /></td>
		<td width="12.5%">学员卡当前类型</td>
		<td width="12.5%"><input type="text" name="stucrdtype" disabled
			style="background-color: white; border: none; text-align: left" /></td>
		<td width="12.5%">办理日期</td>
		<td width="12.5%"><input type="text" name="stucrdcreatedate"
			disabled
			style="background-color: white; border: none; text-align: left" /></td>
	</tr>
	<tr>
		<td width="12.5%">学员卡余额</td>
		<td width="12.5%"><input type="text" name="stucrdbalance"
			disabled
			style="background-color: white; border: none; text-align: left" /></td>
		<td width="12.5%">累计消费</td>
		<td width="12.5%"><input type="text" name="accucusmoney" disabled
			style="background-color: white; border: none; text-align: left" /></td>
		<td width="12.5%">消费次数</td>
		<td width="12.5%"><input type="text" name="cosnum" disabled
			style="background-color: white; border: none; text-align: left" /></td>
	</tr>
	<tr>
		<td width="12.5%">区域</td>
		<td width="12.5%"><input type="text" name="stuarea" disabled
			style="background-color: white; border: none; text-align: left" /></td>
		<td width="12.5%">转卡类型</td>
		<td width="12.5%"><div style="text-align:left"><select id="crd" name="crd" class="easyui-combobox"
			 style="width: 110px" listWidth="110px"
			editable="false">

		</select></div></td>
		<td colspan="2"></td>
	</tr>
</table>
<br/>
<br/>
&nbsp;&nbsp;<a class="easyui-linkbutton" id="addmoney" icon="icon-add"
	href="javascript:void(0)">确认转卡</a>
	<br/>
	<input type="hidden" name="stubrithday" disabled
			style="background-color: white; border: none; text-align: left" />
	<input type="hidden" name="stusite" disabled
			style="background-color: white; border: none; text-align: left" />
	<input type="hidden" name="stuid" readonly
			style="background-color: white; border: none; text-align: left" />
	 <input
	type="hidden" name="id1" /> <input type="hidden" name="tablename1"
	value="stuinfo" /> <input type="hidden" name="returnpage1"
	value="StuChgCrd.jsp" /> <input type="hidden" name="fields1"
	value="StuCrdType" /> <input type="hidden" name="postparams1"
	value="crd" /> <input type="hidden" name="types1" value="0" /></form>
<form name="delrecord" method="post" action="FunctionPage/delRecord.jsp"
	style="display: none"><input type="hidden" name="idstr" /> <input
	type="hidden" name="deltablename" value="costinfo" /> <input
	type="hidden" name="delreturnpage" value="StuCost.jsp" /></form>
</div>
<div id="view" region="center" style="display: none" title=""
	split="true">
<table id="test"></table>
</div>
</div>
<div id="w" class="easyui-window" closed="true" title="消费信息明细"
	icon="icon-save"
	style="width: 720px; height: 290px; padding: 5px; background: #fafafa;">
<div class="easyui-layout" fit="true">
<div region="center" border="false"
	style="padding: 10px; background: #fff; border: 1px solid #ccc;">
<form name="updateinfo" method="post"
	action="FunctionPage/updateRecord.jsp" id="updateinfo">
<table border="1" width="650px">
	<tr>
		<td width="70px">消费日期</td>
		<td><input type="text" name="costdata" class="easyui-validatebox"
			readonly /></td>
		<td width="70px">消费金额</td>
		<td><input type="text" name="costpay" class="easyui-validatebox"
			readonly /></td>
		<td width="70px">消费地点</td>
		<td><input type="text" name="costsite" class="easyui-validatebox"
			readonly /></td>
	</tr>
	<tr>
		<td>课程名</td>
		<td><input type="text" name="costname" class="easyui-validatebox"
			readonly /></td>
		<td>课程周期</td>
		<td><input type="text" name="costcycle"
			class="easyui-validatebox" readonly /></td>
		<td>消费学员</td>
		<td><input type="text" name="coststu" class="easyui-validatebox"
			readonly /></td>
	</tr>
	<tr>
		<td>备注</td>
		<td colspan="5">
		<div style="width: 100%; text-align: left;"><textarea name="bz"
			class="easyui-validatebox" style="height: 50px; width: 520px"
			readonly></textarea></div>
		</td>
	</tr>
</table>
</form>
</div>
<div region="south" border="false"
	style="text-align: right; height: 30px; line-height: 30px;"></div>
</div>
</div>

<div id="wadd" class="easyui-window" closed="true" title="添加消费"
	icon="icon-save"
	style="width: 720px; height: 290px; padding: 5px; background: #fafafa;">
<div class="easyui-layout" fit="true">
<div region="center" border="false"
	style="padding: 10px; background: #fff; border: 1px solid #ccc;">
<form name="icost" method="post" action="FunctionPage/insertCost.jsp"
	id="icost">
<table border="1" width="650px">
	<tr>
		<td width="70px">消费日期</td>
		<td>
		<div id="dat" style="width: 100%; color: blue; text-align: left;"><%=str_date2%></div>
		</td>
		<td width="70px">消费金额</td>
		<td><input type="text" name="costpay1" class="easyui-numberbox"
			precision="2" required="true" /></td>
		<td width="70px">消费地点</td>
		<td><select id="site1" name="site1" class="easyui-combobox"
			required="true" style="width: 110px" listWidth="110px"
			editable="false">

		</select></td>
	</tr>
	<tr>
		<td>课程名</td>
		<td><select id="cour" name="cour" class="easyui-combobox"
			required="true" style="width: 110px" listWidth="110px"
			editable="false">

		</select></td>
		<td>课程周期</td>
		<td><input type="text" name="costcycle1"
			class="easyui-validatebox" /></td>
		<td>消费学员</td>
		<td><input type="text" name="coststu1" class="easyui-validatebox"
			readonly /></td>
	</tr>
	<tr>
		<td>备注</td>
		<td colspan="5">
		<div style="width: 100%; text-align: left;"><textarea name="bz1"
			class="easyui-validatebox" style="height: 50px; width: 520px"></textarea></div>
		</td>
	</tr>
</table>
<input type="hidden" name="topicdate" /> <input type="hidden"
	name="tablename" value="costinfo" /> <input type="hidden" name="label"
	value="0" /> <input type="hidden" name="returnpage"
	value="StuCost.jsp" /> <input type="hidden" name="fields"
	value="CostDate,CostMoney,CostSite,CostCourse,CostNotes,CourseCycle,StuCrdNo" />
<input type="hidden" name="postparams"
	value="topicdate;costpay1;site1;cour;bz1;costcycle1;coststu1" /> <input
	type="hidden" name="types" value="0;1;0;0;0;0;0" /></form>
</div>

<div region="south" border="false"
	style="text-align: right; height: 30px; line-height: 30px;"><a
	class="easyui-linkbutton" id="addcost" icon="icon-ok"
	href="javascript:void(0)">添加消费</a> <a class="easyui-linkbutton"
	icon="icon-cancel" href="javascript:void(0)"
	onclick="$('#wadd').window('close');">取消</a></div>
</div>
</div>
</body>
</html>