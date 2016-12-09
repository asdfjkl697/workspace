<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import = "java.sql.*,java.text.*,java.lang.String" %>
<%@ page import="java.net.Socket"%>
<%-- <%@ page import="console.pdf.CreatePDF"%>
<%@ page import="com.itextpdf.text.Document"%>
<%@ page import="com.itextpdf.text.DocumentException"%>
<%@ page import="com.itextpdf.text.PageSize"%>
<%@ page import="com.itextpdf.text.Paragraph"%>
<%@ page import="com.itextpdf.text.pdf.PdfWriter"%>
<%@ page import="com.itextpdf.text.Font"%>
<%@ page import="com.itextpdf.text.pdf.BaseFont"%> --%>
<%@ page import="com.itextpdf.text.*"%>
<%@ page import="com.itextpdf.text.pdf.*"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.io.*"%>

<html>
<body>
	<%
		response.setContentType("application/pdf");

		String sdate = request.getParameter("sdate");
		String edate = request.getParameter("edate");
		String number = request.getParameter("number");
		String devid = request.getParameter("devid");

		String[] str3 = sdate.split("-");
		String ssdate = str3[0] + "-" + String.format("%2s", str3[1]) + "-" + String.format("%2s", str3[2]);
		ssdate = ssdate.replaceAll("\\s", "0");
		str3 = edate.split("-");
		String eedate = str3[0] + "-" + String.format("%2s", str3[1]) + "-" + String.format("%2s", str3[2]);
		eedate = eedate.replaceAll("\\s", "0");

		String judgetemp;
		String judge = " where date >= '" + ssdate + "' and date <= '" + eedate + "'";
		if (number != "") {
			judgetemp = String.format("%2s", number);
			judgetemp = judgetemp.replaceAll("\\s", "0");
			judge = judge + " and num= " + judgetemp;
		}
		if (devid != "") {
			judgetemp = String.format("%4s", devid);
			judgetemp = judgetemp.replaceAll("\\s", "0");
			judge = judge + " and typedevid= " + judgetemp;
		}

		judge = judge + " ORDER BY id DESC";

		String driverName = "com.mysql.jdbc.Driver";
		String userName = "root";
		String userPasswd = "102030";
		String dbName = "abc";
		String tableName = "TW001_2016";
		//String tableName = request.getParameter("userName");
		String url = "jdbc:mysql://localhost/" + dbName + "?user=" + userName + "&password=" + userPasswd;
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection connection = DriverManager.getConnection(url);
		Statement statement = connection.createStatement();

		String sql = "SELECT * FROM " + tableName + judge;
		ResultSet rs = statement.executeQuery(sql);
		rs.next();

		Document document = new Document();
		ByteArrayOutputStream buffer = new ByteArrayOutputStream();
		PdfWriter writer = PdfWriter.getInstance(document, buffer);
		document.open();
		BaseFont bf=BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);
		   Font font=new Font(bf,12,Font.NORMAL);
		    
		//document.add(new Paragraph("Hello World"));
		//Paragraph content = new Paragraph("中文", font);
 		Paragraph content = new Paragraph("日期                  时间              "+
				"设备  批号  温度    湿度     压差     浓度     风速   时间   状态  命令", font);
		document.add(content);
		while (rs.next()) {
			String msg=rs.getString(7);
			String data = rs.getString(3)+"  "+rs.getString(4)
			+"   "+rs.getString(6)
			+"   "+rs.getString(5)
			+"   "+msg.substring(0,2)+"."+msg.substring(2,3)
			+"   "+msg.substring(3,5)+"."+msg.substring(5,6)
			+"   "+msg.substring(6,9)+"."+msg.substring(9,10)
			+"   "+msg.substring(10,14)
			+"   "+msg.substring(14,15)+"."+msg.substring(15,17)
			+"   "+msg.substring(17,20)
			+"     "+msg.substring(20,21)
			+"     "+rs.getString(2);
			document.add(new Paragraph(data));
		} 

		document.close();

		DataOutput output = new DataOutputStream(response.getOutputStream());

		byte[] bytes = buffer.toByteArray();

		response.setContentLength(bytes.length);
		
		for (int i = 0; i < bytes.length; i++) {
			output.writeByte(bytes[i]);
		}
	%>
</body>
</html>
