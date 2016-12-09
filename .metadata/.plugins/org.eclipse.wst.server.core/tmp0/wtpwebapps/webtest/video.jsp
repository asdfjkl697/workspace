<%-- <%@ page contentType="text/html; charset=gb2312"%> --%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.Socket"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>视频直播</title>
<style type="text/css">

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

.menul li.level1a a.current {
	background: #B1D7EF;
}

.menul li ul {
	overflow: hidden;
}

</style>
<link rel="icon" type="image/x-icon" href="//statics.ys7.com/mall/statics/site/favicon.ico" />
<script src="./ckplayer/ckplayer.js"></script>

<script src="js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="js/search.js" charset="UTF-8"></script>
<script type="text/javascript" src="js/functions.js"></script>

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

	<%!// \b 是单词边界(连着的两个(字母字符 与 非字母字符) 之间的逻辑上的间隔),字符串在编译时会被转码一次,所以是 "\\b"
	// \B 是单词内部逻辑间隔(连着的两个字母字符之间的逻辑上的间隔)

	String androidReg = "\\bandroid|Nexus\\b";
	String iosReg = "ip(hone|od|ad)";

	Pattern androidPat = Pattern.compile(androidReg, Pattern.CASE_INSENSITIVE);
	Pattern iosPat = Pattern.compile(iosReg, Pattern.CASE_INSENSITIVE);

	public boolean likeAndroid(String userAgent) {
		if (null == userAgent) {
			userAgent = "";
		}
		// 匹配
		Matcher matcherAndroid = androidPat.matcher(userAgent);
		if (matcherAndroid.find()) {
			return true;
		} else {
			return false;
		}
	}

	public boolean likeIOS(String userAgent) {
		if (null == userAgent) {
			userAgent = "";
		}
		// 匹配
		Matcher matcherIOS = iosPat.matcher(userAgent);
		if (matcherIOS.find()) {
			return true;
		} else {
			return false;
		}
	}%>

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
					<li class="levela" ><a onclick="href_new('video.jsp')" style="background: #EDD8E6">视频直播</a></li>
					<li class="levela" ><a onclick="href_new('jiont.jsp')"  >中产交互器</a></li>
					<li class="levela" ><a onclick="href_new('jiontreq.jsp')" >中产终端</a></li>
					<li class="levela" ><a onclick="href_new('line.jsp')" >数据分析</a></li>
					<li class="levela" ><a onclick="href_new('search.jsp')" >数据查询</a></li>									
					<li class="levela" ><a onclick="href_new('upgrade.jsp')" >远程升级</a></li>
					<li class="levela" ><a onclick="href_new('record.jsp')" >介绍</a></li>		
					<li class="levela" ><a onclick="href_new('authority.jsp')" >管理登录</a></li>
			</ul>
		</div>
		<% 
		String userAgent = request.getHeader( "USER-AGENT" ).toLowerCase();
		//System.out.println("userAgent: "+userAgent);
		if(likeAndroid(userAgent)||likeIOS(userAgent)){ 
		%>
		<video src="http://vshare.ys7.com:80/openlive/588822555_1_1.m3u8?ticket=RUk2Z291UGUvdEdLK1hHeld1SW10MDZyL2NHa0c3QkRpVktJQ3Y1andaST0kMSQyMDE3MDcwNzAwMDUyMCQxNDY3NzY0NzQ4MDAwJDE0OTkzNTY4MDAwMDAkMSQkJA=="
           poster="image/wenzhou.jpg"
           controls="controls" width="100%" height="100%">
    	</video>
    	<% 
		}else{
		%>
		<div id="videoPlay" style="width: 700px; height: 393px;"></div>
		<script>
			var flashvars;
			flashvars = {
				f : 'ckplayer/m3u8.swf',
				a : 'http://vshare.ys7.com:80/openlive/588822555_1_1.m3u8?ticket=RUk2Z291UGUvdEdLK1hHeld1SW10MDZyL2NHa0c3QkRpVktJQ3Y1andaST0kMSQyMDE3MDcwNzAwMDUyMCQxNDY3NzY0NzQ4MDAwJDE0OTkzNTY4MDAwMDAkMSQkJA==', //此处填写购买获取到的视频播放地址
				c : 0,
				p : 1,
				s : 4,
				lv : 1
			};
			var params = {
				bgcolor : '#FFF',
				allowFullScreen : true,
				allowScriptAccess : 'always',
				wmode : 'transparent'
			};
			CKobject.embedSWF("./ckplayer/ckplayer.swf", "videoPlay", "video",
					"100%", "100%", flashvars, params);
		</script>
		<%}%>


		<div id="Content">			
			<div id="Content-Left"></div>
			<div id="Content-Main">
			
			</div>
			<div id="Content-View"></div>
			<div id="Content-Set"></div>
		</div>
		<!-- <div class="Clear">如何你上面用到float,下面布局开始前最好清除一下。</div> -->
		<div id="Footer" style="font-size:12px;color:#5893B7">
		©2016 lianzhouiot 22960468@qq.com</div>

	</div>

</body>











