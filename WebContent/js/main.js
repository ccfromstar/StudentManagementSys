function mouseover(i){
	document.getElementById("Module"+i).style.background = "url(theme/img/clickbg.jpg) no-repeat 50% 50%";
}
function mouseout(i){
	if($("input[name='selItem']").val() !=i){
		document.getElementById("Module"+i).style.background = "";
	}
}
//点击上面的功能模块时对应左面的导航栏跳转到相应的功能模块
function select(title,i){
			var j = $("input[name='selItem']").val();
			if(j!=""){
				document.getElementById("Module"+j).style.background = "";
			}
			$('#Navigation').accordion('select',title);
			document.getElementById("Module"+i).style.background = "url(theme/img/clickbg.jpg) no-repeat 50% 50%";
			$("input[name='selItem']").val(i);
			return false;
}
function selectfalse(title,i){
			var j = $("input[name='selItem']").val();
			if(j!=""){
				document.getElementById("Module"+j).style.background = "";
			}
			//$('#Navigation').accordion('select',title);
			document.getElementById("Module"+i).style.background = "url(theme/img/clickbg.jpg) no-repeat 50% 50%";
			$("input[name='selItem']").val(i);
			return false;
}
function sz_mouseover(i){
	document.getElementById("sz_"+i).style.backgroundColor = "#E0ECFF";
}
function sz_mouseout(i){
		document.getElementById("sz_"+i).style.backgroundColor = "white";
}
//根据导航栏设置视图界面显示的内容
function changeCenter(page){
	document.getElementById("iview").src = page;
}
//模块加载
function loading(){
	$('#bgup').hide();
	$('#layoutmain').css('visibility','visible');
	$('#form1 table').css('font-size','12px').css('border','1px solid #ccc').css('border-collapse','collapse');
}
//判断用户是否超时
function checkuserTime(s){
	if(s!= "true"){
		parent.location = "login.jsp?errmsg=error2";
	}
}
//判断用户操作
function checkuserAction(info,sqlname,sqlrecord){
	if(info!=null){
		if(info == "1"){
			$.messager.alert('提示','添加'+sqlname+'成功!','info');
		}else if(info == "2"){
			$.messager.alert('提示','添加'+sqlname+'失败!','error');
		}else if(info == "3"){
			$.messager.alert('提示','删除'+sqlname+'出错!','error');
		}else if(info == "4"){
			$.messager.alert('提示','删除'+sqlname+'成功!','info');
		}else if(info == "5"){
			$.messager.alert('提示','更新'+sqlname+'成功!','info');
		}else if(info == "6"){
			$.messager.alert('提示','更新'+sqlname+'失败!','error');
		}else if(info == "99"){
			$.messager.alert('提示',sqlrecord+'已经存在!','error');
		}else if(info == "99"){
			$.messager.alert('提示','您查找的学员信息不存在!','error');
		}else if(info == "100"){
			$.messager.alert('提示','卡内余额不足，请充值!','error');
		}
	}
}
//加载教学点信息
function loadsiteInfo(){
	$('#site').combobox({
		url:'DataPage/getComboSite.jsp',
		valueField:'id',
		textField:'text'
	});
	$('#site1').combobox({
		url:'DataPage/getComboSite.jsp',
		valueField:'id',
		textField:'text'
	});
}

//加载课程信息
function loadcourseInfo(){
	$('#cour').combobox({
		url:'DataPage/getComboCourse.jsp',
		valueField:'id',
		textField:'text'
	});
}

function loadcourseInfo1(){
	$('#cour1').combobox({
		url:'DataPage/getComboCourse.jsp',
		valueField:'id',
		textField:'text'
	});
}

//加载学员卡信息
function loadcardInfo(){
	$('#crd').combobox({
		url:'DataPage/getComboCard.jsp',
		valueField:'id',
		textField:'text'
	});
}

//加载学员列表
function loadStu(){
	$('#lstu').combobox({
		url:'DataPage/getComboStu.jsp',
		valueField:'id',
		textField:'text'
	});
}

//加载用户列表
//加载学员列表
function loadUserName(){
	$('#mailsendto').combobox({
		url:'DataPage/getComboUserName.jsp',
		valueField:'id',
		textField:'text'
	});
}

//读取卡号
function ReadCardNo()
{
//$("input[name='cardnumber']").val("");
///////////////////////////////////////////////////////////////////////////////
//以下为非接触式读写器函数调用例子 for javascript
//注意个别函数（例如dc_disp_str）只有当设备满足要求（例如有数码显示）时才有效
//更详细的帮助可参照32位动态库对应的函数使用说明
///////////////////////////////////////////////////////////////////////////////

var st; //主要用于返回值
var lSnr; //本用于取序列号，但在javascript只是当成dc_card函数的一个临时变量

//初始化端口
//第一个参数为0表示COM1，为1表示COM2，以此类推
//第二个参数为通讯波特率
st = rd.dc_init(100, 115200);
if(st <= 0) //返回值小于等于0表示失败
{
    //alert("dc_init error!");
    //$("input[name='cardnumber']").val("");
	return;
}
//alert("dc_init ok!");

//寻卡，能返回在工作区域内某张卡的序列号
//第一个参数一般设置为0，表示IDLE模式，一次只对一张卡操作
//第二个参数在javascript只是当成dc_card函数的一个临时变量，仅在vbscript中调用后能正确返回序列号
st = rd.dc_card(0, lSnr);
if(st != 0) //返回值小于0表示失败
{	
	//$("input[name='cardnumber']").val("");
    //alert("dc_card error!");
    rd.dc_exit();
	return;
}
//alert("dc_card ok!");
//alert(rd.get_bstrRBuffer); //序列号为rd.get_bstrRBuffer，一般有不可显示字符出现
//alert(rd.get_bstrRBuffer_asc); //序列号十六进制ascll码字符串表示为rd.get_bstrRBuffer_asc

//将密码装入读写模块RAM中
//第一个参数为装入密码模式
//第二个参数为扇区号
rd.put_bstrSBuffer_asc = "FFFFFFFFFFFF"; //在调用dc_load_key必须前先设置属性rd.put_bstrSBuffer或rd.put_bstrSBuffer_asc
st = rd.dc_load_key(0, 0);
if(st != 0) //返回值小于0表示失败
{
    alert("dc_load_key error!");
    rd.dc_exit();
    return;
}
//alert("dc_load_key ok!");

//核对密码函数
//第一个参数为密码验证模式
//第二个参数为扇区号
st = rd.dc_authentication(0, 0);
if(st < 0) //返回值小于0表示失败
{
    alert("dc_authentication error!");
    rd.dc_exit();
    return;
}
//alert("dc_authentication ok!");

//向卡中写入数据，一次必须写一个块
//第一个参数为块地址
//在调用dc_write必须前先设置属性rd.put_bstrSBuffer或rd.put_bstrSBuffer_asc
rd.put_bstrSBuffer_asc = "31323334353637383930313233343536";
//st = rd.dc_write(2);
//if(st < 0) //返回值小于0表示失败
//{
//   alert("dc_write error!");
//    rd.dc_exit();
//    return;
//}
//alert("dc_write ok!");

//读取卡中数据，一次必须读一个块
//第一个参数为块地址
//取出的数据放在属性放在rd.put_bstrSBuffer（正常表示）和rd.put_bstrSBuffer_asc（十六进制ascll码字符串表示）中
st = rd.dc_read(2);
if(st < 0) //返回值小于0表示失败
{
    alert("dc_read error!");
    rd.dc_exit();
    return;
}
//alert("dc_read ok!");
//alert(rd.get_bstrRBuffer);
//alert(rd.get_bstrRBuffer_asc);
$("input[name='cardnumber']").val(rd.get_bstrRBuffer);

//蜂鸣
//第一个参数为蜂鸣时间，单位是10毫秒
//st = rd.dc_beep(50);
//if(st < 0) //返回值小于0表示失败
//{
//    alert("dc_beep error!");
//    rd.dc_exit();
//    return;
//}
//alert("dc_beep ok!");

//关闭端口
st = rd.dc_exit();
if(st < 0) //返回值小于0表示失败
{
    //alert("dc_exit error!");
    return;
}
//alert("dc_exit ok!");

}
