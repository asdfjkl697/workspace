/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.64
 * Generated at: 2016-03-23 07:39:11 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

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
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("<!-- <title>用户登录</title> -->\n");
      out.write("<title>Apache Tomcat WebSocket Examples: Echo</title>\n");
      out.write("<style type=\"text/css\">\n");
      out.write("#Container {\n");
      out.write("\t/* width: 1200px; */\n");
      out.write("\tmargin: 0 auto; /*设置整个容器在浏览器中水平居中*/\n");
      out.write("\tbackground: #CF3;\n");
      out.write("}\n");
      out.write("\n");
      out.write("#Header {\n");
      out.write("\theight: 120px;\n");
      out.write("\t/* background: #093; */\n");
      out.write("}\n");
      out.write("\n");
      out.write("#logo {\n");
      out.write("\tpadding-left: 50px;\n");
      out.write("\tpadding-top: 20px;\n");
      out.write("\tpadding-bottom: 50px;\n");
      out.write("}\n");
      out.write("\n");
      out.write("#Content {\n");
      out.write("\theight: 540px;\n");
      out.write("\t/*此处对容器设置了高度，一般不建议对容器设置高度，一般使用overflow:auto;属性设置容器根据内容自适应高度，如果不指定高度或不设置自适应高度，容器将默认为1个字符高度，容器下方的布局元素（footer）设置margin-top:属性将无效*/\n");
      out.write("\tmargin-top: 20px; /*此处讲解margin的用法，设置content与上面header元素之间的距离*/\n");
      out.write("\tbackground: #0FF;\n");
      out.write("}\n");
      out.write("\n");
      out.write("#Content-Left {\n");
      out.write("\theight: 500px;\n");
      out.write("\twidth: 350px;\n");
      out.write("\tmargin: 20px; /*设置元素跟其他元素的距离为20像素*/\n");
      out.write("\tfloat: left; /*设置浮动，实现多列效果，div+Css布局中很重要的*/\n");
      out.write("\t/* background: #cc0; */\n");
      out.write("}\n");
      out.write("\n");
      out.write("#Content-Main {\n");
      out.write("\theight: 500px;\n");
      out.write("\twidth: 420px;\n");
      out.write("\tmargin: 20px; /*设置元素跟其他元素的距离为20像素*/\n");
      out.write("\tfloat: left; /*设置浮动，实现多列效果，div+Css布局中很重要的*/\n");
      out.write("\t/* background: #f00; */\n");
      out.write("}\n");
      out.write("\n");
      out.write("/*注：Content-Left和Content-Main元素是Content元素的子元素，两个元素使用了float:left;设置成两列，这个两个元素的宽度和这个两个元素设置的padding、margin的和一定不能大于父层Content元素的宽度，否则设置列将失败*/\n");
      out.write("#Footer {\n");
      out.write("\theight: 40px;\n");
      out.write("\tbackground: #90C;\n");
      out.write("\tmargin-top: 20px;\n");
      out.write("}\n");
      out.write("\n");
      out.write(".Clear {\n");
      out.write("\tclear: both;\n");
      out.write("}\n");
      out.write("</style>\n");
      out.write("   \n");
      out.write("</head>\n");
      out.write("\n");
      out.write("<body background=\"image/DNA.jpg\">\n");
      out.write("\t\t<div id=\"Header\">\n");
      out.write("\n");
      out.write("\t\t</div>\n");
      out.write("<div id=\"Content-Left\">\n");
      out.write("</div>\n");
      out.write("<div id=\"Content-Main\">\n");
      out.write("\t<h2>图旺平台登录</h2>\n");
      out.write("\t<form action=\"checklogin.jsp\" method=\"post\" style=\"font-size:25px\">\n");
      out.write("\t\t用户:<input type=\"text\" name=\"userName\" \n");
      out.write("\t\t\tstyle=\"width:100px;height: 30px; margin:5px\"> <br/>\t\t\n");
      out.write("\t\t密码:<input type=\"password\" name=\"password\" \n");
      out.write("\t\t\tstyle=\"width:100px;height: 30px; margin:5px\"><br/>\n");
      out.write("\t\t<input type=\"submit\" name=\"login\" value=\"登录\" \n");
      out.write("\t\t\tstyle=\"width:80px;height: 30px; margin:5px\"> \n");
      out.write("\t\t<input type=\"reset\" name=\"reset\" value=\"取消\" \n");
      out.write("\t\t\tstyle=\"width:80px;height: 30px; margin:5px\">\n");
      out.write("\t</form>\n");
      out.write("\t</div>\n");
      out.write("</body>\n");
      out.write("\n");
      out.write("</html>\n");
      out.write("\n");
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
