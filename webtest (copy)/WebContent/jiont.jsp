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
	width: 120px;
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
	width: 450px;
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
	height: 400px;
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

/*ע��Content-Left��Content-MainԪ����ContentԪ�ص���Ԫ�أ�����Ԫ��ʹ����float:left;���ó����У��������Ԫ�صĿ�Ⱥ��������Ԫ�����õ�padding��margin�ĺ�һ�����ܴ��ڸ���ContentԪ�صĿ�ȣ����������н�ʧ��*/
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
</script>
<script src="js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="js/search.js" charset= "UTF-8"></script>
<script type="text/javascript" src="js/test.js"></script>
<script type="text/javascript" src="js/control.js"></script>
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

							$(this).addClass("current") //����ǰԪ�����"current"��ʽ
							.next().show() //��һ��Ԫ����ʾ
							.parent().siblings().children("a").removeClass(
									"current") //��Ԫ�ص��ֵ�Ԫ�ص���Ԫ��<a>�Ƴ�"current"��ʽ
							.next().hide(); //���ǵ���һ��Ԫ������
							return false;
						});

				$(".level2 > li a").click(function() {
							var selectname = $(this).children("input").val();
							$("#devid_status").val("offline");
							for(var i=1;i<8;i++)$("#dataid"+i).val("");
							for(var i=1;i<7;i++)$("#button"+i).css("background","#ADD8E6");
							$("#devid_select").val(selectname.substring(0, 8));
							Sendev('AAZ'); //send to dev request message add by jyc 20160511			
							$(this).addClass("current") //����ǰԪ�����"current"��ʽ
							.parent().siblings().children("a").removeClass(
									"current").next().hide(); //���ǵ���һ��Ԫ������ */
							return false;
						});
			});
</script>
</head>

<body background="image/DNA.jpg">
	<%
		String name = (String) session.getAttribute("userid");
		if (session.getAttribute("userid") == null) {
			response.sendRedirect("index.jsp");
			return;
		}
		//java.util.Date d = new java.util.Date();
		String datetime=new SimpleDateFormat("yyyy-MM-dd").format( new java.util.Date());
		//String name = request.getParameter("userName"); // ���ձ�����
		boolean value7 = false;
	%>

	<div id="Container">
		<div id="Header">
			<ul class="menul">
					<li class="levela" ><a onclick="href_new('user.jsp')" id="dis1" >���н���</a></li>
					<li class="levela" ><a onclick="href_new('search.jsp')" id='dis2'>���ݲ�ѯ</a></li>
					<li class="levela" ><a onclick="href_new('line.jsp')" id='dis3'>���ݷ���</a></li>
					<li class="levela" ><a onclick="href_new('video.jsp')" id='dis4'>��Ƶ</a></li>
					<li class="levela" ><a onclick="href_new('authority.jsp')" id='dis5'>�û�����</a></li>
					<li class="levela" ><a onclick="href_new('upgrade.jsp')" id='dis6'>Զ������</a></li>
					<li class="levela" ><a onclick="href_new('record.jsp')" id='dis7'>ժ¼</a></li>
					<li class="levela" ><a onclick="href_new('jiont.jsp')" id='dis8' style="background: #EDD8E6">�в�����</a></li>
					<li>�û�����<%=name%> ���ڣ�<%=datetime%></li>
			</ul>
		</div>
		<div id="Content">
		<div id="Content-Left">
				<ul class="menu">
					<li class="level1" ><a id='b'>�豸�б�</a>
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
			
<!-- 			<div id="Content-Main" >
				
			</div> -->

			<div id="Content-View">
				<div class="noscript">
					<h2 style="color: #ff0000">please upgrade web</h2>
				</div>
				<div>
					<p style="display:none">
						<input type="text" placeholder="type and press enter to chat"
							id="chat" />
					</p>
					<div id="console"></div>

				</div>
				
			</div>
			<div id="Content-Set">
				�豸״̬: <input type="text" id="devid_status" value="offline"
					style="width: 100px; height: 30px; margin:5px" readonly="readonly"/> <br />
				�豸���: <input type="text" id="devid_select"
					style="width: 100px; height: 30px; margin:5px" readonly="readonly"/> <br /> 
				����JSON: <textarea cols="5" id='jiontmessage'
					style="width: 500px; height: 300px; margin:5px"></textarea>

				<input class="call" type="submit" value="send" onclick="Sendev2('','jiontmessage')"
					style="width: 100px; height: 50px; margin:5px" /><br /> 
			</div>	
		</div>
		<!-- <div class="Clear">����������õ�float,���沼�ֿ�ʼǰ������һ�¡�</div> -->
		<div id="Footer">Footer</div>

	</div>

</body>











