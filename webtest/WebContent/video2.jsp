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
</style>

<script src="js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="js/search.js" charset="UTF-8"></script>
<script type="text/javascript" src="js/functions.js"></script>


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
				用户名：<%=name%> 日期：<%=datetime%>
			</div>
		</div>
		<div id="Content">			
			<div id="Content-Left">未连接...</div>
			<div id="Content-Main"></div>
			<div id="Content-View"></div>
			<div id="Content-Set"></div>
		</div>
		<!-- <div class="Clear">如何你上面用到float,下面布局开始前最好清除一下。</div> -->
		<div id="Footer">Footer</div>

	</div>

</body>











