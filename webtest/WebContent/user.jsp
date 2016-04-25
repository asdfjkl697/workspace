<%@ page contentType="text/html; charset=gb2312"%>
<%@ page language="java"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.Socket"%>
<%@ page import="java.text.SimpleDateFormat"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>TW_WEB</title>
<style type="text/css">
#Container {
	/* width: 1200px; */
	margin: 1 auto; /*设置整个容器在浏览器中水平居中*/
	/* background: #CF3; */
}

#Header {
	height: 40px;
	/* background: #093; */
}

#logo {
/* 	padding-left: 50px;
	padding-top: 20px;
	padding-bottom: 50px; */
    padding-left: 1px;
	padding-top: 1px;
	padding-bottom: 1px;
}

#Content {
	height: 540px;
	/*此处对容器设置了高度，一般不建议对容器设置高度，一般使用overflow:auto;属性设置容器根据内容自适应高度，如果不指定高度或不设置自适应高度，容器将默认为1个字符高度，容器下方的布局元素（footer）设置margin-top:属性将无效*/
	margin-top: 1px; /*此处讲解margin的用法，设置content与上面header元素之间的距离*/
	/* background: #0FF; */
}

#Content-Left {
	height: 500px;
	width: 100px;
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
	width: 220px;
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
                humidity(message.data);
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
    	var e = document.getElementById("devid_select").value

		var message = s.substring(0,5)+e.substring(5,8)+s.substring(5,8)+ ':tran:'+e+':'+data;
		Chat.socket.send(message);
    }
    
    function Sendev2(data,paraid){
    	var s = "<%=(String) session.getAttribute("userid")%>";
    	var e = document.getElementById("devid_select").value
    	var f = document.getElementById(paraid).value

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

	function humidity(message) {
		document.getElementById('dataid1').value = message.substring(0, 2)+"."+message.substring(2, 3);
		document.getElementById('dataid2').value = message.substring(3, 5)+"."+message.substring(5, 6);
		document.getElementById('dataid3').value = message.substring(6, 9)+"."+message.substring(9, 10);
		document.getElementById('dataid4').value = message.substring(10, 14);
		document.getElementById('dataid5').value = message.substring(14, 15)+"."+message.substring(15, 17);
		document.getElementById('dataid6').value = message.substring(17, 20);
		document.getElementById('dataid7').value = message.substring(20, 21);
	}

	Chat.initialize();

	document.addEventListener("DOMContentLoaded", function() {
		// Remove elements with "noscript" class - <noscript> is not allowed in XHTML
		var noscripts = document.getElementsByClassName("noscript");
		for (var i = 0; i < noscripts.length; i++) {
			noscripts[i].parentNode.removeChild(noscripts[i]);
		}
	}, false);
</script>
<script type="text/javascript" src="js/search.js" charset= "UTF-8"></script>
<script type="text/javascript" src="js/test.js"></script>
</head>

<body background="image/DNA.jpg">
	<%
		String name = (String) session.getAttribute("userid");
		if (session.getAttribute("userid") == null) {
			response.sendRedirect("index.jsp");
			return;
		}
		//java.util.Date d = new java.util.Date();
		String datetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format( new java.util.Date());
		//String name = request.getParameter("userName"); // 接收表单参数
		boolean value7 = false;
	%>

	<div id="Container">
		<div id="Header">
			<div id="logo" style="font-size: 20px">
				<input type="button" value="运行界面" style="margin:1px;width: 120px; height: 30px; background: #EDD8E6" 
					onclick="href_new('user.jsp')">  
				<input type="button" value="数据查询" style="margin:1px;width: 120px; height: 30px; background: #ADD8E6" 
					onclick="href_new('search.jsp')"> 
				<input type="button" value="数据分析" style="margin:1px; width: 120px; height: 30px; background: #ADD8E6"
					onclick="href_new('line.jsp')"> 
				<input type="button" value="视频" style="margin:1px; width: 120px; height: 30px; background: #ADD8E6"
					onclick="href_new('video.jsp')"> 
				<input type="button" value="管理员" style="margin:1px; width: 120px; height: 30px; background: #ADD8E6"
					onclick="href_new('authority.jsp')"> 
				用户名：<%=name%> 时间：<%=datetime%>
			</div>
		</div>
		<div id="Content">
			<div id="Content-Left">
				<div style="line-height: 40px;"
				onClick="RequestUserList('b');showhide_obj('title3','icon3')">
				<font id='icon3'>+</font>设备列表
			</div>
			<div id="title3"
				style="background-color: #fffff3; line-height: 35px; display: none;">
				<%
					//int usernum = 8;//Integer.parseInt(useridnumber);
					String menu3id, select3id, devlistid,devauthid;
					for (int i = 1; i < 10; i++) {
						//for (int i = 1; i <usernum ; i++) {
						menu3id = "menu3_" + i;
						select3id = "select3_" + i;
						devlistid = "devlistid" + i;
						devauthid = "devauthid" + i;
				%>
				<span id=<%=menu3id%> onclick="show_devid_all('<%=devlistid%>');Sendev('AAZ');show_this('<%=select3id%>')">
					<font id='<%=select3id%>'></font> 
					<font id='<%=devlistid%>'></font> 
					<input id='<%=devauthid%>' type="hidden">
				</span><br />
				<%
					}				
				%>
				
			</div>
				<br />
			</div>
			<div id="Content-Main" >
				<div id="button1" style="margin:5px">
					<input class="call" type="submit" value=" 自动运行 "
						onclick="Sendev('AAA')"
						style="width: 80px; height: 40px; background: #ADD8E6" />
				</div>
				<div id="button2" style="margin:5px">
					<input class="call" type="submit" value="   除湿   " 
						onclick="Sendev('AAB')"
						style="width: 80px; height: 40px; background: #ADD8E6" />
				</div>
				<div id="button3" style="margin:5px">
					<input class="call" type="submit" value="   加药   "
						onclick="Sendev('AAC')"
						style="width: 80px; height: 40px; background: #ADD8E6" />
				</div>
				<div id="button4" style="margin:5px">
					<input class="call" type="submit" value=" 灭菌保持 "
						onclick="Sendev('AAD')"
						style="width: 80px; height: 40px; background: #ADD8E6" />
				</div>
				<div id="button5" style="margin:5px">
					<input class="call" type="submit" value="   通风   "
						onclick="Sendev('AAE')"
						style="width: 80px; height: 40px; background: #ADD8E6" />
				</div>
				<div id="button6" style="margin:5px">
					<input class="call" type="submit" value="   保压   "
						onclick="Sendev('AAF')"
						style="width: 80px; height: 40px; background: #ADD8E6" />
				</div>
			</div>

			<div id="Content-View">
				设备编号：<input type="text" id="devid_select"
					style="width: 80px; height: 30px; margin:5px" readonly="readonly"/> <br /> 
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
				<div>
					<p>
						<input type="text" placeholder="type and press enter to chat"
							id="chat" />
					</p>
					<div id="console"></div>

				</div>
				
			</div>
			<div id="Content-Set">
				<br />
				<input type="text" id="savestate" value="" 
				style="width: 80px; height: 30px; color: blue; margin:5px" /> <br /> 
				<input class="call" type="submit" value="时间校正" onclick="Sendev('AAG')"
					style="width: 100px; height: 30px" /><br /> 

	  设定压差1: <input type="text" id='setpress' value="30"
					style="width: 50px; height: 30px; margin:5px" /> Pa 
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
				<input class="call" type="submit" value="读取" onclick="Sendev('AAH')"
					style="width: 100px; height: 30px; margin:5px" />
			</div>
		</div>
		<!-- <div class="Clear">如何你上面用到float,下面布局开始前最好清除一下。</div> -->
		<div id="Footer">Footer</div>

	</div>

</body>











