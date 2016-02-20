<%@ page language="java" contentType="text/html; charset=GB2312"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<title>�ۺ�ͳ��</title>
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
			//�ж��û�����
			var info = <%=request.getQueryString()%>;
});
</script>
</head>
<body onload="loading()">
<jsp:include page="Incoming/loading.jsp"></jsp:include>
<%
//��ͼ
//�������ݼ�
DefaultPieDataset dataset = new DefaultPieDataset();
dataset.setValue("��ѧ��1", 0.55);
dataset.setValue("��ѧ��2", 0.1);
dataset.setValue("��ѧ��3", 0.1);
dataset.setValue("��ѧ��4", 0.1);
dataset.setValue("��ѧ��5", 0.2);
//ͨ������������JFreeChart����
JFreeChart chart = ChartFactory.createPieChart3D("����ѧ��ѧԱ����ͼ", dataset, true, false, false);PiePlot pieplot = (PiePlot) chart.getPlot();pieplot.setLabelFont(new Font("����", 0, 12));
//û�����ݵ�ʱ����ʾ������
pieplot.setNoDataMessage("��������ʾ");
pieplot.setCircular(false);
pieplot.setLabelGap(0.02D);
String filename = ServletUtilities.saveChartAsPNG(chart, 500, 300, null, session);
String graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;
//��״ͼ
//�������ݼ�
DefaultCategoryDataset dataset1 = new DefaultCategoryDataset();
dataset1.addValue(10, "����", "7��");
dataset1.addValue(20, "ȱϯ", "7��");
dataset1.addValue(20, "����", "8��");
dataset1.addValue(28, "ȱϯ", "8��");

//ͨ������������JFreeChart����
JFreeChart chart1 = ChartFactory.createBarChart3D("�����������","�¶�","������",dataset1,PlotOrientation.VERTICAL,true,true,true);
String filename1 = ServletUtilities.saveChartAsPNG(chart1, 500, 300, null, session);
String graphURL1 = request.getContextPath() + "/DisplayChart?filename=" + filename1;
%>
<div style="overflow: auto;height:100%">
<img src="<%= graphURL %>"  border=0 usemap="#<%= filename %>">
<img src="<%= graphURL1 %>" border=0 usemap="#<%= filename %>">
</div>
</body>
</html>