<%@ page import="java.io.*"%>
<%@ page import="java.io.FileOutputStream"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>This page for response</title>
</head>
<body>
	<%
		try {
			if (request.getContentLength() > 297) {
				//String name = request.getParameter("fileforload"); // 接收表单参数
				//String title = request.getParameter("fileforload");
				String title = "lzrt.ipk";
				InputStream in = request.getInputStream();			
				File f = new File("./tomcat/webapps/upload",title);
				FileOutputStream o = new FileOutputStream(f);
				byte b[] = new byte[1024];
				int n;
				while ((n = in.read(b)) != -1) {
					o.write(b, 0, n);
				}
				o.close();
				in.close();
				out.print("File upload success!");
			} else {
				out.print("No file!");
			}
		} catch (IOException e) {
			out.print("upload error.");
			e.printStackTrace();
		}
	%>
</body>
</html>