<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.Socket"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="console.pdf.CreatePDF"%>

<head>
<title>Line Chart</title>

<style type="text/css">
form, ul, li, p, h1, h2, h3, h4, h5, h6 {
	margin: 0;
	padding: 0;
}

img {
	border: 0;
}

ul li {
	list-style-type: none;
}

a {
	color: #00007F;
	text-decoration: none;
}

a:hover {
	color: #bd0a01;
	text-decoration: underline;
}

.box {
	width: 150px;
	margin: 0 auto;
}

.menul {
	overflow: hidden;
	border-color: #C4D5DF;
	border-style: solid;
	border-width: 0 1px 1px;
}

.menul li.levela {
	float: left;
	margin: 0px 2px 0px 2px;
	width: 100px;
}

.menul li.levela a {
	display: block;
	height: 28px;
	line-height: 28px;
	background: #EBF3F8;
	font-weight: 700;
	color: #5893B7;
	/* text-indent: 14px; */
	text-align: center;
	/* border-top: 1px solid #C4D5DF; */
	border: 1px solid #C4D5DF;
}

.menul li.levela a:hover {
	text-decoration: none;
}

.menul li.levela a.current {
	background: #B1D7EF;
}

.menul li ul {
	overflow: hidden;
}
</style>

<script src="js/Chart.js"></script>
<script type="text/javascript" src="js/test.js" charset="UTF-8"></script>
<script type="text/javascript" src="js/control.js"></script>
</head>
<body>
	<%
		String name = (String) session.getAttribute("userid");
		if (session.getAttribute("userid") == null) {
			response.sendRedirect("index.jsp");
			return;
		}
		//java.util.Date d = new java.util.Date();
		String datetime = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		//String name = request.getParameter("userName"); // 接收表单参数
	%>
	<div id="Header">
		<ul class="menul">
			<li class="levela"><a onclick="href_new('user.jsp')" id="dis1">运行界面</a></li>
			<li class="levela"><a onclick="href_new('search.jsp')" id='dis2'>数据查询</a></li>
			<li class="levela"><a onclick="href_new('line.jsp')" id='dis3' 
				style="background: #EDD8E6">数据分析</a></li>
			<li class="levela"><a onclick="href_new('video.jsp')" id='dis4'>视频</a></li>
			<li class="levela" ><a onclick="href_new('authority.jsp')" id='dis5'>用户管理</a></li>
			<li class="levela" ><a onclick="href_new('upgrade.jsp')" id='dis6'>远程升级</a></li>
			<li class="levela"><a onclick="href_new('record.jsp')" id='dis7'>摘录</a></li>
			<li>用户名：<%=name%> 日期：<%=datetime%></li>
		</ul>
	</div>
	<div>
		<br/>
		开始:<input type="text" id='sdate' value=<%=datetime%>
			style="width: 90px" onfocus="HS_setDate(this)"> 
		结束:<input 	type="text" id='edate' value=<%=datetime%> 
			style="width: 90px" onfocus="HS_setDate(this)"> 
		批号:<input type="text" id="number" style="width: 50px; text-align: right" /> 
		设备:<input type="text" 	id="devid" style="width: 50px; text-align: right" /> 
			<label><input type="checkbox" name="check">温度</label> 
			<label><input type="checkbox" name="check">湿度</label> 
			<label><input type="checkbox" name="check">压差</label> 
			<label><input type="checkbox" name="check">浓度</label>
			<label><input type="checkbox" name="check">风速</label>
			<input type="submit" value="查询" style="width: 60px" onclick="" /> 
			<input class="call" type="submit" value="放大" style="width: 60px" onclick="" /> 
			<input type=text id="pageid" value="1" style="width: 40px; text-align: right" /> 
			<input class="call" type="submit" value="缩小" style="width: 60px" onclick="" /> 
			<input type="submit" value="分析" style="width: 60px" onclick="" />
	</div>
	<div style="width: 100%">
		<div>
			<!-- <canvas id="canvas" height="450" width="600"></canvas> -->
			<canvas id="canvas" height="450" width="900"></canvas>
		</div>
	</div>

	<script>
		var randomScalingFactor = function(){ return Math.round(Math.random()*100)};
		var treeCol=new Array();
		for(var i=0;i<10;i++){
			treeCol[i]=new Array(); 
			for(var j=0;j<20;j++){
				treeCol[i][j]=randomScalingFactor()+50*i;
			}
		}
		
		var lineChartData = {
			labels : ["1","2","3","4","5","6","7","8","9","10",
			          "11","12","13","14","15","16","17","18","19","20"],
			datasets : [
				{
					label: "温度",
					//fillColor : "rgba(220,220,220,0.2)",
					fillColor : "transparent",
					strokeColor : "rgba(255,0,255,1)",
					pointColor : "rgba(255,0,255,1)",
					pointStrokeColor : "#fff",
					pointHighlightFill : "#fff",
					pointHighlightStroke : "rgba(255,0,255,1)",
					data : [treeCol[0][0],treeCol[0][1],treeCol[0][2],treeCol[0][3],treeCol[0][4],
						treeCol[0][5],treeCol[0][6],treeCol[0][7],treeCol[0][8],treeCol[0][9],
					    treeCol[0][10],treeCol[0][11],treeCol[0][12],treeCol[0][13],treeCol[0][14],
					    treeCol[0][15],treeCol[0][16],treeCol[0][17],treeCol[0][18],treeCol[0][19]
					]
				},
				{
					label: "湿度",
					//fillColor : "rgba(151,187,205,0.2)",
					fillColor : "transparent",
					strokeColor : "rgba(151,187,205,1)",
					pointColor : "rgba(151,187,205,1)",
					pointStrokeColor : "#fff",
					pointHighlightFill : "#fff",
					pointHighlightStroke : "rgba(151,187,205,1)",
					data : [treeCol[1][0],treeCol[1][1],treeCol[1][2],treeCol[1][3],treeCol[1][4],
							treeCol[1][5],treeCol[1][6],treeCol[1][7],treeCol[1][8],treeCol[1][9],
						    treeCol[1][10],treeCol[1][11],treeCol[1][12],treeCol[1][13],treeCol[1][14],
						    treeCol[1][15],treeCol[1][16],treeCol[1][17],treeCol[1][18],treeCol[1][19]
						]
				},
				{
					label: "压差",
					//fillColor : "rgba(151,187,205,0.2)",
					fillColor : "transparent",
					strokeColor : "rgba(100,0,100,1)",
					pointColor : "rgba(100,0,100,1)",
					pointStrokeColor : "#fff",
					pointHighlightFill : "#fff",
					pointHighlightStroke : "rgba(100,0,100,1)",
					data : [treeCol[2][0],treeCol[2][1],treeCol[2][2],treeCol[2][3],treeCol[2][4],
							treeCol[2][5],treeCol[2][6],treeCol[2][7],treeCol[2][8],treeCol[2][9],
						    treeCol[2][10],treeCol[2][11],treeCol[2][12],treeCol[2][13],treeCol[2][14],
						    treeCol[2][15],treeCol[2][16],treeCol[2][17],treeCol[2][18],treeCol[2][19]
						]
				},
				{
					label: "浓度",
					//fillColor : "rgba(151,187,205,0.2)",
					fillColor : "transparent",
					strokeColor : "rgba(0,100,100,1)",
					pointColor : "rgba(0,100,100,1)",
					pointStrokeColor : "#fff",
					pointHighlightFill : "#fff",
					pointHighlightStroke : "rgba(0,100,100,1)",
					data : [treeCol[3][0],treeCol[3][1],treeCol[3][2],treeCol[3][3],treeCol[3][4],
							treeCol[3][5],treeCol[3][6],treeCol[3][7],treeCol[3][8],treeCol[3][9],
						    treeCol[3][10],treeCol[3][11],treeCol[3][12],treeCol[3][13],treeCol[3][14],
						    treeCol[3][15],treeCol[3][16],treeCol[3][17],treeCol[3][18],treeCol[3][19]
						]
				},
				{
					label: "风速",
					//fillColor : "rgba(151,187,205,0.2)",
					fillColor : "transparent",
					strokeColor : "rgba(100,100,0,1)",
					pointColor : "rgba(100,100,0,1)",
					pointStrokeColor : "#fff",
					pointHighlightFill : "#fff",
					pointHighlightStroke : "rgba(100,100,0,1)",
					data : [treeCol[4][0],treeCol[4][1],treeCol[4][2],treeCol[4][3],treeCol[4][4],
							treeCol[4][5],treeCol[4][6],treeCol[4][7],treeCol[4][8],treeCol[4][9],
						    treeCol[4][10],treeCol[4][11],treeCol[4][12],treeCol[4][13],treeCol[4][14],
						    treeCol[4][15],treeCol[4][16],treeCol[4][17],treeCol[4][18],treeCol[4][19]
						]
				}
			]

		}
		
		var options = {
				
				//Boolean - If we show the scale above the chart data			
				scaleOverlay : false,
				
				//Boolean - If we want to override with a hard coded scale
				scaleOverride : false,
				
				//** Required if scaleOverride is true **
				//Number - The number of steps in a hard coded scale
				scaleSteps : null,
				//Number - The value jump in the hard coded scale
				scaleStepWidth : null,
				//Number - The scale starting value
				scaleStartValue : null,

				//String - Colour of the scale line	
				scaleLineColor : "rgba(0,0,0,.3)",
				
				//Number - Pixel width of the scale line	
				scaleLineWidth : 1,

				//Boolean - Whether to show labels on the scale	
				scaleShowLabels : true,
				
				//Interpolated JS string - can access value
				<%-- scaleLabel : "<%=value%>", --%>
				
				//String - Scale label font declaration for the scale label
				scaleFontFamily : "'Arial'",
				
				//Number - Scale label font size in pixels	
				scaleFontSize : 22,
				
				//String - Scale label font weight style	
				scaleFontStyle : "normal",
				
				//String - Scale label font colour	
				scaleFontColor : "#666",	
				
				///Boolean - Whether grid lines are shown across the chart
				scaleShowGridLines : true,
				
				//String - Colour of the grid lines
				scaleGridLineColor : "rgba(0,0,0,.3)",
				
				//Number - Width of the grid lines
				scaleGridLineWidth : 1,	
				
				//Boolean - Whether the line is curved between points
				bezierCurve : true,
				
				//Boolean - Whether to show a dot for each point
				pointDot : true,
				
				//Number - Radius of each point dot in pixels
				pointDotRadius : 3,
				
				//Number - Pixel width of point dot stroke
				pointDotStrokeWidth : 1,
				
				//Boolean - Whether to show a stroke for datasets
				datasetStroke : true,
				
				//Number - Pixel width of dataset stroke
				datasetStrokeWidth : 2,
				
				//Boolean - Whether to fill the dataset with a colour
				datasetFill : true,
				
				//Boolean - Whether to animate the chart
				animation : true,

				//Number - Number of animation steps
				animationSteps : 60,
				
				//String - Animation easing effect
				animationEasing : "easeOutQuart",

				//Function - Fires when the animation is complete
				onAnimationComplete : null
				
			}
		
		window.onload = function(){
			var ctx = document.getElementById("canvas").getContext("2d");
			window.myLine = new Chart(ctx).Line(lineChartData, options);
		}
	</script>
</body>
