<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>学员注册</title>
<jsp:include page="Incoming/common.jsp"></jsp:include>
<script>
$(function(){
			var s="<%=session.getAttribute("Enter")%>"; 
			checkuserTime(s);
			
			//判断用户操作
			var info = <%=request.getQueryString()%>;
			checkuserAction(info,'学员','学员卡号');
			var s="<%=session.getAttribute("userRole")%>"; 
			if(s != "管理员"){
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
			$("#addstu").click(function(){
				if($("input[name='stuname']").val()==""){
					$.messager.alert('提示','学员姓名不能为空!','warning');return false;
				}
				if($("input[name='stubrithday']").val()==""){
					$.messager.alert('提示','生日不能为空!','warning');return false;
				}
				if($("input[name='stutel']").val()==""){
					$.messager.alert('提示','联系电话不能为空!','warning');return false;
				}
				if($("input[name='stucrdno']").val()==""){
					$.messager.alert('提示','学员卡卡号不能为空!','warning');return false;
				}
				if($("input[name='crd']").val()==""){
					$.messager.alert('提示','学员卡类型不能为空!','warning');return false;
				}
				if($("input[name='site1']").val()==""){
					$.messager.alert('提示','所属教学点不能为空!','warning');return false;
				}
				$("input[name='topicdate']").val($("#dats").text());
				document.userform1.submit();
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
			//var timename=setInterval("ReadCardNo();",3000); 
		});
</script>
</head>
<body onload="loading()">
<jsp:include page="Incoming/loading.jsp"></jsp:include>
<% 
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
String str_date1 = formatter.format(currentTime); //将日期时间格式化 
String str_date2 = str_date1.toString(); //将Date型日期时间转换成字符串形式 
%> 
<% 
java.text.SimpleDateFormat formatter1 = new java.text.SimpleDateFormat("yyyy-MM-dd"); 
java.util.Date currentTime1 = new java.util.Date();//得到当前系统时间 
String str_date3 = formatter1.format(currentTime1); //将日期时间格式化 
String str_date4 = str_date3.toString(); //将Date型日期时间转换成字符串形式 
%> 
<div class="easyui-layout" id="layoutmain" style="width:100%;height:100%;visibility: hidden">
<div id="form1" region="north" title="学员注册" split="true"
	style="height: 700px; overflow: hidden;">
<form name="userform1" method="post" action="FunctionPage/insertRecord.jsp"
	id="userform" style="padding: 0px; margin: 0px;">
<table id="tb1" border="1" width="100%">
	<tr>
			<td width="12.5%">学员姓名</td>
			<td width="12.5%" style="text-align:left"><input type="text" name="stuname"   /></td>
			<td width="12.5%">性别</td>
			<td width="12.5%" style="text-align:left"><select name="sex" id="sex"  class="easyui-combobox"
			 style="width: 150px" listWidth="150px"
			editable="false">
  <option value="男">男</option>
  <option value="女">女</option>
</select></td>
	</tr>
	<tr>
			<td width="12.5%">生日</td>
			<td width="12.5%" style="text-align:left"><input type="text" readonly style="cursor:pointer" name="stubrithday" onclick="new Calendar().show(this);"/></td>
			<td width="12.5%">联系电话</td>
			<td width="12.5%" style="text-align:left"><input type="text" name="stutel"   /></td>
			</tr>
	<tr>
			<td width="12.5%">学员卡卡号</td>
			<td width="12.5%" style="text-align:left"><input type="text" name="stucrdno" /></td>
			<td width="12.5%">学员卡类型</td>
			<td width="12.5%" style="text-align:left"><select id="crd" name="crd" class="easyui-combobox"
			 style="width: 150px" listWidth="150px"
			editable="false">

		</select></td>
			</tr>
	<tr>
			<td width="12.5%">所属教学点</td>
			<td width="12.5%" style="text-align:left"><div id ="ssite"></div></td>
			<td width="12.5%">区域</td>
			<td width="12.5%" style="text-align:left"><select name="stuarea" id="stuarea" >
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
</select></td>
	</tr>
	<tr>
			<td width="12.5%" height="25px">家庭地址</td>
			<td colspan="3" height="25px" style="text-align:left"><input type="text" name="stuaddress" style="width: 99%" /></td>
	</tr>
	<tr>
			<td width="12.5%" height="25px">办理日期</td>
			<td colspan="3" ><div id="dats" style="width:100%;color: blue;text-align:left;"><%=str_date4 %></div></td>
	</tr>
</table>
<br/><br/>
&nbsp;&nbsp;<a class="easyui-linkbutton" id="addstu" icon="icon-add"
	href="javascript:void(0)">注册学员</a>
	<br/>
	<input type="hidden" name="accucusmoney"  value="0"/>
	<input type="hidden" name="stucrdstatus" value="启用"/>
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
<div id="w" class="easyui-window" closed="true" title="消费信息明细"
	icon="icon-save"
	style="width: 720px; height: 290px; padding: 5px; background: #fafafa;">
<div class="easyui-layout" fit="true">
<div region="center" border="false"
	style="padding: 10px; background: #fff; border: 1px solid #ccc;">
<form name="updateinfo" method="post"
	action="FunctionPage/updateRecord.jsp" id="updateinfo" >
<table border="1" width="650px">
	<tr>
		<td width="70px">消费日期</td>
		<td><input type="text" name="costdata" class="easyui-validatebox" readonly /></td>
		<td width="70px">消费金额</td>
		<td><input type="text" name="costpay" class="easyui-validatebox" readonly /></td>
		<td width="70px">消费地点</td>
		<td><input type="text" name="costsite" class="easyui-validatebox" readonly /></td>
	</tr>
	<tr>
		<td>课程名</td>
		<td><input type="text" name="costname" class="easyui-validatebox" readonly /></td>
		<td>课程周期</td>
		<td><input type="text" name="costcycle" class="easyui-validatebox" readonly /></td>
		<td>消费学员</td>
		<td><input type="text" name="coststu" class="easyui-validatebox" readonly /></td>
	</tr>
	<tr>
		<td>备注</td>
		<td colspan="5"><div style="width:100%;text-align:left;"><textarea name="bz" class="easyui-validatebox" style="height:50px;width:520px" readonly></textarea></div></td>
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
<form name="icost" method="post"
	action="FunctionPage/insertCost.jsp" id="icost" >
<table border="1" width="650px">
	<tr>
		<td width="70px">消费日期</td>
		<td><div id="dat" style="width:100%;color: blue;text-align:left;"><%=str_date2 %></div></td>
		<td width="70px">消费金额</td>
		<td><input type="text" name="costpay1" class="easyui-numberbox" precision="2" required="true" /></td>
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
		<td><input type="text" name="costcycle1" class="easyui-validatebox" /></td>
		<td>消费学员</td>
		<td><input type="text" name="coststu1" class="easyui-validatebox" readonly /></td>
	</tr>
	<tr>
		<td>备注</td>
		<td colspan="5"><div style="width:100%;text-align:left;"><textarea name="bz1" class="easyui-validatebox" style="height:50px;width:520px" ></textarea></div></td>
	</tr>
</table>
	
</form>
</div>

<div region="south" border="false"
	style="text-align: right; height: 30px; line-height: 30px;">
	<a
	class="easyui-linkbutton" id="addcost" icon="icon-ok" href="javascript:void(0)"
	>添加消费</a> <a class="easyui-linkbutton"
	icon="icon-cancel" href="javascript:void(0)"
	onclick="$('#wadd').window('close');">取消</a></div>
</div>
</div>
</body>
</html>