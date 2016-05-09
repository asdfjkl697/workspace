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

/* body {
	margin: 0;
	padding: 0 0 12px 0;
	font-size: 14px;
	line-height: 24px;
	background: #fff;
} */

form, ul, li, p, h1, h2, h3, h4, h5, h6 {
	margin: 0;
	padding: 0;
}

/* input, select {
	font-size: 14px;
	line-height: 18px;
} */

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

.menu {
	overflow: hidden;
	border-color: #C4D5DF;
	border-style: solid;
	border-width: 0 1px 1px;
}

.menu li.level1 a {
	display: block;
	height: 28px;
	line-height: 28px;
	background: #EBF3F8;
	font-weight: 700;
	color: #5893B7;
	text-indent: 14px;
	border-top: 1px solid #C4D5DF;
}

.menu li.level1 a:hover {
	text-decoration: none;
}

.menu li.level1 a.current {
	background: #B1D7EF;
}


.menu li ul {
	overflow: hidden;
}

.menu li ul.level2 {
	display: none;
}

.menu li ul.level2 li a {
	display: block;
	height: 28px;
	line-height: 28px;
	background: #ffffff;
	font-weight: 400;
	color: #42556B;
	text-indent: 18px;
	border-top: 0px solid #ffffff;
	overflow: hidden; 
}

.menu li ul.level2 li a:hover {
	text-decoration: none;
}
.menu li ul.level2 li a.current {
	background: #B1D7EF;
}
</style>
<!-- <script src="http://www.codefans.net/ajaxjs/jquery-1.6.2.min.js"></script> -->
<script src="js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="js/search.js" charset="UTF-8"></script>
<script type="text/javascript" src="js/test.js"></script>
<script>
$(document).ready(function(){	
	$(".level1 > a").click(function(){
		$.ajax({
	    type: 'get', cache: false,  
	    url: 'ajax/author_ajax.jsp',  
	    data: {list:'b'},  
	    dataType: 'text',
		success : function(data) {
						//var message = data;
						//alert(data);
						//var s = data.indexof("response");
						var st_n=17;
						var list = data.substring(st_n+1,st_n+2);
						
						var msgnum1 = data.substring(st_n+3,st_n+6);
						//alert(list);
						var msgnum = Number(msgnum1);
						$("#userName").val(list);
						//$("#testaaa").val(list);
						li[001].innerHTML=list;
						var listid,authid;
						if(list=="a"){
							listid="userlistid";
							authid="userauthid";
						}else if(list=="b"){
							listid="devlistid";
							authid="devauthid";
						}
						
						/* 
						for (var i = 1; i < msgnum; i++) {
							var msglen = st_n + 10 * (i - 1);

							var userlistid = listid + i;
							var userauthid = authid + i;
							$("#userName").val(message.substring(msglen + 6, msglen + 15));
							//var test = data.substring(msglen + 6, msglen + 15);
							//alert(test);

						} */
					}
		});
		$(this).addClass("current")  //给当前元素添加"current"样式
		.next().show()  //下一个元素显示
		.parent().siblings().children("a").removeClass("current")   //父元素的兄弟元素的子元素<a>移除"current"样式
		.next().hide();  //它们的下一个元素隐藏
		return false;
	});
	$(".level2 > li a").click(function(){
		$(this).addClass("current")  //给当前元素添加"current"样式
		//.next().show()  //下一个元素显示
		.parent().siblings().children("li a").removeClass("current")
		.next().hide();  //它们的下一个元素隐藏 */
		return false;
	});	
});
</script>

</head>

<body background="image/DNA.jpg">
	<%
		String name = (String) session.getAttribute("userid");
		if (session.getAttribute("userid") == null) {
			response.sendRedirect("index.jsp");
			return;
		}
		//java.util.Date d = new java.util.Date();
		String datetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format( new java.util.Date());
		//String name = request.getParameter("userName"); // 接收表单参数
		boolean value7 = false;
	%>

	<div id="Container">
		<div id="Header">
			<div id="logo" style="font-size: 20px">
				<input type="button" value="运行界面" style="margin:1px;width: 120px; height: 30px; background: #ADD8E6" 
					onclick="href_new('user.jsp')">  
				<input type="button" value="数据查询" style="margin:1px;width: 120px; height: 30px; background: #ADD8E6" 
					onclick="href_new('search.jsp')"> 
				<input type="button" value="数据分析" style="margin:1px; width: 120px; height: 30px; background: #ADD8E6"
					onclick="href_new('line.jsp')"> 
				<input type="button" value="视频" style="margin:1px; width: 120px; height: 30px; background: #EDD8E6"
					onclick="href_new('video.jsp')"> 
				<input type="button" value="管理员" style="margin:1px; width: 120px; height: 30px; background: #ADD8E6"
					onclick="href_new('authority.jsp')"> 
				用户名：<%=name%> 时间：<%=datetime%>
			</div>
		</div>
		<div id="Content">
			<div id="Content-Left">
				<ul class="menu">
					<li class="level1"><a href="#none">用户列表</a>
						<ul class="level2">
							<%
								for (int i = 1; i < 10; i++) {
							%>
							<li><a href="#none">TW001001</a></li>
							<%
								}
							%>
						</ul></li>
					<li class="level1"><a href="#none">设备列表</a>
						<ul class="level2">							
							<li id="001"><a id='testaab'></a></li>
							<li><div id="testaaa"></div></li>
							<li><a href="#none">TW001803</a></li>
							<li><a href="#none">TW001804</a></li>
						</ul></li>
				</ul>
			</div>
			<div id="Content-Main"></div>
				<input type="text" id='userName' style="width: 40px; height: 30px; margin:5px; text-align: right" />
			<div id="Content-View"></div>
			<div id="Content-Set"></div>
		</div>
		<!-- <div class="Clear">如何你上面用到float,下面布局开始前最好清除一下。</div> -->
		<div id="Footer">Footer</div>

	</div>

</body>











