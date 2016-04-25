<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> --%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>

<%!
 public static final String DBDRIVER = "com.mysql.jdbc.Driver" ;
 public static final String userName = "root";   //登录的用户名
 public static final String userPasswd = "102030";  //登录mysql密码
 public static final String dbName = "abc";  //数据库名
 public static final String tableName="users"; //表名
 public static final String DBURL = "jdbc:mysql://localhost:3306/"+dbName+"?user="+userName+"&password="+userPasswd;
%>

<%
  Connection conn = null ;
  PreparedStatement pstmt = null ;
  ResultSet rs = null ;
  boolean flag = false ; // 表示登陆成功或失败的标记
%>

<%
 String name = request.getParameter("userName") ; // 接收表单参数
 String password = request.getParameter("password") ; // 接收表单参数
 try{
   Class.forName(DBDRIVER) ;
   conn = DriverManager.getConnection(DBURL) ;
   String sql = "SELECT userName,userPWD FROM users WHERE userName=? AND userPWD=?" ;
   pstmt = conn.prepareStatement(sql) ;
   pstmt.setString(1,name) ;
   pstmt.setString(2,password) ;
   rs = pstmt.executeQuery() ;
   while(rs.next()){
    // 如果有内容，则此处执行，表示查询出来，合法用户
        flag = true ;
		session.setAttribute("userid",name);
  }
 }catch(Exception e){
 }finally{
  try{
   conn.close() ; // 连接一关闭，所有的操作都将关闭
  }catch(Exception e){}
 }
%>
<%
 if(flag){ // 登陆成功，应该跳转到user.jsp
%>
  <jsp:forward page="user.jsp"/>
<%
 }else{  // 登陆失败，跳转到failure.jsp
%> 
  <jsp:forward page="index.jsp"/>
<%
 }
%>

</body>
</html>