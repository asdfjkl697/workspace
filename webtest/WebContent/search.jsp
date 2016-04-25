<%@ page contentType="text/html; charset=gb2312"%>
<%@ page language="java"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.Socket"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="console.pdf.CreatePDF"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>TW_WEB</title>
<style type="text/css">
table tr td { border-right:1px solid #000; border-bottom:1px solid #000;}
#Container {
	/* width: 1200px; */
	margin: 1 auto; /*设置整个容器在浏览器中水平居中*/
	/* background: #CF3; */
}

#Header {
	height: 40px;
	/* background: #093; */
}

#logo {
/* 	padding-left: 50px;
	padding-top: 20px;
	padding-bottom: 50px; */
    padding-left: 1px;
	padding-top: 1px;
	padding-bottom: 1px;
}

#Content-View {
	height: 500px;
	width: 1000px;
	margin: 10px; /*设置元素跟其他元素的距离为20像素*/
	float: left; /*设置浮动，实现多列效果，div+Css布局中很重要的*/
	/* background: #cc0; */
}

</style>
<script type="text/javascript" src="js/search.js" charset= "UTF-8"></script>
<script type="text/javascript" src="js/hsdate.js" charset= "UTF-8"></script>
<script type="text/javascript" src="js/test.js" charset= "UTF-8"></script>
</head>

<body>
	<%
		String name = (String) session.getAttribute("userid");
		if (session.getAttribute("userid") == null) {
			response.sendRedirect("index.jsp");
			return;
		}
		//java.util.Date d = new java.util.Date();
		String datetime=new SimpleDateFormat("yyyy-MM-dd").format( new java.util.Date());
		//String name = request.getParameter("userName"); // 接收表单参数
		boolean value7 = false;
	%>

	<div id="Container">
		<div id="Header">
			<div id="logo" style="font-size: 20px">
				<input type="button" value="运行界面" style="margin:1px;width: 120px; height: 30px; background: #ADD8E6" 
					onclick="href_new('user.jsp')">  
				<input type="button" value="数据查询" style="margin:1px;width: 120px; height: 30px; background: #EDD8E6" 
					onclick="href_new('search.jsp')"> 
				<input type="button" value="数据分析" style="margin:1px; width: 120px; height: 30px; background: #ADD8E6"
					onclick="href_new('line.jsp')"> 
				<input type="button" value="视频" style="margin:1px; width: 120px; height: 30px; background: #ADD8E6"
					onclick="href_new('video.jsp')"> 
				<input type="button" value="管理员" style="margin:1px; width: 120px; height: 30px; background: #ADD8E6"
					onclick="href_new('authority.jsp')"> 
				用户名：<%=name%> 时间：<%=datetime%>
			</div>
		</div>

		<div id="Content-View">
            开始:<input type="text" id='sdate' value=<%=datetime%> style="width:90px" onfocus="HS_setDate(this)">           
            结束:<input type="text" id='edate' value=<%=datetime%> style="width:90px" onfocus="HS_setDate(this)">
			批号:<input type="text" id="number" style="width:50px;text-align:right"/>
			设备:<input type=text id="devid" style="width:50px;text-align:right"/> 
				<input type="submit" value="查询" style="width:60px"
				onclick="sendRequest('sdate','edate','number','devid','pageid')"/>
										
			<input class="call" type="submit" value="上页" style="width: 60px"
				onclick="reduce();sendRequest('sdate','edate','number','devid','pageid')"/> 
			<input type=text id="pageid" value="1" style="width:32px;text-align:right"/>/
			<input type=text id="pageall" value="999" style="width:32px;text-align:right"/>
			<input class="call" type="submit" value="下页" style="width: 60px" 
				onclick="add();sendRequest('sdate','edate','number','devid','pageid')"/> 
			<input type="submit" value="pdf" style="width: 60px" 
				onclick="sendpara('sdate','edate','number','devid')"/> 
			<table>
				<tr>
					<td width="100">日期</td>
					<td width="100">时间</td>
					<td width="80">设备号</td>
					<td width="80">批号</td>
					<td width="80">温度℃</td>
					<td width="80">湿度%RH</td>
					<td width="80">压差Pa</td>
					<td width="80">浓度ppm</td>
					<td width="80">风速m/s</td>
					<td width="80">时间min</td>
					<td width="80">状态</td>
					<td width="80">命令</td>
				</tr>

				<%
					String dateid,timeid,devid,numid,tempid,humidityid,pressid,densityid;
					String windid,consumid,stateid,cmd;
					for (int i = 1; i<21; i++) {
						dateid = "dateid" + i;
						timeid = "timeid" + i;
						devid = "devid" + i;
						numid = "numid" + i;
						tempid = "tempid" + i;
						humidityid = "humidityid" + i;
						pressid = "pressid" + i;
						densityid = "densityid" + i;
						windid = "windid" + i;
						consumid = "consumid" + i;
						stateid = "stateid" + i;
						cmd = "cmd" + i;
				%>
				<tr>
					<td width="100" id="<%=dateid%>"></td>
					<td width="100" id="<%=timeid%>"></td>
					<td width="80" id="<%=devid%>"></td>
					<td width="80" id="<%=numid%>"></td>
					<td width="80" id="<%=tempid%>"></td>
					<td width="80" id="<%=humidityid%>"></td>
					<td width="80" id="<%=pressid%>"></td>
					<td width="80" id="<%=densityid%>"></td>
					<td width="80" id="<%=windid%>"></td>
					<td width="80" id="<%=consumid%>"></td>
					<td width="80" id="<%=stateid%>"></td>
					<td width="80" id="<%=cmd%>"></td>
				</tr>
				<%}%>
			</table>
		</div>
	</div>
</body>











