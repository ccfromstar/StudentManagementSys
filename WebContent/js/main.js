function mouseover(i){
	document.getElementById("Module"+i).style.background = "url(theme/img/clickbg.jpg) no-repeat 50% 50%";
}
function mouseout(i){
	if($("input[name='selItem']").val() !=i){
		document.getElementById("Module"+i).style.background = "";
	}
}
//�������Ĺ���ģ��ʱ��Ӧ����ĵ�������ת����Ӧ�Ĺ���ģ��
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
//���ݵ�����������ͼ������ʾ������
function changeCenter(page){
	document.getElementById("iview").src = page;
}
//ģ�����
function loading(){
	$('#bgup').hide();
	$('#layoutmain').css('visibility','visible');
	$('#form1 table').css('font-size','12px').css('border','1px solid #ccc').css('border-collapse','collapse');
}
//�ж��û��Ƿ�ʱ
function checkuserTime(s){
	if(s!= "true"){
		parent.location = "login.jsp?errmsg=error2";
	}
}
//�ж��û�����
function checkuserAction(info,sqlname,sqlrecord){
	if(info!=null){
		if(info == "1"){
			$.messager.alert('��ʾ','���'+sqlname+'�ɹ�!','info');
		}else if(info == "2"){
			$.messager.alert('��ʾ','���'+sqlname+'ʧ��!','error');
		}else if(info == "3"){
			$.messager.alert('��ʾ','ɾ��'+sqlname+'����!','error');
		}else if(info == "4"){
			$.messager.alert('��ʾ','ɾ��'+sqlname+'�ɹ�!','info');
		}else if(info == "5"){
			$.messager.alert('��ʾ','����'+sqlname+'�ɹ�!','info');
		}else if(info == "6"){
			$.messager.alert('��ʾ','����'+sqlname+'ʧ��!','error');
		}else if(info == "99"){
			$.messager.alert('��ʾ',sqlrecord+'�Ѿ�����!','error');
		}else if(info == "99"){
			$.messager.alert('��ʾ','�����ҵ�ѧԱ��Ϣ������!','error');
		}else if(info == "100"){
			$.messager.alert('��ʾ','�������㣬���ֵ!','error');
		}
	}
}
//���ؽ�ѧ����Ϣ
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

//���ؿγ���Ϣ
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

//����ѧԱ����Ϣ
function loadcardInfo(){
	$('#crd').combobox({
		url:'DataPage/getComboCard.jsp',
		valueField:'id',
		textField:'text'
	});
}

//����ѧԱ�б�
function loadStu(){
	$('#lstu').combobox({
		url:'DataPage/getComboStu.jsp',
		valueField:'id',
		textField:'text'
	});
}

//�����û��б�
//����ѧԱ�б�
function loadUserName(){
	$('#mailsendto').combobox({
		url:'DataPage/getComboUserName.jsp',
		valueField:'id',
		textField:'text'
	});
}

//��ȡ����
function ReadCardNo()
{
//$("input[name='cardnumber']").val("");
///////////////////////////////////////////////////////////////////////////////
//����Ϊ�ǽӴ�ʽ��д�������������� for javascript
//ע�������������dc_disp_str��ֻ�е��豸����Ҫ��������������ʾ��ʱ����Ч
//����ϸ�İ����ɲ���32λ��̬���Ӧ�ĺ���ʹ��˵��
///////////////////////////////////////////////////////////////////////////////

var st; //��Ҫ���ڷ���ֵ
var lSnr; //������ȡ���кţ�����javascriptֻ�ǵ���dc_card������һ����ʱ����

//��ʼ���˿�
//��һ������Ϊ0��ʾCOM1��Ϊ1��ʾCOM2���Դ�����
//�ڶ�������ΪͨѶ������
st = rd.dc_init(100, 115200);
if(st <= 0) //����ֵС�ڵ���0��ʾʧ��
{
    //alert("dc_init error!");
    //$("input[name='cardnumber']").val("");
	return;
}
//alert("dc_init ok!");

//Ѱ�����ܷ����ڹ���������ĳ�ſ������к�
//��һ������һ������Ϊ0����ʾIDLEģʽ��һ��ֻ��һ�ſ�����
//�ڶ���������javascriptֻ�ǵ���dc_card������һ����ʱ����������vbscript�е��ú�����ȷ�������к�
st = rd.dc_card(0, lSnr);
if(st != 0) //����ֵС��0��ʾʧ��
{	
	//$("input[name='cardnumber']").val("");
    //alert("dc_card error!");
    rd.dc_exit();
	return;
}
//alert("dc_card ok!");
//alert(rd.get_bstrRBuffer); //���к�Ϊrd.get_bstrRBuffer��һ���в�����ʾ�ַ�����
//alert(rd.get_bstrRBuffer_asc); //���к�ʮ������ascll���ַ�����ʾΪrd.get_bstrRBuffer_asc

//������װ���дģ��RAM��
//��һ������Ϊװ������ģʽ
//�ڶ�������Ϊ������
rd.put_bstrSBuffer_asc = "FFFFFFFFFFFF"; //�ڵ���dc_load_key����ǰ����������rd.put_bstrSBuffer��rd.put_bstrSBuffer_asc
st = rd.dc_load_key(0, 0);
if(st != 0) //����ֵС��0��ʾʧ��
{
    alert("dc_load_key error!");
    rd.dc_exit();
    return;
}
//alert("dc_load_key ok!");

//�˶����뺯��
//��һ������Ϊ������֤ģʽ
//�ڶ�������Ϊ������
st = rd.dc_authentication(0, 0);
if(st < 0) //����ֵС��0��ʾʧ��
{
    alert("dc_authentication error!");
    rd.dc_exit();
    return;
}
//alert("dc_authentication ok!");

//����д�����ݣ�һ�α���дһ����
//��һ������Ϊ���ַ
//�ڵ���dc_write����ǰ����������rd.put_bstrSBuffer��rd.put_bstrSBuffer_asc
rd.put_bstrSBuffer_asc = "31323334353637383930313233343536";
//st = rd.dc_write(2);
//if(st < 0) //����ֵС��0��ʾʧ��
//{
//   alert("dc_write error!");
//    rd.dc_exit();
//    return;
//}
//alert("dc_write ok!");

//��ȡ�������ݣ�һ�α����һ����
//��һ������Ϊ���ַ
//ȡ�������ݷ������Է���rd.put_bstrSBuffer��������ʾ����rd.put_bstrSBuffer_asc��ʮ������ascll���ַ�����ʾ����
st = rd.dc_read(2);
if(st < 0) //����ֵС��0��ʾʧ��
{
    alert("dc_read error!");
    rd.dc_exit();
    return;
}
//alert("dc_read ok!");
//alert(rd.get_bstrRBuffer);
//alert(rd.get_bstrRBuffer_asc);
$("input[name='cardnumber']").val(rd.get_bstrRBuffer);

//����
//��һ������Ϊ����ʱ�䣬��λ��10����
//st = rd.dc_beep(50);
//if(st < 0) //����ֵС��0��ʾʧ��
//{
//    alert("dc_beep error!");
//    rd.dc_exit();
//    return;
//}
//alert("dc_beep ok!");

//�رն˿�
st = rd.dc_exit();
if(st < 0) //����ֵС��0��ʾʧ��
{
    //alert("dc_exit error!");
    return;
}
//alert("dc_exit ok!");

}
