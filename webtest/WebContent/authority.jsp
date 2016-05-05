<%@ page contentType="text/html; charset=gb2312"%>
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
	margin: 1 auto; /*���������������������ˮƽ����*/
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
	/*�˴������������˸߶ȣ�һ�㲻������������ø߶ȣ�һ��ʹ��overflow:auto;������������������������Ӧ�߶ȣ������ָ���߶Ȼ���������Ӧ�߶ȣ�������Ĭ��Ϊ1���ַ��߶ȣ������·��Ĳ���Ԫ�أ�footer������margin-top:���Խ���Ч*/
	margin-top: 20px; /*�˴�����margin���÷�������content������headerԪ��֮��ľ���*/
	/* background: #0FF; */
}

#Content-Left {
	height: 500px;
	width: 100px;
	margin: 20px; /*����Ԫ�ظ�����Ԫ�صľ���Ϊ20����*/
	float: left; /*���ø�����ʵ�ֶ���Ч����div+Css�����к���Ҫ��*/
	/* background: #cc0; */
}

#Content-Main {
	height: 500px;
	width: 160px;
	margin: 20px; /*����Ԫ�ظ�����Ԫ�صľ���Ϊ20����*/
	float: left; /*���ø�����ʵ�ֶ���Ч����div+Css�����к���Ҫ��*/
	/* background: #cc0; */
}

#Content-View {
	height: 500px;
	width: 500px;
	margin: 20px; /*����Ԫ�ظ�����Ԫ�صľ���Ϊ20����*/
	float: left; /*���ø�����ʵ�ֶ���Ч����div+Css�����к���Ҫ��*/
	/* background: #cc0; */
}

/* body {
	margin: 0;
	padding: 0 0 12px 0;
	font-size: 14px;
	line-height: 24px;
	background: #fff;
}

form, ul, li, p, h1, h2, h3, h4, h5, h6 {
	margin: 0;
	padding: 0;
}

input, select {
	font-size: 14px;
	line-height: 18px;
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
} */
</style>

<script src="http://www.codefans.net/ajaxjs/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="js/search.js" charset= "UTF-8"></script>
<script type="text/javascript" src="js/test.js"></script>
<script>
$(document).ready(function(){
	$(".level1 > a").click(function(){
		$(this).addClass("current")  //����ǰԪ�����"current"��ʽ
		.next().show()  //��һ��Ԫ����ʾ
		.parent().siblings().children("a").removeClass("current")   //��Ԫ�ص��ֵ�Ԫ�ص���Ԫ��<a>�Ƴ�"current"��ʽ
		.next().hide();  //���ǵ���һ��Ԫ������
		return false;
	});
	$(".level2 > li a").click(function(){
		$(this).addClass("current")  //����ǰԪ�����"current"��ʽ
		.next().show()  //��һ��Ԫ����ʾ
		.parent().siblings().children("a").removeClass("current")
		/* .next().hide();  //���ǵ���һ��Ԫ������ */
		return false;
	});	
});
</script>
</head>

<body background="image/DNA.jpg">
	<%
		String name = (String) session.getAttribute("userid");
		String groupname = name.substring(0,5);
		
		String driverName = "com.mysql.jdbc.Driver";
		String userName = "root";
		String userPasswd = "102030";
		String dbName = "abc";
		String tableName = "users";
		//String tableName = request.getParameter("userName");
		String url = "jdbc:mysql://localhost/" + dbName + "?user=" + userName + "&password=" + userPasswd;
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection connection = DriverManager.getConnection(url);
		Statement statement = connection.createStatement();
		
		//String sql = "SELECT * FROM " + tableName;
		String sql = "SELECT * FROM " + tableName
				+" where userName = '"+name+"' and authority=3"; //
		//System.out.println(sql);
		//String sql = "SELECT * FROM " + tableName + " ORDER BY id DESC LIMIT 21";
		ResultSet rs = statement.executeQuery(sql);
		if(!rs.next()){
			response.sendRedirect("index.jsp");
			return;
		}
		
		//java.util.Date d = new java.util.Date();
		String datetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format( new java.util.Date());
		//String name = request.getParameter("userName"); // ���ձ�����
		boolean value7 = false;
	%>

	<div id="Container">
		<div id="Header">
			<div id="logo" style="font-size: 20px">
				<input type="button" value="���н���" style="margin:1px;width: 120px; height: 30px; background: #ADD8E6" 
					onclick="href_new('user.jsp')">  
				<input type="button" value="���ݲ�ѯ" style="margin:1px;width: 120px; height: 30px; background: #ADD8E6" 
					onclick="href_new('search.jsp')"> 
				<input type="button" value="���ݷ���" style="margin:1px; width: 120px; height: 30px; background: #ADD8E6"
					onclick="href_new('line.jsp')"> 
				<input type="button" value="��Ƶ" style="margin:1px; width: 120px; height: 30px; background: #ADD8E6"
					onclick="href_new('video.jsp')"> 
				<input type="button" value="����Ա" style="margin:1px; width: 120px; height: 30px; background: #EDD8E6"
					onclick="href_new('authority.jsp')"> 
				�û�����<%=name%> ʱ�䣺<%=datetime%>
			</div>
		</div>
		<%-- <div id="Content-Left">
			<ul class="menu">
				<li class="level1"><a href="#none">�û��б�</a>
					<ul class="level2">
						<%for(int i=1;i<10;i++){	
						%>
						<li><a href="#none">TW001001</a></li>
						<%}%>
					</ul>
				</li>
				<li class="level1"><a href="#none">�豸�б�</a>
					<ul class="level2">
						<li><a href="#none">TW001801</a></li>
						<li><a href="#none">TW001802</a></li>
						<li><a href="#none">TW001803</a></li>
						<li><a href="#none">TW001804</a></li>
					</ul></li>
			</ul>
		</div> --%>

		<div id="Content-Main">
			<div style="line-height: 40px;"
				onClick="RequestUserList('a');showhide_obj('title6','icon6')">
				<font id='icon6'>+</font>�û��б�
			</div>
			<div id="title6"
				style="background-color: #fffff3; line-height: 35px; display: none;">
				<%
					//int usernum = 8;//Integer.parseInt(useridnumber);
					String menu6id, select6id, userlistid,userauthid;
					for (int i = 1; i < 10; i++) {
						//for (int i = 1; i <usernum ; i++) {
						menu6id = "menu6_" + i;
						select6id = "select6_" + i;
						userlistid = "userlistid" + i;
						userauthid = "userauthid" + i;
				%>
				<span id=<%=menu6id%> onclick="show_userid('<%=userlistid%>','<%=userauthid%>');show_this('<%=select6id%>')">
					<font id='<%=select6id%>'></font> 
					<font id='<%=userlistid%>'></font> 
					<input id='<%=userauthid%>' type="hidden">
				</span><br />
				<%
					}				
				%>
			</div>
			<div style="line-height: 40px;"
				onClick="RequestUserList('b');showhide_obj('title7','icon7')">
				<font id='icon7'>+</font>�豸�б�
			</div>
			<div id="title7"
				style="background-color: #fffff3; line-height: 35px; display: none;">
				<%
					//int usernum = 8;//Integer.parseInt(useridnumber);
					String menu7id, select7id, devlistid,devauthid;
					for (int i = 1; i < 10; i++) {
						//for (int i = 1; i <usernum ; i++) {
						menu7id = "menu7_" + i;
						select7id = "select7_" + i;
						devlistid = "devlistid" + i;
						devauthid = "devauthid" + i;
				%>
				<span id=<%=menu7id%> onclick="show_devid('<%=devlistid%>');show_this('<%=select7id%>')">
					<font id='<%=select7id%>'></font> 
					<font id='<%=devlistid%>'></font> 
					<input id='<%=devauthid%>' type="hidden">
				</span><br />
				<%
					}				
				%>
				
			</div>
		</div>

		<div id="Content-Veiw">
			<table><tr>
			<td width="90"></td><td width="80">�û���</td><td width="70">����</td><td width="80">Ȩ��</td></tr></table>
			<input type="text" id='gpName' value="<%=groupname%>" style="width: 80px; height: 30px; margin:5px; text-align: right" readonly="readonly" />
			<input type="text" id='userName' style="width: 40px; height: 30px; margin:5px; text-align: right" />
			<input type="text" id='userPWD' value="admin" style="width: 80px; height: 30px; margin:5px; text-align: right" /> 
			<input type="text" id='author' style="width: 40px; height: 30px; margin:5px; text-align: right" /><br /> 
			<input type="submit" value="����û�" style="width: 80px; height: 30px; margin:5px" 
					onclick="userfun('gpName','userName','userPWD','author','add')"/> <br /> 
			<input type="submit" value="ɾ���û�" style="width: 80px; height: 30px; margin:5px" 
					onclick="userfun('gpName','userName','userPWD','author','delete')" /><br /> 
			<input type="submit" value="�޸��û�" style="width: 80px; height: 30px; margin:5px"
					onclick="userfun('gpName','userName','userPWD','author','modify')" /> <br /> 
			<br /> 
			<table><tr>
			<td width="80">�豸��</td></tr></table>
			<input type="text" id='gpdName' value="<%=groupname%>" style="width: 80px; height: 30px; margin:5px; text-align: right" readonly="readonly" />
			<input type="text" id="devName" style="width: 40px; height: 30px; margin:5px; text-align: right" /> <br /> 
			<input type="submit" value="����豸" style="width: 80px; height: 30px; margin:5px" 
					onclick="userfun('gpName','devName','userPWD','userPWD','addev')" /> <br /> 
			<input type="submit" value="ɾ���豸" style="width: 80px; height: 30px; margin:5px" 
					onclick="userfun('gpName','devName','userPWD','userPWD','delete')" /> <br />
		</div>

	</div>

</body>











