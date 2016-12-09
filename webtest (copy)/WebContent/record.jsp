<%-- <%@ page contentType="text/html; charset=gb2312"%> --%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.Socket"%>
<%@ page import="java.text.SimpleDateFormat"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>TW_WEB</title>
<style type="text/css">

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

#Content {
	height: 540px;
	/*此处对容器设置了高度，一般不建议对容器设置高度，一般使用overflow:auto;属性设置容器根据内容自适应高度，如果不指定高度或不设置自适应高度，容器将默认为1个字符高度，容器下方的布局元素（footer）设置margin-top:属性将无效*/
	margin-top: 20px; /*此处讲解margin的用法，设置content与上面header元素之间的距离*/
	/* background: #0FF; */
}

#Content-Left {
	height: 500px;
	width: 120px;
	margin: 20px; /*设置元素跟其他元素的距离为20像素*/
	float: left; /*设置浮动，实现多列效果，div+Css布局中很重要的*/
	/* background: #cc0; */
}

#Content-Main {
	height: 500px;
	width: 160px;
	margin: 20px; /*设置元素跟其他元素的距离为20像素*/
	float: left; /*设置浮动，实现多列效果，div+Css布局中很重要的*/
	/* background: #cc0; */
}

#Content-View {
	height: 500px;
	width: 500px;
	margin: 20px; /*设置元素跟其他元素的距离为20像素*/
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

.menul li.levela a.current {
	background: #B1D7EF;
}


.menul li ul {
	overflow: hidden;
}

</style>

<script src="js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="js/search.js" charset="UTF-8"></script>
<script type="text/javascript" src="js/test.js"></script>
<script type="text/javascript" src="js/control.js"></script>

</head>

<body background="image/DNA.jpg">
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
			<ul class="menul">
					<li class="levela" ><a onclick="href_new('user.jsp')" id="dis1">运行界面</a></li>
					<li class="levela" ><a onclick="href_new('search.jsp')" id='dis2'>数据查询</a></li>
					<li class="levela" ><a onclick="href_new('line.jsp')" id='dis3'>数据分析</a></li>
					<li class="levela" ><a onclick="href_new('video.jsp')" id='dis4'>视频</a></li>
					<li class="levela" ><a onclick="href_new('authority.jsp')" id='dis5'>用户管理</a></li>
					<li class="levela" ><a onclick="href_new('upgrade.jsp')" id='dis6'>远程升级</a></li>
					<li class="levela" ><a onclick="href_new('record.jsp')" id='dis7'  style="background: #EDD8E6">摘录</a></li>
					<li>用户名：<%=name%> 日期：<%=datetime%></li>
			</ul>
			版本号:plat2016.01
		</div>
		<div id="Content">
			<div id="Content-Left">
				linux<br />java<br />mysql<br />websocket<br />nio<br />
				ajax<br />js<br />jq<br />html<br />

			</div>
			<div id="Content-Main">
				openwrt<br />libevent<br /> ar9331<br />mt7620<br /> 
				stm32<br />lpc<br />msp430<br />
				cc1101<br />a7129<br /> 
				s7-200<br />
			</div>
			<div id="Content-View">
				WIFI<br />LAN<br />FSK<br />ASK<br />485<br />
				BOOTLOAD<br />PID<br />BLDC<br />FFT<br />	
			</div>
			<div id="Content-Set"></div>
		</div>
		<!-- <div class="Clear">如何你上面用到float,下面布局开始前最好清除一下。</div> -->
		<div id="Footer">Footer</div>

	</div>

</body>











