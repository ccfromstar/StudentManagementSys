<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>学员卡设置</title>
<jsp:include page="Incoming/common.jsp"></jsp:include>
<script>
$(function(){
			var s="<%=session.getAttribute("Enter")%>"; 
			checkuserTime(s);
			//判断用户操作
			var info = <%=request.getQueryString()%>;
			checkuserAction(info,'学员卡','学员卡名称');
			loadcourseInfo();
			//loadcourseInfo1();
			//加载视图
			var P_width = document.getElementById("view").style.width;
			var P_height = document.getElementById("view").style.height;
			var tmp_w = P_width.split("px");
			var tmp_h = P_height.split("px");
			var pw = Number(tmp_w[0]);
			var ph = Number(tmp_h[0]);
			$('#test').datagrid({
				title:'学员卡列表',
				iconCls:'icon-uo',
				width:pw,
				height:ph,
				fit:true,
				nowrap: false,
				striped: true,
				url:'DataPage/getDatas.jsp?&p=cardinfo&p=1@2@3@4',
				sortName: 'p0',
				sortOrder: 'desc',
				idField:'p0',
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'p0',title:'编号',width:pw*0.2},
					{field:'p1',title:'学员卡名称',width:pw*0.2},
					{field:'p2',title:'课程名称',width:pw*0.3},
					{field:'p3',title:'价格',width:pw*0.3-80}
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
							data:"params="+rows[0].p0+";cardinfo;2@3@4",
							timeout:60000,
							error:function(){
								$.messager.alert('提示','数据调用出错!','warning');return false;
							},
							success:function(myjson){
								$("input[name='cardname1']").val(myjson.p1);
								$("input[name='cardcourse1']").val(myjson.p2);
								$("input[name='cardprice1']").val(myjson.p3);
								$("input[name='id1']").val(rows[0].p0);
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
				if($("input[name='cardname']").val()==""){
					$.messager.alert('提示','学员卡名称不能为空!','warning');return false;
				}
				if($("input[name='cardcourse']").val()==""){
					$.messager.alert('提示','课程名称不能为空!','warning');return false;
				}
				if($("input[name='cardprice']").val()==""){
					$.messager.alert('提示','价格不能为空!','warning');return false;
				}
				document.userform.submit();
			});
			//修改记录
			$("#update1").click(function(){
				if($("input[name='cardname1']").val()==""){
					$.messager.alert('提示','学员卡名称不能为空!','warning');return false;
				}
				if($("input[name='cardrate1']").val()==""){
					$.messager.alert('提示','折扣率不能为空!','warning');return false;
				}
				document.updateinfo.submit();
			});
		});
</script>
</head>
<body onload="loading()">
<jsp:include page="Incoming/loading.jsp"></jsp:include>
<div class="easyui-layout" id="layoutmain" style="width:100%;height:100%;visibility: hidden">
<div id="form1" region="north" title="学员卡设置" split="true"
	style="height: 130px; overflow: hidden;">
<form name="userform" method="post" action="FunctionPage/insertRecord.jsp"
	id="userform" style="padding: 5px; margin: 5px;">
<table border="1" width="660px">
	<tr>
		<td width="70px">学员卡名称</td>
		<td><input type="text" name="cardname" class="easyui-validatebox" /></td>
		<td width="60px">课程名称</td>
		<td><select id="cour" name="cardcourse" class="easyui-combobox"
			 style="width: 110px" listWidth="110px"
			editable="false">

		</select></td>
		<td width="60px">价格</td>
		<td><input type="text" name="cardprice"
			class="easyui-numberbox" precision="2" /></td>
	</tr>
</table>
<br/>
<a class="easyui-linkbutton" id="adduser" icon="icon-add"
	href="javascript:void(0)">添加</a>
	<input type="hidden" name="tablename" value="cardinfo" />
	<input type="hidden" name="label" value="0" />
	<input type="hidden" name="returnpage" value = "CardOption.jsp" />
	<input type="hidden" name="fields" value="CardName,CardCourse,CardPrice" />
	<input type="hidden" name="postparams" value="cardname;cardcourse;cardprice" />
	<input type="hidden" name="types" value="0;0;1" />
	</form>
<form name="delrecord" method="post" action="FunctionPage/delRecord.jsp"
	style="display: none">
	<input type="hidden" name="idstr" />
	<input type="hidden" name="deltablename" value="cardinfo" />
	<input type="hidden" name="delreturnpage" value="CardOption.jsp" />
	</form>
</div>
<div id="view" region="center" title=""  split="true">
<table id="test"></table>
</div>
</div>
<div id="w" class="easyui-window" minimizable="false" maximizable="false" collapsible="false" closed="true" title="修改学员卡信息"
	icon="icon-save"
	style="width: 520px; height: 190px; padding: 5px; background: #fafafa;">
<div class="easyui-layout" fit="true">
<div region="center" border="false"
	style="padding: 10px; background: #fff; border: 1px solid #ccc;">
<form name="updateinfo" method="post"
	action="FunctionPage/updateRecord.jsp" id="updateinfo" >
<table border="1" width="450px">
	<tr>
		<td width="70px">学员卡名称</td>
		<td><input type="text" name="cardname1" class="easyui-validatebox"
			required="true" readonly /></td>
		<td width="60px">课程名称</td>
		<td><input type="text" name="cardcourse1" class="easyui-validatebox"
			required="true" readonly /></td>
	</tr>
	<tr>
		<td width="70px">价格</td>
		<td><input type="text" name="cardprice1"
			class="easyui-numberbox" precision="2" /></td>
		<td width="60px"></td>
		<td></td>
	</tr>
</table>
<input type="hidden" name="id1"/>
<input type="hidden" name="tablename1" value="cardinfo" />
<input type="hidden" name="returnpage1" value = "CardOption.jsp" />
<input type="hidden" name="fields1" value="CardName,CardCourse,CardPrice" />
<input type="hidden" name="postparams1" value="cardname1;cardcourse1;cardprice1" />
<input type="hidden" name="types1" value="0;0;1" />
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