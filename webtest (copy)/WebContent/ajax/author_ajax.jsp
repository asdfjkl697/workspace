<%@ page import="com.mysql.jdbc.Driver"%>
<%-- <%@ page import="java.io.*" %> --%>
<%-- <%@ page import="java.sql.*"%> --%>
<%@ page import = "java.sql.*,java.text.*,java.lang.String" %> 
<%@ page contentType="text/html; charset=gb2312"%>

<%
	response.setContentType("text/xml; charset=UTF-8");
	response.setHeader("Cache-Control", "no-cache");
	String list = request.getParameter("list");
	String name = (String) session.getAttribute("userid");
	String name_s="",name_e="";
	
	if(list.equals("a")){
		name_s = name.substring(0,5)+"001";
		name_e = name.substring(0,5)+"100";
	}
	else if(list.equals("b")){
		name_s = name.substring(0,5)+"101";
		name_e = name.substring(0,5)+"FFF";		
	}
	
	
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
	//String sql = "SELECT * FROM " + tableName +" where authority < '4' ORDER BY userID DESC ";
	
	String sql = "SELECT * FROM " + tableName +" where userName < '"
				+name_e+"' and userName >'"+name_s+"' ORDER BY userID DESC ";

	//String sql = "SELECT * FROM " + tableName + " ORDER BY id DESC LIMIT 21";
	ResultSet rs = statement.executeQuery(sql);	

	rs.last();
	int num = rs.getRow();
	String f = "%0" + 3 + "d";
	String numst = String.format(f, num);
	//System.out.println(numst);
	rs.first();
	out.println("<response>");
	out.println(list);
	out.println(numst);
	String data = rs.getString(2)+rs.getString(6);
	out.println(data);
	while (rs.next()) {
		data = rs.getString(2)+rs.getString(6);	 
 		out.println(data);
	}
	out.println("</response>");
	out.close();

	rs.close();
	statement.close();
	connection.close();
%>
