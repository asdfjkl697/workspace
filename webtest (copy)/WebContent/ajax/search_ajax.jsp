<%@ page import="com.mysql.jdbc.Driver"%>
<%-- <%@ page import="java.io.*" %> --%>
<%-- <%@ page import="java.sql.*"%> --%>
<%@ page import = "java.sql.*,java.text.*,java.lang.String" %> 
<%@ page contentType="text/html; charset=gb2312"%>

<%   
	String name = (String) session.getAttribute("userid");
	String datetime=new SimpleDateFormat("yyyy").format( new java.util.Date());
	
	response.setContentType("text/xml; charset=UTF-8");  
    //response.setHeader("Cache-Control","no-cache");
    
	String sdate = request.getParameter("sdate");
	String edate = request.getParameter("edate");
	String number = request.getParameter("number");
    String devid = request.getParameter("devid");
    String pageid = request.getParameter("pageid");
    
    String page_start = (Integer.parseInt(pageid)*21-21)+"";
    String page_end=(Integer.parseInt(pageid)*21)+"";
/*     String page_start=String.valueOf(Integer.parseInt(pageid)*21);
    String page_end=String.valueOf(Integer.parseInt(pageid)*21+21);
    System.out.println(page_start); */
    
    String[] str3 = sdate.split("-");	
	String ssdate =  str3[0]+"-"+String.format("%2s", str3[1])+"-"+String.format("%2s", str3[2]);
	ssdate = ssdate.replaceAll("\\s", "0");
	str3 = edate.split("-");	
	String eedate =  str3[0]+"-"+String.format("%2s", str3[1])+"-"+String.format("%2s", str3[2]);
	eedate = eedate.replaceAll("\\s", "0");
		
    //String judge = " where year>syear or (year=syear and month>smonth or (month="+smonth+" and day>="+sday+"))";
    //String judge = " where date > '2016-03-01'";
    String judgetemp;
    String judge = " where date >= '"+ssdate+"' and date <= '"+eedate+"'";
    if(number!=""){
    	judgetemp=String.format("%2s",number);
    	judgetemp = judgetemp.replaceAll("\\s", "0");
    	judge = judge+" and num= "+judgetemp;
    }
    if(devid!=""){
    	judgetemp=String.format("%4s",devid);
    	judgetemp = judgetemp.replaceAll("\\s", "0");
    	judge = judge+" and typedevid= "+judgetemp;
    }
    judge = judge + " ORDER BY id DESC ";
    String judgeall = judge+" LIMIT "+page_start+","+page_end;

	//int id = Integer.parseInt(uid);
	
	String driverName = "com.mysql.jdbc.Driver";
	String userName = "root";
	String userPasswd = "102030";
	String dbName = "abc";
	String tableName = name.substring(0,5)+"_"+datetime;
	//String tableName = request.getParameter("userName");
	String url = "jdbc:mysql://localhost/" + dbName + "?user=" + userName + "&password=" + userPasswd;
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection(url);
	Statement statement = connection.createStatement();
	String sql = "SELECT * FROM " + tableName + judge;
	ResultSet rs = statement.executeQuery(sql);
	rs.last();
	int num = (rs.getRow()+20)/21;
	String rsall = String.format("%03d", num);
	sql = "SELECT * FROM " + tableName  + judgeall;	
	rs = statement.executeQuery(sql);
	out.println("<response>");
	out.println(rsall);

	while (rs.next()) {
		String date = rs.getString(3)+rs.getString(4)+rs.getString(6)
 		+rs.getString(5)+rs.getString(7)+rs.getString(2);
		out.println(date);
	}
    out.println("</response>");  
    out.close();  
    
	rs.close();
	statement.close();
	connection.close();  
%>
