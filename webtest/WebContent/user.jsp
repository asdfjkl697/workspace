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
	margin: 1 auto; /*���������������������ˮƽ����*/
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
	/*�˴������������˸߶ȣ�һ�㲻������������ø߶ȣ�һ��ʹ��overflow:auto;������������������������Ӧ�߶ȣ������ָ���߶Ȼ���������Ӧ�߶ȣ�������Ĭ��Ϊ1���ַ��߶ȣ������·��Ĳ���Ԫ�أ�footer������margin-top:���Խ���Ч*/
	margin-top: 1px; /*�˴�����margin���÷�������content������headerԪ��֮��ľ���*/
	/* background: #0FF; */
}

#Content-Left {
	height: 500px;
	width: 100px;
	margin: 10px; /*����Ԫ�ظ�����Ԫ�صľ���Ϊ20����*/
	float: left; /*���ø�����ʵ�ֶ���Ч����div+Css�����к���Ҫ��*/
	/* background: #cc0; */
}

#Content-Main {
	height: 500px;
	width: 150px;
	margin: 10px; /*����Ԫ�ظ�����Ԫ�صľ���Ϊ20����*/
	float: left; /*���ø�����ʵ�ֶ���Ч����div+Css�����к���Ҫ��*/
	/* background: #cc0; */
}

#Content-View {
	height: 500px;
	width: 220px;
	margin: 10px; /*����Ԫ�ظ�����Ԫ�صľ���Ϊ20����*/
	float: left; /*���ø�����ʵ�ֶ���Ч����div+Css�����к���Ҫ��*/
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
	margin: 10px; /*����Ԫ�ظ�����Ԫ�صľ���Ϊ20����*/
	float: left; /*���ø�����ʵ�ֶ���Ч����div+Css�����к���Ҫ��*/
	/* background: #cc0; */
}

/*ע��Content-Left��Content-MainԪ����ContentԪ�ص���Ԫ�أ�����Ԫ��ʹ����float:left;���ó����У��������Ԫ�صĿ��Ⱥ��������Ԫ�����õ�padding��margin�ĺ�һ�����ܴ��ڸ���ContentԪ�صĿ��ȣ����������н�ʧ��*/
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
		//String name = request.getParameter("userName"); // ���ձ�������
		boolean value7 = false;
	%>

	<div id="Container">
		<div id="Header">
			<div id="logo" style="font-size: 20px">
				<input type="button" value="���н���" style="margin:1px;width: 120px; height: 30px; background: #EDD8E6" 
					onclick="href_new('user.jsp')">  
				<input type="button" value="���ݲ�ѯ" style="margin:1px;width: 120px; height: 30px; background: #ADD8E6" 
					onclick="href_new('search.jsp')"> 
				<input type="button" value="���ݷ���" style="margin:1px; width: 120px; height: 30px; background: #ADD8E6"
					onclick="href_new('line.jsp')"> 
				<input type="button" value="��Ƶ" style="margin:1px; width: 120px; height: 30px; background: #ADD8E6"
					onclick="href_new('video.jsp')"> 
				<input type="button" value="����Ա" style="margin:1px; width: 120px; height: 30px; background: #ADD8E6"
					onclick="href_new('authority.jsp')"> 
				�û�����<%=name%> ʱ�䣺<%=datetime%>
			</div>
		</div>
		<div id="Content">
			<div id="Content-Left">
				<div style="line-height: 40px;"
				onClick="RequestUserList('b');showhide_obj('title3','icon3')">
				<font id='icon3'>+</font>�豸�б�
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
					<input class="call" type="submit" value=" �Զ����� "
						onclick="Sendev('AAA')"
						style="width: 80px; height: 40px; background: #ADD8E6" />
				</div>
				<div id="button2" style="margin:5px">
					<input class="call" type="submit" value="   ��ʪ   " 
						onclick="Sendev('AAB')"
						style="width: 80px; height: 40px; background: #ADD8E6" />
				</div>
				<div id="button3" style="margin:5px">
					<input class="call" type="submit" value="   ��ҩ   "
						onclick="Sendev('AAC')"
						style="width: 80px; height: 40px; background: #ADD8E6" />
				</div>
				<div id="button4" style="margin:5px">
					<input class="call" type="submit" value=" ������� "
						onclick="Sendev('AAD')"
						style="width: 80px; height: 40px; background: #ADD8E6" />
				</div>
				<div id="button5" style="margin:5px">
					<input class="call" type="submit" value="   ͨ��   "
						onclick="Sendev('AAE')"
						style="width: 80px; height: 40px; background: #ADD8E6" />
				</div>
				<div id="button6" style="margin:5px">
					<input class="call" type="submit" value="   ��ѹ   "
						onclick="Sendev('AAF')"
						style="width: 80px; height: 40px; background: #ADD8E6" />
				</div>
			</div>

			<div id="Content-View">
				�豸��ţ�<input type="text" id="devid_select"
					style="width: 80px; height: 30px; margin:5px" readonly="readonly"/> <br /> 
				��ǰ�¶�: <input type="text" id="dataid1"
					style="width: 50px; height: 30px; margin:5px" readonly="readonly"/> �� <br />
				��ǰʪ��: <input type="text" id="dataid2"
					style="width: 50px; height: 30px; margin:5px" readonly="readonly"/> RH%<br /> 
				��ǰѹ��: <input type="text" id="dataid3"
					style="width: 50px; height: 30px; margin:5px" readonly="readonly"/> Pa<br />
				��ǰŨ��: <input type="text" id="dataid4"
					style="width: 50px; height: 30px; margin:5px" readonly="readonly"/> PPM<br /> 
				��ǰ����: <input type="text" id="dataid5" 
					style="width: 50px; height: 30px; margin:5px" readonly="readonly"/> m/s<br /> 
				����ʱ��: <input type="text" id="dataid6"
					style="width: 50px; height: 30px; margin:5px" readonly="readonly"/> min<br />
				��ǰ״̬: <input type="text" id="dataid7" 
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
				<input class="call" type="submit" value="ʱ��У��" onclick="Sendev('AAG')"
					style="width: 100px; height: 30px" /><br /> 

	  �趨ѹ��1: <input type="text" id='setpress' value="30"
					style="width: 50px; height: 30px; margin:5px" /> Pa 
				<input class="call" type="submit" value="����" onclick="Sendev2('AB','setpress')"
					style="width: 50px; height: 30px; margin:5px" /><br /> 
	 �趨���ʱ��: <input type="text" id='setime1' value="50"
					style="width: 50px; height: 30px; margin:5px" /> min 
				 <input class="call" type="submit" value="����" onclick="Sendev2('AC','setime1')"
					style="width: 50px; height: 30px; margin:5px" /><br /> 
	 �趨ͨ��ʱ��: <input 	type="text" id='setime2' value="50"
					style="width: 50px; height: 30px; margin:5px" /> min 
				<input class="call" type="submit" value="����" onclick="Sendev2('AD','setime2')"
					style="width: 50px; height: 30px; margin:5px" /><br /> 
	 �趨��ѹʱ��: <input type="text" id='setime3' value="50"
					style="width: 50px; height: 30px; margin:5px" /> min 
				<input class="call" type="submit" value="����" onclick="Sendev2('AE','setime3')"
					style="width: 50px; height: 30px; margin:5px" /><br /> 
<!-- 				<input class="call" type="submit" value="ȫ������" onclick=""
					style="width: 100px; height: 30px" /> -->
				<input class="call" type="submit" value="��ȡ" onclick="Sendev('AAH')"
					style="width: 100px; height: 30px; margin:5px" />
			</div>
		</div>
		<!-- <div class="Clear">����������õ�float,���沼�ֿ�ʼǰ������һ�¡�</div> -->
		<div id="Footer">Footer</div>

	</div>

</body>










