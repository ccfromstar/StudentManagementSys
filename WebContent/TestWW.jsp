<%@ page contentType="text/html;charset=gb2312" %>

<html>
<h1>我的第一个JSP</h1><hr>
<head>
<script language="javascript">

      <!--

           function checkNum(){
       if(form.num1.value==""){
        window.alert("num1不能为空");
     return false;
    }
    
    if(form.num2.value==""){
        window.alert("num2不能为空");
     return false;
    }
    
    if(Math.round(form.num1.value)!=form.num1.value){
      
      window.alert("num1无效");
      return false;
    
    }
    
    if(Math.round(form.num2.value)!=form.num2.value){
      
      window.alert("num2无效");
      return false;
    
    }
    
    if(form.num2.value==0&&form.flag.value=="/"){
    
      window.alert("can不能为0");
      return false;
    
    }
     
     }

      
     -->


</script>
</head>
<body>



<%
     String s_num1=request.getParameter("num1");
  String s_num2=request.getParameter("num2");
  String flag=request.getParameter("flag");
  int num1=0;
  int num2=0;
  int result=0;
  num1=Integer.parseInt(s_num1);
  num2=Integer.parseInt(s_num2);
  if(flag.equals("+")){
  result=num1+num2;
   }
   else if(flag.equals("-")){
   result=num1-num2;
   }
   else if(flag.equals("*")){
   result=num1*num2;
   }
   else{
   result=num1/num2;
   }
  
  
  %>






<form name="form" method="post" action="Result.jsp">
请输入第一个数：<input type="text" name="num1"><br>
<select name="flag">
<option value=+>+</option>
<option value=->-</option>
<option value=*>*</option>
<option value=/>/</option>
</select><br>
请输入第二个数：<input type="text" name="num2"><br>
<input type="submit" value="计算" onClick="return checkNum();" >
</form><br>
<hr>

结果是：<%= result %>



</body>
</html> 
