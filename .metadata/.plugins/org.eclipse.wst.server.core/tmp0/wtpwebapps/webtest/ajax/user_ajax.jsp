<%@ page import="com.mysql.jdbc.Driver"%>
<%-- <%@ page import="java.io.*" %> --%>
<%-- <%@ page import="java.sql.*"%> --%>
<%@ page import = "java.sql.*,java.text.*,java.lang.String" %> 
<%@ page contentType="text/html; charset=gb2312"%>



<%

	String datetime=new SimpleDateFormat("yyyyMMdd").format( new java.util.Date());

	response.setContentType("text/xml; charset=UTF-8");  
    //response.setHeader("Cache-Control","no-cache");
    
	String userName = request.getParameter("userName");
	String userPWD = request.getParameter("userPWD");
	String author = request.getParameter("author");
	String mode = request.getParameter("mode");
	//int id = Integer.parseInt(uid);
	
	String driverName = "com.mysql.jdbc.Driver";
	String user = "root";
	String userPasswd = "102030";
	String dbName = "abc";
	String tableName = "users";
	//String tableName = request.getParameter("userName");
	String url = "jdbc:mysql://localhost/" + dbName + "?user=" + user + "&password=" + userPasswd;
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection(url);
	Statement statement = connection.createStatement();
	//String sql = "SELECT * FROM " + tableName + " ORDER BY id DESC ";
	//String sql = "SELECT * FROM " + tableName + " ORDER BY id DESC LIMIT 21";
	//String sql = "SELECT * FROM " + tableName  + judge;	

	if(mode.equals("add")){
		String sql = "SELECT * FROM " + tableName + " where userName = '"+userName+"'";
		ResultSet rs = statement.executeQuery(sql);
		rs.last();
		int num = rs.getRow();
		if (num == 0) {
			sql = "insert into " + tableName + "(userName,userPWD,authority,creatime) " + "values('" + userName
					+ "','" + userPWD + "','" + author + "','" + datetime + "')";
			statement.executeUpdate(sql);
		}
	} else if (mode.equals("delete")) {
		String sql = "delete from " + tableName + " where userName = '" + userName + "'";
		statement.executeUpdate(sql);
	} else if (mode.equals("modify")) {
		String sql = "update " + tableName + " set userPWD='"+userPWD+"',authority='"+author+"' where userName = '" + userName + "'";
		statement.executeUpdate(sql);
	} else if (mode.equals("addev")) {
		String sql = "SELECT * FROM " + tableName + " where userName = '"+userName+"'";
		ResultSet rs = statement.executeQuery(sql);
		rs.last();
		int num = rs.getRow();
		if (num == 0) {
			sql = "insert into " + tableName + "(userName,userPWD,authority,creatime) " + "values('" + userName
					+ "','','8','" + datetime + "')";
			System.out.println(sql);
			statement.executeUpdate(sql);
		}
	}

	statement.close();
	connection.close();
%>
