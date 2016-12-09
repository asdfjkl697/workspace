<%-- <%@ page contentType="text/html; charset=gb2312"%> --%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.Socket"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="console.pdf.CreatePDF"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>数据查询</title>
<style type="text/css">
table tr td { border-right:1px solid #000; border-bottom:1px solid #000;}
#Container {
	/* width: 1200px; */
	margin: 1 auto; /*设置整个容器在浏览器中水平居中*/
	/* background: #CF3; */
}

#Header {
	width:100%; 
	height: 30px;
	line-height:30px; 
	/* background-color:#99ffff; */
	FILTER: progid:DXImageTransform.Microsoft.Gradient(gradientType=2,startColorStr=#99ffaa,endColorStr=#99aaff); /*IE*/
	background:-moz-linear-gradient(left,#99ffaa,#99aaff);/*火狐*/
	background:-webkit-gradient(linear, 0% 0%, 100% 0%,from(#99ffaa), to(#99aaff));/*谷歌*/ 
}
#Name {	
	padding-left: 30px;	
	width: 200px;
	float: left; 
}

#Timer {
	padding-right: 30px;
	width: 300px;
	float: right;
}

#logo {
    padding-left: 2px;
	padding-top: 5px;
	padding-bottom: 5px;
}

#Content-View {
	height: 500px;
	width: 1000px;
	margin: 10px; /*设置元素跟其他元素的距离为20像素*/
	float: left; /*设置浮动，实现多列效果，div+Css布局中很重要的*/
	/* background: #cc0; */
}
form, ul, li, p, h1, h2, h3, h4, h5, h6 {
	margin: 0;
	padding: 0;
}

img {
	border: 0;
}

ul li{
	list-style-type: none;
}

a {
	color: #00007F;
	text-decoration: none;
}

a:hover {
	color: #bd0a01;
	text-decoration: underline;
}

.box {
	width: 150px;
	margin: 0 auto;
}

.menul {
	overflow: hidden;
	border-color: #C4D5DF;
	border-style: solid;
	border-width: 0 1px 1px;
}

.menul li.levela {
	float:left;
	margin: 0px 2px 0px 2px;
	width: 100px;
}

.menul li.levela a {
	display: block;
	height: 28px;
	line-height: 28px;
	background: #EBF3F8;
	font-weight: 700;
	color: #5893B7;
	/* text-indent: 14px; */
	text-align:center;
	/* border-top: 1px solid #C4D5DF; */
	border: 1px solid #C4D5DF;
}

.menul li.levela a:hover {
	text-decoration: none;
}

.menul li.level1a a.current {
	background: #B1D7EF;
}

.menul li ul {
	overflow: hidden;
}
</style>
<script type="text/javascript" src="js/search.js" charset= "UTF-8"></script>
<script type="text/javascript" src="js/hsdate.js" charset= "UTF-8"></script>
<script type="text/javascript" src="js/functions.js" charset= "UTF-8"></script>
</head>

<body onload="sendRequest('sdate','edate','number','devid','pageid')">
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
		<div id="Header" >
			<div id="Name" style="color: #5893B7"><h3>联舟技术</h3></div>
			<div id="Timer">
				用户名：<%=name%>
				日期：<%=datetime%></div>
		</div>
		<div id="logo">
			<ul class="menul">
					<li class="levela" ><a onclick="href_new('user.jsp')" >隔离器</a></li>					
					<li class="levela" ><a onclick="href_new('video.jsp')" >视频直播</a></li>
					<li class="levela" ><a onclick="href_new('jiont.jsp')"  >中产交互器</a></li>
					<li class="levela" ><a onclick="href_new('jiontreq.jsp')" >中产终端</a></li>
					<li class="levela" ><a onclick="href_new('line.jsp')" >数据分析</a></li>
					<li class="levela" ><a onclick="href_new('search.jsp')" style="background: #EDD8E6">数据查询</a></li>									
					<li class="levela" ><a onclick="href_new('upgrade.jsp')" >远程升级</a></li>
					<li class="levela" ><a onclick="href_new('record.jsp')" >介绍</a></li>		
					<li class="levela" ><a onclick="href_new('authority.jsp')" >管理登录</a></li>
			</ul>
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
			<input type=text id="pageid" value="1" style="width:40px;text-align:right"/>/
			<input type=text id="pageall" value="999" style="width:40px;text-align:right"/>
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












