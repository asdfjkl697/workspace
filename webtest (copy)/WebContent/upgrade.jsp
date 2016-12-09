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
	width: 120px;
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
<script type="text/javascript" src="js/test.js"></script>
<script type="text/javascript" src="js/control.js"></script>
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

							$(this).addClass("current") //����ǰԪ�����"current"��ʽ
							.next().show() //��һ��Ԫ����ʾ
							.parent().siblings().children("a").removeClass(
									"current") //��Ԫ�ص��ֵ�Ԫ�ص���Ԫ��<a>�Ƴ�"current"��ʽ
							.next().hide(); //���ǵ���һ��Ԫ������
							return false;
						});

				$(".level2 > li a").click(function() {
							//var selectname = $(this).children("input").val();
							//$("#devid_status").val("offline");
							//for(var i=1;i<8;i++)$("#dataid"+i).val("");
							//for(var i=1;i<7;i++)$("#button"+i).css("background","#ADD8E6");
							//$("#devid_select").val(selectname.substring(0, 8));
							//Sendev('AAZ'); //send to dev request message add by jyc 20160511			
							$(this).addClass("current") //����ǰԪ�����"current"��ʽ
							.parent().siblings().children("a").removeClass(
									"current").next().hide(); //���ǵ���һ��Ԫ������ */
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
		//String name = request.getParameter("userName"); // ���ձ�����
	%>

	<div id="Container">
		<div id="Header">
			<ul class="menul">
					<li class="levela" ><a onclick="href_new('user.jsp')" id="dis1">���н���</a></li>
					<li class="levela" ><a onclick="href_new('search.jsp')" id='dis2'>���ݲ�ѯ</a></li>
					<li class="levela" ><a onclick="href_new('line.jsp')" id='dis3'>���ݷ���</a></li>
					<li class="levela" ><a onclick="href_new('video.jsp')" id='dis4'>��Ƶ</a></li>
					<li class="levela" ><a onclick="href_new('authority.jsp')" id='dis5'>�û�����</a></li>
					<li class="levela" ><a onclick="href_new('upgrade.jsp')" id='dis6' 
					 style="background: #EDD8E6">Զ������</a></li>
					<li class="levela" ><a onclick="href_new('record.jsp')" id='dis7'>ժ¼</a></li>
					<li>�û�����<%=name%> ���ڣ�<%=datetime%></li>
			</ul>
		</div>
		<div id="Content-Left">
				<ul class="menu">
					<li class="level1" ><a id='b'>�豸�б�</a>
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

			<input class="call" type="submit" value="����" onclick="Sendev('AAU')"
					style="width: 100px; height: 30px; margin:5px" />	

		</div>

		<div id="Content-Veiw">
			
			<form action="accept.jsp" method=post enctype="multipart/form-data">
				<br/>
				<input type=file name=fileforload size=30>
				<input type=submit value=�ϴ��ļ� name=submit>
			</form>		
		</div>

	</div>

</body>











