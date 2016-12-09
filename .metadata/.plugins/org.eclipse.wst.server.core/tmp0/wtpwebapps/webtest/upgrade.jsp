<%-- <%@ page contentType="text/html; charset=gb2312"%> --%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.Socket"%>
<%@ page import="java.text.SimpleDateFormat"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>远程升级</title>
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
<script type="text/javascript" src="js/search.js" charset= "UTF-8"></script>
<script type="text/javascript" src="js/functions.js"></script>
<script>
	$(document).ready(function() {
				$(".level1 > a").click(function() {
							$.ajax({
								type : 'get',
								cache : false,
								url : 'ajax/author_ajax.jsp',
								data : {list:'b'},
								dataType : 'text',
								success : function(data) {
									var st_n = 17;
									//var list = data.substring(st_n + 1,st_n + 2);
									var msgnum = Number(data.substring(st_n + 3,st_n + 6));

									for (var i = 1; i < 30; i++) {
										var msglen = st_n + 10 * (i - 1);
										if (i > msgnum)
											$("#devlist"+i).parent().css("display","none");
											//$("#devlist"+i).val("");								
										else
											$("#devlist"+i).val(data.substring(msglen+6,msglen+15));
									}									
								}
							});

							$(this).addClass("current") //给当前元素添加"current"样式
							.next().show() //下一个元素显示
							.parent().siblings().children("a").removeClass(
									"current") //父元素的兄弟元素的子元素<a>移除"current"样式
							.next().hide(); //它们的下一个元素隐藏
							return false;
						});

				$(".level2 > li a").click(function() {
							//var selectname = $(this).children("input").val();
							//$("#devid_status").val("offline");
							//for(var i=1;i<8;i++)$("#dataid"+i).val("");
							//for(var i=1;i<7;i++)$("#button"+i).css("background","#ADD8E6");
							//$("#devid_select").val(selectname.substring(0, 8));
							//Sendev('AAZ'); //send to dev request message add by jyc 20160511			
							$(this).addClass("current") //给当前元素添加"current"样式
							.parent().siblings().children("a").removeClass(
									"current").next().hide(); //它们的下一个元素隐藏 */
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
		String datetime = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		//String name = request.getParameter("userName"); // 接收表单参数
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
					<li class="levela" ><a onclick="href_new('search.jsp')" >数据查询</a></li>									
					<li class="levela" ><a onclick="href_new('upgrade.jsp')" style="background: #EDD8E6">远程升级</a></li>
					<li class="levela" ><a onclick="href_new('record.jsp')" >介绍</a></li>		
					<li class="levela" ><a onclick="href_new('authority.jsp')" >管理登录</a></li>
			</ul>
		</div>
		<div id="Content-Left">
				<ul class="menu">
					<li class="level1" ><a id='b'>设备列表</a>
						<ul class="level2">	
							<%
								String devlist="";
								for (int i = 1; i < 30; i++) {
									devlist="devlist"+i;
							%>		
							<li><a><input id="<%=devlist%>" onfocus="this.blur();"
								style="border:0px;background-color:transparent;margin:5px;">
								</a></li>
							<%}%>		
						</ul>
					</li>
				</ul>

			<input class="call" type="submit" value="更新" onclick="Sendev('AAU')"
					style="width: 100px; height: 30px; margin:5px" />	

		</div>

		<div id="Content-Veiw">
			
			<form action="ajax/accept.jsp" method=post enctype="multipart/form-data">
				<br/>
				<input type="file" name="fileforload" size=30 value="test.ipk">
				<input type="submit" value=上传文件 name="submit">
			</form>		
		</div>

	</div>

</body>











