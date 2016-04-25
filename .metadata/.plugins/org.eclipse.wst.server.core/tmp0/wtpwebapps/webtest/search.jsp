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

#Content-View {
	height: 500px;
	width: 1000px;
	margin: 10px; /*����Ԫ�ظ�����Ԫ�صľ���Ϊ20����*/
	float: left; /*���ø�����ʵ�ֶ���Ч����div+Css�����к���Ҫ��*/
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
		//String name = request.getParameter("userName"); // ���ձ�����
		boolean value7 = false;
	%>

	<div id="Container">
		<div id="Header">
			<div id="logo" style="font-size: 20px">
				<input type="button" value="���н���" style="margin:1px;width: 120px; height: 30px; background: #ADD8E6" 
					onclick="href_new('user.jsp')">  
				<input type="button" value="���ݲ�ѯ" style="margin:1px;width: 120px; height: 30px; background: #EDD8E6" 
					onclick="href_new('search.jsp')"> 
				<input type="button" value="���ݷ���" style="margin:1px; width: 120px; height: 30px; background: #ADD8E6"
					onclick="href_new('line.jsp')"> 
				<input type="button" value="��Ƶ" style="margin:1px; width: 120px; height: 30px; background: #ADD8E6"
					onclick="href_new('video.jsp')"> 
				<input type="button" value="����Ա" style="margin:1px; width: 120px; height: 30px; background: #ADD8E6"
					onclick="href_new('authority.jsp')"> 
				�û�����<%=name%> ʱ�䣺<%=datetime%>
			</div>
		</div>

		<div id="Content-View">
            ��ʼ:<input type="text" id='sdate' value=<%=datetime%> style="width:90px" onfocus="HS_setDate(this)">           
            ����:<input type="text" id='edate' value=<%=datetime%> style="width:90px" onfocus="HS_setDate(this)">
			����:<input type="text" id="number" style="width:50px;text-align:right"/>
			�豸:<input type=text id="devid" style="width:50px;text-align:right"/> 
				<input type="submit" value="��ѯ" style="width:60px"
				onclick="sendRequest('sdate','edate','number','devid','pageid')"/>
										
			<input class="call" type="submit" value="��ҳ" style="width: 60px"
				onclick="reduce();sendRequest('sdate','edate','number','devid','pageid')"/> 
			<input type=text id="pageid" value="1" style="width:32px;text-align:right"/>/
			<input type=text id="pageall" value="999" style="width:32px;text-align:right"/>
			<input class="call" type="submit" value="��ҳ" style="width: 60px" 
				onclick="add();sendRequest('sdate','edate','number','devid','pageid')"/> 
			<input type="submit" value="pdf" style="width: 60px" 
				onclick="sendpara('sdate','edate','number','devid')"/> 
			<table>
				<tr>
					<td width="100">����</td>
					<td width="100">ʱ��</td>
					<td width="80">�豸��</td>
					<td width="80">����</td>
					<td width="80">�¶ȡ�</td>
					<td width="80">ʪ��%RH</td>
					<td width="80">ѹ��Pa</td>
					<td width="80">Ũ��ppm</td>
					<td width="80">����m/s</td>
					<td width="80">ʱ��min</td>
					<td width="80">״̬</td>
					<td width="80">����</td>
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











