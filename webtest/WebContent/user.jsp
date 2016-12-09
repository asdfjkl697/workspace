<%-- <%@ page contentType="text/html; charset=gb2312"%> --%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.Socket"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="util.TestLogger"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>联舟技术</title>
<style type="text/css">
#Container {
	/* width: 1200px; */
	margin: 1 auto; /*设置整个容器在浏览器中水平居中*/
	/* background: #CF3; */
}

#Header {
	width:100%; 
	height: 30px;
	line-height:30px; 
	/* background-color:#99ffff; */
	filter: 
	progid:DXImageTransform.Microsoft.gradient(GradientType=2,startColorStr='#99ffaa',endColorStr='#99aaff'); /*IE*/
	background:linear-gradient(to left, #99ffaa, #99aaff);
	background:-moz-linear-gradient(left,#99ffaa,#99aaff);/*火狐*/
	background:-webkit-gradient(linear, 0% 0%, 100% 0%,from(#99ffaa), to(#99aaff));/*谷歌*/ 
}
#Name {	
	padding-left: 30px;	
	width: 200px;
	float: left; 
}

#Timer {
	padding-right: 30px;
	width: 300px;
	float: right;
}

#logo {
    padding-left: 2px;
	padding-top: 5px;
	padding-bottom: 5px;
}

#Content {
	height: 540px;
	/*此处对容器设置了高度，一般不建议对容器设置高度，一般使用overflow:auto;属性设置容器根据内容自适应高度，如果不指定高度或不设置自适应高度，容器将默认为1个字符高度，容器下方的布局元素（footer）设置margin-top:属性将无效*/
	margin-top: 1px; /*此处讲解margin的用法，设置content与上面header元素之间的距离*/
	/* background: #0FF; */
}

#Content-Left {
	height: 500px;
	width: 120px;
	margin: 10px; /*设置元素跟其他元素的距离为20像素*/
	float: left; /*设置浮动，实现多列效果，div+Css布局中很重要的*/
	/* background: #cc0; */
}

#Content-Main {
	height: 500px;
	width: 150px;
	margin: 10px; /*设置元素跟其他元素的距离为20像素*/
	float: left; /*设置浮动，实现多列效果，div+Css布局中很重要的*/
	/* background: #cc0; */
}

#Content-View {
	height: 500px;
	width: 300px;
	margin: 10px; /*设置元素跟其他元素的距离为20像素*/
	float: left; /*设置浮动，实现多列效果，div+Css布局中很重要的*/
	/* background: #cc0; */
}

input#chat {
	width: 220px
}

/* #console-container {
	width: 400px;
} */
#console {
	border: 1px solid #CCCCCC;
	border-right-color: #999999;
	border-bottom-color: #999999;
	height: 170px;
	overflow-y: scroll;
	padding: 5px;
	width: 100%;
}

/* #console p {
	padding: 0;
	margin: 0;
} */

#Content-Set {
	height: 500px;
	width: 300px;
	margin: 10px; /*设置元素跟其他元素的距离为20像素*/
	float: left; /*设置浮动，实现多列效果，div+Css布局中很重要的*/
	/* background: #cc0; */
}

/*注：Content-Left和Content-Main元素是Content元素的子元素，两个元素使用了float:left;设置成两列，这个两个元素的宽度和这个两个元素设置的padding、margin的和一定不能大于父层Content元素的宽度，否则设置列将失败*/
#Footer {
	height: 40px;
	/* background: #90C; */
	margin-top: 20px;
}

.Clear {
	clear: both;
}

/* body {
	margin: 0;
	padding: 0 0 12px 0;
	font-size: 14px;
	line-height: 24px;
	background: #fff;
} */

form, ul, li, p, h1, h2, h3, h4, h5, h6 {
	margin: 0;
	padding: 0;
}

/* input, select {
	font-size: 14px;
	line-height: 18px;
} */

img {
	border: 0;
}

ul li{
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

.menu {
	overflow: hidden;
	border-color: #C4D5DF;
	border-style: solid;
	border-width: 0 1px 1px;
}

.menu li.level1 a {
	display: block;
	height: 28px;
	line-height: 28px;
	background: #EBF3F8;
	font-weight: 700;
	color: #5893B7;
	text-indent: 14px;
	border-top: 1px solid #C4D5DF;
}

.menu li.level1 a:hover {
	text-decoration: none;
}

.menu li.level1 a.current {
	background: #B1D7EF;
}


.menu li ul {
	overflow: hidden;
}

.menu li ul.level2 {
	display: none;
}

.menu li ul.level2 li a {
	display: block;
	height: 28px;
	line-height: 28px;
	background: #ffffff;
	font-weight: 400;
	color: #42556B;
	text-indent: 18px;
	border-top: 0px solid #ffffff;
	overflow: hidden; 
}

.menu li ul.level2 li a:hover {
	text-decoration: none;
}
.menu li ul.level2 li a.current {
	background: #B1D7EF;
}

.menul {
	overflow: hidden;
	border-color: #C4D5DF;
	border-style: solid;
	border-width: 0 1px 1px;
}

.menul li.levela {
	float:left;
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
	text-align:center;
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

<script type="text/javascript">
        var Chat = {};

        Chat.socket = null;

        Chat.connect = (function(host) {
            if ('WebSocket' in window) {
                Chat.socket = new WebSocket(host);
            } else if ('MozWebSocket' in window) {
                Chat.socket = new MozWebSocket(host);
            } else {
                Console.log('Error: WebSocket is not supported by this browser.');
                return;
            }

            Chat.socket.onopen = function () {
                Console.log('Info: WebSocket connection opened.');
                document.getElementById('chat').onkeydown = function(event) {
                    if (event.keyCode == 13) {
                        Chat.sendMessage();
                    }
                };
            };

            Chat.socket.onclose = function () {
                document.getElementById('chat').onkeydown = null;
                Console.log('Info: WebSocket closed.');
            };

            Chat.socket.onmessage = function (message) {
                Console.log(message.data);
                showmessage(message.data);
            };
        });

        Chat.initialize = function() {
            if (window.location.protocol == 'http:') {
                Chat.connect('ws://' + window.location.host + '/webtest/websocket/chat');
            } else {
                Chat.connect('wss://' + window.location.host + '/webtest/websocket/chat');
            }
        };
        
   
        Chat.sendMessage = (function() {
        	var s = "<%=(String) session.getAttribute("userid")%>";
        	var e = document.getElementById('chat').value;
			var message = s.substring(0,5)+e.substring(6,9)+s.substring(6,9)+ ':tran:' + e;
			if (message != '') {
			Chat.socket.send(message);
			document.getElementById('chat').value = '';
		}
	});
        
    function Sendev(data){
    	var s = "<%=(String) session.getAttribute("userid")%>";
    	var e = $("#devid_select").val();
		var message = s.substring(0,5)+e.substring(5,8)+s.substring(5,8)+ ':tran:'+e+':'+data;
		Chat.socket.send(message);
    }
    
    function Sendev2(data,paraid){
    	var s = "<%=(String) session.getAttribute("userid")%>";
    	var e = $("#devid_select").val();
    	var f = $("#"+paraid).val();

		var message = s.substring(0,5)+e.substring(5,8)+s.substring(5,8)+ ':tran:'+e+':'+data+f;	
		Chat.socket.send(message);
    }

	var Console = {};

	Console.log = (function(message) {
		var console = document.getElementById('console');
		var p = document.createElement('p');
		p.style.wordWrap = 'break-word';
		p.innerHTML = message;
		console.appendChild(p);
		while (console.childNodes.length > 25) {
			console.removeChild(console.firstChild);
		}
		console.scrollTop = console.scrollHeight;
	});

	function showmessage(message) {
		$("#devid_status").val("online");
		$("#dataid1").val(message.substring(0, 2)+"."+message.substring(2, 3));
		$("#dataid2").val(message.substring(3, 5)+"."+message.substring(5, 6));
		$("#dataid3").val(message.substring(6, 9)+"."+message.substring(9, 10));
		$("#dataid4").val(message.substring(10, 14));
		$("#dataid5").val(message.substring(14, 15)+"."+message.substring(15, 17));
		$("#dataid6").val(message.substring(17, 20));
		$("#dataid7").val(message.substring(20, 21));

		var devstatus=Number(message.substring(20, 21));
		for(var i=1;i<7;i++){
			if((i==devstatus+1)&&(devstatus>0))
				$("#button"+i).css("background","#4A708B");
			else
				$("#button"+i).css("background","#ADD8E6");
		}		
	}

	Chat.initialize();

	document.addEventListener("DOMContentLoaded", function() {
		// Remove elements with "noscript" class - <noscript> is not allowed in XHTML
		var noscripts = document.getElementsByClassName("noscript");
		for (var i = 0; i < noscripts.length; i++) {
			noscripts[i].parentNode.removeChild(noscripts[i]);
		}
	}, false);
	
	
	function showdevlist() {
		$.ajax({
			type : 'get',
			cache : false,
			url : 'ajax/author_ajax.jsp',
			data : {list : 'b'},
			dataType : 'text',
			success : function(data) {
				var st_n = 17;
				//var list = data.substring(st_n + 1,st_n + 2);
				var msgnum = Number(data.substring(st_n + 3, st_n + 6));

				for (var i = 1; i < 30; i++) {
					var msglen = st_n + 10 * (i - 1);
					if (i > msgnum)
						$("#devlist" + i).parent().css("display", "none");
					//$("#devlist"+i).val("");								
					else
						$("#devlist" + i).val(
								data.substring(msglen + 6, msglen + 15));
				}
			}
		});

		$(".level1 > a").addClass("current") //给当前元素添加"current"样式
		.next().show() //下一个元素显示
		.parent().siblings().children("a").removeClass("current") //父元素的兄弟元素的子元素<a>移除"current"样式
		.next().hide(); //它们的下一个元素隐藏
		return false;
	}
</script>
<script src="js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="js/search.js" charset= "UTF-8"></script>
<script type="text/javascript" src="js/functions.js"></script>
<script>
	$(document).ready(function() {
				$(".level1 > a").click(function() {
							$.ajax({
								type : 'get',
								cache : false,
								url : 'ajax/author_ajax.jsp',
								data : {list:'b'},
								dataType : 'text',
								success : function(data) {
									var st_n = 17;
									//var list = data.substring(st_n + 1,st_n + 2);
									var msgnum = Number(data.substring(st_n + 3,st_n + 6));

									for (var i = 1; i < 30; i++) {
										var msglen = st_n + 10 * (i - 1);
										if (i > msgnum)
											$("#devlist"+i).parent().css("display","none");
											//$("#devlist"+i).val("");								
										else
											$("#devlist"+i).val(data.substring(msglen+6,msglen+15));
									}									
								}
							});

							$(this).addClass("current") //给当前元素添加"current"样式
							.next().show() //下一个元素显示
							.parent().siblings().children("a").removeClass(
									"current") //父元素的兄弟元素的子元素<a>移除"current"样式
							.next().hide(); //它们的下一个元素隐藏
							return false;
						});

				$(".level2 > li a").click(function() {
							var selectname = $(this).children("input").val();
							$("#devid_status").val("offline");
							for(var i=1;i<8;i++)$("#dataid"+i).val("");
							for(var i=1;i<7;i++)$("#button"+i).css("background","#ADD8E6");
							$("#devid_select").val(selectname.substring(0, 8));
							Sendev('AAZ'); //send to dev request message add by jyc 20160511			
							$(this).addClass("current") //给当前元素添加"current"样式
							.parent().siblings().children("a").removeClass(
									"current").next().hide(); //它们的下一个元素隐藏 */
							return false;
						});
			});
</script>
</head>

<body background="image/DNA.jpg" onload="showdevlist()">
	<%
		String datetime=new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss").format( new java.util.Date());
		String name = null;	
		if (session.getAttribute("userid") == null) {
			session.setAttribute("userid", "TW001083");
			name = (String) session.getAttribute("userid");
			String addr=request.getRemoteAddr(); 
			String message = datetime+" "+name+" login IP:"+addr;
			String date = datetime.substring(0,10);			
			TestLogger.logfun(date,message);
		}
		name = (String) session.getAttribute("userid");

		datetime=new SimpleDateFormat("yyyy-MM-dd").format( new java.util.Date());

		boolean value7 = false;
	%>


	<div id="Container">
		<div id="Header" >
			<div id="Name" style="color: #5893B7"><h3>联舟技术</h3></div>
			<div id="Timer">
				用户名：<%=name%>
				日期：<%=datetime%></div>
		</div>
		<div id="logo">
			<ul class="menul">
					<li class="levela" ><a onclick="href_new('user.jsp')" style="background: #EDD8E6">隔离器</a></li>					
					<li class="levela" ><a onclick="href_new('video.jsp')" >视频直播</a></li>
					<li class="levela" ><a onclick="href_new('jiont.jsp')"  >中产交互器</a></li>
					<li class="levela" ><a onclick="href_new('jiontreq.jsp')" >中产终端</a></li>
					<li class="levela" ><a onclick="href_new('line.jsp')" >数据分析</a></li>
					<li class="levela" ><a onclick="href_new('search.jsp')" >数据查询</a></li>									
					<li class="levela" ><a onclick="href_new('upgrade.jsp')" >远程升级</a></li>
					<li class="levela" ><a onclick="href_new('record.jsp')" >介绍</a></li>		
					<li class="levela" ><a onclick="href_new('authority.jsp')" >管理登录</a></li>
			</ul>
		</div>

		<div id="Content">
		<div id="Content-Left">
				<ul class="menu">
					<li class="level1" ><a id='b'>设备列表</a>
						<ul class="level2">	
							<%
								String devlist="";
								for (int i = 1; i < 30; i++) {
									devlist="devlist"+i;
							%>		
							<li><a><input id="<%=devlist%>" onfocus="this.blur();"
								style="border:0px;background-color:transparent;margin:5px;">
								</a></li>
							<%}%>		
						</ul>
					</li>
				</ul>

			</div>
			
			<div id="Content-Main">
				<div style="margin:5px">
					<input class="call" type="submit" value=" 自动运行 " id="button1"
						onclick="Sendev('AAA')"
						style="width: 80px; height: 40px; background: #ADD8E6" />
				</div>
				<div style="margin:5px">
					<input class="call" type="submit" value="   除湿   " id="button2"
						onclick="Sendev('AAB')"
						style="width: 80px; height: 40px; background: #ADD8E6" />
				</div>
				<div style="margin:5px">
					<input class="call" type="submit" value="   加药   " id="button3"
						onclick="Sendev('AAC')"
						style="width: 80px; height: 40px; background: #ADD8E6" />
				</div>
				<div style="margin:5px">
					<input class="call" type="submit" value=" 灭菌保持 " id="button4"
						onclick="Sendev('AAD')"
						style="width: 80px; height: 40px; background: #ADD8E6" />
				</div>
				<div style="margin:5px">
					<input class="call" type="submit" value="   通风   " id="button5"
						onclick="Sendev('AAE')"
						style="width: 80px; height: 40px; background: #ADD8E6" />
				</div>
				<div style="margin:5px">
					<input class="call" type="submit" value="   保压   " id="button6"
						onclick="Sendev('AAF')"
						style="width: 80px; height: 40px; background: #ADD8E6" />
				</div>
				<div style="margin:5px">
					<input class="call" type="submit" value="   停止   " id="button7"
						onclick="Sendev('AAG')"
						style="width: 80px; height: 40px; background: #ADD8E6" />
				</div>
			</div>

			<div id="Content-View">
				设备状态: <input type="text" id="devid_status" value="offline"
					style="width: 100px; height: 30px; margin:5px" readonly="readonly"/> <br />
				设备编号: <input type="text" id="devid_select"
					style="width: 100px; height: 30px; margin:5px" readonly="readonly"/> <br /> 
				当前温度: <input type="text" id="dataid1"
					style="width: 50px; height: 30px; margin:5px" readonly="readonly"/> ℃ <br />
				当前湿度: <input type="text" id="dataid2"
					style="width: 50px; height: 30px; margin:5px" readonly="readonly"/> RH%<br /> 
				当前压差: <input type="text" id="dataid3"
					style="width: 50px; height: 30px; margin:5px" readonly="readonly"/> Pa<br />
				当前浓度: <input type="text" id="dataid4"
					style="width: 50px; height: 30px; margin:5px" readonly="readonly"/> PPM<br /> 
				当前风速: <input type="text" id="dataid5" 
					style="width: 50px; height: 30px; margin:5px" readonly="readonly"/> m/s<br /> 
				持续时间: <input type="text" id="dataid6"
					style="width: 50px; height: 30px; margin:5px" readonly="readonly"/> min<br />
				当前状态: <input type="text" id="dataid7" 
					style="width: 50px; height: 30px; margin:5px" readonly="readonly"/><br /> 

			
				<div class="noscript">
					<h2 style="color: #ff0000">Seems your browser doesn't support
						Javascript! Websockets rely on Javascript being enabled. Please
						enable Javascript and reload this page!</h2>
				</div>
				<div style="display:none">
					<p>
						<input type="text" placeholder="type and press enter to chat"
							id="chat" />
					</p>
					<div id="console"></div>

				</div>
				
			</div>
			<div id="Content-Set">
				<br />
				<!-- <input type="text" id="savestate" value="" 
				style="width: 80px; height: 30px; color: blue; margin:5px" /> <br />  -->
				<input class="call" type="submit" value="读取参数" onclick="Sendev('AAH')"
					style="width: 100px; height: 30px; margin:5px" />
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input class="call" type="submit" value="时间校正" onclick="Sendev('AAJ')"
					style="width: 100px; height: 30px" /><br /> 

	 设定调节压差: <input type="text" id='setpress' value="30"
					style="width: 50px; height: 30px; margin:5px" /> Pa.
				<input class="call" type="submit" value="保存" onclick="Sendev2('AB','setpress')"
					style="width: 50px; height: 30px; margin:5px" /><br /> 
	 设定灭菌时间: <input type="text" id='setime1' value="50"
					style="width: 50px; height: 30px; margin:5px" /> min 
				 <input class="call" type="submit" value="保存" onclick="Sendev2('AC','setime1')"
					style="width: 50px; height: 30px; margin:5px" /><br /> 
	 设定通风时间: <input 	type="text" id='setime2' value="50"
					style="width: 50px; height: 30px; margin:5px" /> min 
				<input class="call" type="submit" value="保存" onclick="Sendev2('AD','setime2')"
					style="width: 50px; height: 30px; margin:5px" /><br /> 
	 设定保压时间: <input type="text" id='setime3' value="50"
					style="width: 50px; height: 30px; margin:5px" /> min 
				<input class="call" type="submit" value="保存" onclick="Sendev2('AE','setime3')"
					style="width: 50px; height: 30px; margin:5px" /><br /> 
<!-- 				<input class="call" type="submit" value="全部保存" onclick=""
					style="width: 100px; height: 30px" /> -->

			</div>
		</div>
		<!-- <div class="Clear">如何你上面用到float,下面布局开始前最好清除一下。</div> -->
		<div id="Footer" style="font-size:12px;color:#5893B7">
		©2016 lianzhouiot 22960468@qq.com</div>

	</div>

</body>











