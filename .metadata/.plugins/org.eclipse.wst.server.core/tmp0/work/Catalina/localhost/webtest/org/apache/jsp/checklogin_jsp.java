/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.64
 * Generated at: 2016-07-25 02:14:27 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import java.text.SimpleDateFormat;
import java.sql.*;
import util.TestLogger;

public final class checklogin_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


	public static final String DBDRIVER = "com.mysql.jdbc.Driver";
	public static final String userName = "root"; //ç»å½çç¨æ·å
	public static final String userPasswd = "102030"; //ç»å½mysqlå¯ç 
	public static final String dbName = "abc"; //æ°æ®åºå
	public static final String tableName = "users"; //è¡¨å
	public static final String DBURL = "jdbc:mysql://localhost:3306/" + dbName + "?user=" + userName + "&password="
			+ userPasswd;

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=ISO-8859-1");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\n");
      out.write("<html>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write('\n');
      out.write('\n');

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	boolean flag = false; // è¡¨ç¤ºç»éæåæå¤±è´¥çæ è®°

      out.write('\n');
      out.write('\n');

	String datetime=new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss").format( new java.util.Date());
	String name = request.getParameter("userName"); // æ¥æ¶è¡¨ååæ°
	String password = request.getParameter("password"); // æ¥æ¶è¡¨ååæ°
	try {
		Class.forName(DBDRIVER);
		conn = DriverManager.getConnection(DBURL);
		String sql = "SELECT userName,userPWD FROM users WHERE userName=? AND userPWD=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, password);
		rs = pstmt.executeQuery();
		while (rs.next()) {
			// å¦ææåå®¹ï¼åæ­¤å¤æ§è¡ï¼è¡¨ç¤ºæ¥è¯¢åºæ¥ï¼åæ³ç¨æ·
			flag = true;
			session.setAttribute("userid", name);	

			String addr=request.getRemoteAddr(); 
			String message = datetime+" "+name+" login IP:"+addr;
			String date = datetime.substring(0,10);			
			TestLogger.logfun(date,message);
		}
	} catch (Exception e) {
	} finally {
		try {
			conn.close(); // è¿æ¥ä¸å³é­ï¼ææçæä½é½å°å³é­
		} catch (Exception e) {
		}
	}

      out.write('\n');
      out.write('\n');

		if (flag) { // ç»éæåï¼åºè¯¥è·³è½¬å°user.jsp

      out.write('\n');
      out.write('	');
      out.write('\n');
      out.write('	');
      if (true) {
        _jspx_page_context.forward("user.jsp");
        return;
      }
      out.write('\n');

		} else { // ç»éå¤±è´¥ï¼è·³è½¬å°failure.jsp

      out.write('\n');
      out.write('	');
      if (true) {
        _jspx_page_context.forward("index2.jsp");
        return;
      }
      out.write('\n');

		}

      out.write("\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
