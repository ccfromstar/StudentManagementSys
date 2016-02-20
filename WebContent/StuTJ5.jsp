<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>综合统计</title>
<%@ page import="org.jfree.chart.*,
org.jfree.chart.plot.PiePlot,
org.jfree.chart.ChartFactory,
org.jfree.data.general.DefaultPieDataset,
org.jfree.data.category.DefaultCategoryDataset,
org.jfree.chart.plot.PlotOrientation,
org.jfree.chart.servlet.ServletUtilities,java.awt.*"
%>
<jsp:include page="Incoming/common.jsp"></jsp:include>
<script>
$(function(){
			var s="<%=session.getAttribute("Enter")%>"; 
			checkuserTime(s);
			//判断用户操作
			var info = <%=request.getQueryString()%>;
});
</script>
</head>
<body onload="loading()">
<jsp:include page="Incoming/loading.jsp"></jsp:include>
<%
//饼图
//设置数据集
DefaultPieDataset dataset = new DefaultPieDataset();
dataset.setValue("教学点1", 0.55);
dataset.setValue("教学点2", 0.1);
dataset.setValue("教学点3", 0.1);
dataset.setValue("教学点4", 0.1);
dataset.setValue("教学点5", 0.2);
//通过工厂类生成JFreeChart对象
JFreeChart chart = ChartFactory.createPieChart3D("各教学点学员消费图", dataset, true, false, false);PiePlot pieplot = (PiePlot) chart.getPlot();pieplot.setLabelFont(new Font("宋体", 0, 12));
//没有数据的时候显示的内容
pieplot.setNoDataMessage("无数据显示");
pieplot.setCircular(false);
pieplot.setLabelGap(0.02D);
String filename = ServletUtilities.saveChartAsPNG(chart, 500, 300, null, session);
String graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;
//柱状图
//设置数据集
DefaultCategoryDataset dataset1 = new DefaultCategoryDataset();
dataset1.addValue(10, "出勤", "7月");
dataset1.addValue(20, "缺席", "7月");
dataset1.addValue(20, "出勤", "8月");
dataset1.addValue(28, "缺席", "8月");

//通过工厂类生成JFreeChart对象
JFreeChart chart1 = ChartFactory.createBarChart3D("考勤情况汇总","月度","到勤率",dataset1,PlotOrientation.VERTICAL,true,true,true);
String filename1 = ServletUtilities.saveChartAsPNG(chart1, 500, 300, null, session);
String graphURL1 = request.getContextPath() + "/DisplayChart?filename=" + filename1;
%>
<div style="overflow: auto;height:100%">
<img src="<%= graphURL %>"  border=0 usemap="#<%= filename %>">
<img src="<%= graphURL1 %>" border=0 usemap="#<%= filename %>">
</div>
</body>
</html>