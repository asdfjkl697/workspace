/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.64
 * Generated at: 2016-03-24 05:56:49 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.samples;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class line_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!doctype html>\n");
      out.write("<html>\n");
      out.write("\t<head>\n");
      out.write("\t\t<title>Line Chart</title>\n");
      out.write("\t\t<script src=\"../js/Chart.js\"></script>\n");
      out.write("\t</head>\n");
      out.write("\t<body>\n");
      out.write("\t\t<div style=\"width:30%\">\n");
      out.write("\t\t\t<div>\n");
      out.write("\t\t\t\t<canvas id=\"canvas\" height=\"450\" width=\"600\"></canvas>\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t</div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\t<script>\n");
      out.write("\t\tvar randomScalingFactor = function(){ return Math.round(Math.random()*100)};\n");
      out.write("\t\tvar lineChartData = {\n");
      out.write("\t\t\tlabels : [\"January\",\"February\",\"March\",\"April\",\"May\",\"June\",\"July\"],\n");
      out.write("\t\t\tdatasets : [\n");
      out.write("\t\t\t\t{\n");
      out.write("\t\t\t\t\tlabel: \"My First dataset\",\n");
      out.write("\t\t\t\t\tfillColor : \"rgba(220,220,220,0.2)\",\n");
      out.write("\t\t\t\t\tstrokeColor : \"rgba(220,220,220,1)\",\n");
      out.write("\t\t\t\t\t//pointColor : \"rgba(220,220,220,1)\",\n");
      out.write("\t\t\t\t\tpointStrokeColor : \"#fff\",\n");
      out.write("\t\t\t\t\tpointHighlightFill : \"#fff\",\n");
      out.write("\t\t\t\t\tpointHighlightStroke : \"rgba(220,220,220,1)\",\n");
      out.write("\t\t\t\t\tdata : [randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor()]\n");
      out.write("\t\t\t\t},\n");
      out.write("/* \t\t\t\t{\n");
      out.write("\t\t\t\t\tlabel: \"My Second dataset\",\n");
      out.write("\t\t\t\t\tfillColor : \"rgba(151,187,205,0.2)\",\n");
      out.write("\t\t\t\t\tstrokeColor : \"rgba(151,187,205,1)\",\n");
      out.write("\t\t\t\t\tpointColor : \"rgba(151,187,205,1)\",\n");
      out.write("\t\t\t\t\tpointStrokeColor : \"#fff\",\n");
      out.write("\t\t\t\t\tpointHighlightFill : \"#fff\",\n");
      out.write("\t\t\t\t\tpointHighlightStroke : \"rgba(151,187,205,1)\",\n");
      out.write("\t\t\t\t\tdata : [randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor()]\n");
      out.write("\t\t\t\t} */\n");
      out.write("\t\t\t]\n");
      out.write("\n");
      out.write("\t\t}\n");
      out.write("\n");
      out.write("\twindow.onload = function(){\n");
      out.write("\t\tvar ctx = document.getElementById(\"canvas\").getContext(\"2d\");\n");
      out.write("\t\twindow.myLine = new Chart(ctx).Line(lineChartData, {\n");
      out.write("\t\t\tresponsive: true\n");
      out.write("\t\t});\n");
      out.write("\t}\n");
      out.write("\n");
      out.write("\n");
      out.write("\t</script>\n");
      out.write("\t</body>\n");
      out.write("</html>\n");
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
