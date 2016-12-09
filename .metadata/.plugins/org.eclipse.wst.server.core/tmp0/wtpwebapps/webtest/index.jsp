<%-- <%@ page contentType="text/html; charset=gb2312"%> --%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.Socket"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="util.TestLogger"%>

<body>
	<%
		String datetime=new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss").format( new java.util.Date());
		String name = null;	
		if (session.getAttribute("userid") == null) {
			session.setAttribute("userid", "TW001083"); //jyc20161007
			name = (String) session.getAttribute("userid");
			String addr=request.getRemoteAddr(); 
			String message = datetime+" "+name+" login IP:"+addr;
			String date = datetime.substring(0,10);			
			TestLogger.logfun(date,message);
		}
		name = (String) session.getAttribute("userid");
	%>
		<jsp:forward page="user.jsp" />
		<%-- <jsp:forward page="checklogin.jsp" /> --%> //jyc20161007
</body>











