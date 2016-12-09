package jiont;

import java.io.IOException;

import java.net.InetSocketAddress;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;
//import java.util.HashMap;
import java.util.Set;
//import java.util.TreeMap;
import java.util.ArrayList;
import java.util.Collections;


import org.apache.mina.core.service.IoAcceptor;
import org.apache.mina.core.service.IoHandlerAdapter;
import org.apache.mina.core.session.IdleStatus;
import org.apache.mina.core.session.IoSession;
import org.apache.mina.filter.codec.ProtocolCodecFilter;
import org.apache.mina.filter.logging.LoggingFilter;
import org.apache.mina.transport.socket.nio.NioSocketAcceptor;

import java.net.URI;
import java.net.URISyntaxException;
import java.text.SimpleDateFormat;

import org.java_websocket.client.WebSocketClient;
import org.java_websocket.drafts.Draft;
import org.java_websocket.drafts.Draft_17;
import org.java_websocket.handshake.ServerHandshake;

import net.sf.json.JSONObject;

public class MinaTimeTest extends WebSocketClient {

	private final static Set<IoSession> sessions = Collections.synchronizedSet(new HashSet<IoSession>());
	static MinaTimeTest cc;
	private static final int PORTD = 10008;
	private static String anstype = "104-1";
	
	public MinaTimeTest(URI serverUri, Draft draft) {
		super(serverUri, draft);
	}

	public MinaTimeTest(URI serverURI) {
		super(serverURI);
	}

	public static void sendmessage(MyMessage message,byte[] dealrtid) {
		String rtid = new String(dealrtid);
		synchronized (sessions) {
			for (IoSession session : sessions) {
				if (session.containsAttribute(rtid)) {
					session.write(message);
				}
			}
		}
	}

	@Override
	public void onOpen(ServerHandshake handshakedata) {
		System.out.println("opened connection");
		// if you plan to refuse connection based on ip or httpfields overload:
		// onWebsocketHandshakeReceivedAsClient
	}

	@Override
	public void onMessage(String message) {

		if (message.indexOf(":") > 0) { /* jyc20160227 */
			String[] str2 = message.split(":",2); //jyc20160519 modify
			byte[] dealrtid = str2[0].getBytes(); 
			byte[] dealcontent = str2[1].getBytes();
			int str_len=str2[1].length();
			if(str2[1].substring(0, 3).equals("SEL")){
				anstype = str2[1].substring(3,str_len);
			}
			MyMessage wsmsg = new MyMessage(); /* jyc20151125 */
			wsmsg.setContents(dealcontent);
			sendmessage(wsmsg,dealrtid);			
		}
		System.out.println("received: " + message);
	}

	/*
	 * @Override public void onFragment( Framedata fragment ) {
	 * System.out.println( "received fragment: " + new String(
	 * fragment.getPayloadData().array() ) ); }
	 */

	@Override
	public void onClose(int code, String reason, boolean remote) {
		// The codecodes are documented in class
		// org.java_websocket.framing.CloseFrame
		System.out.println("Connection closed by " + (remote ? "remote peer" : "us"));
	}

	@Override
	public void onError(Exception ex) {
		ex.printStackTrace();
		// if the error is fatal then onClose will be called additionally
	}

	static void throw2() throws URISyntaxException {
		cc = new MinaTimeTest(new URI("ws://127.0.0.1:8080/webtest/websocket/chat"), new Draft_17());
		cc.connect();
		System.out.println("Inside throw2.");
		// throw new URISyntaxException("demo"); /*need understand jyc20160110*/
	}

	static void throw1() throws IOException {
		// 首先，我们为服务端创建IoAcceptor，NioSocketAcceptor是基于NIO的服务端监听器
		IoAcceptor acceptor = new NioSocketAcceptor();

		ProtocolCodecFilter coderFilter =
		// 使用自定义的编码解码filter
		new ProtocolCodecFilter(new MyCodeFactory());

		// 接着，如结构图示，在Acceptor和IoHandler之间将设置一系列的Fliter
		// 包括记录过滤器和编解码过滤器。其中TextLineCodecFactory是mina自带的文本解编码器
		acceptor.getFilterChain().addLast("logger", new LoggingFilter());

		acceptor.getFilterChain().addLast("codec", coderFilter);

		// 配置事务处理Handler，将请求转由TimeServerHandler处理。
		// acceptor.setHandler((IoHandler) new TimeServerHandler());
		acceptor.setHandler(new TimeServerHandler());
		// 配置Buffer的缓冲区大小
		acceptor.getSessionConfig().setReadBufferSize(2048);
		// 设置等待时间，每隔IdleTime将调用一次handler.sessionIdle()方法
		acceptor.getSessionConfig().setIdleTime(IdleStatus.BOTH_IDLE, 10);
		// 绑定端口
		acceptor.bind(new InetSocketAddress(PORTD));

		System.out.println("Inside throw1.");
	}

	/* public static void main(String[] args) throws IOException { */
	public static void main(String[] args) {
		try {
			throw2();
		} catch (URISyntaxException e) {
			System.out.println("Caught " + e);
		}
		try {
			throw1();
		} catch (IOException e) {
			System.out.println("Caught " + e);
		}
	}

	static class TimeServerHandler extends IoHandlerAdapter {
		/*
		 * private final Set<IoSession> sessions =
		 * Collections.synchronizedSet(new HashSet<IoSession>());
		 */

		public void exceptionCaught(IoSession session, Throwable cause) throws Exception {
			cause.printStackTrace();
			session.close(true);
		}

		public void messageReceived(IoSession session, Object message) throws Exception {

			MyMessage msg = (MyMessage) message;
			String rtid = "TW001828";
		
			String msgcont = new String(msg.getContents());		
			String str = "tran:" + rtid + ":" + msgcont; //jyc20160323
			//boolean session_flag=false;
			//cc.send(str);
			
			sessions.add(session);
			session.setAttribute(rtid);
			
			JSONObject jbrec = JSONObject.fromObject(msgcont);
			JSONObject jbsend = null;
			String snrec = jbrec.getString("sn");
			String action = jbrec.getString("action");
			if (action.equals("normal")) {
				String display_no = jbrec.getString("display_no");
				String select_no = jbrec.getString("select_no");
				String rfid = jbrec.getString("id");
				String back_btn = jbrec.getString("back_btn");
				String cannel_btn = jbrec.getString("cannel_btn");
			}
			
			String test1 = null;
			byte[] test;
			Map<String, Object> map = new LinkedHashMap<String, Object>(); 
			Map<String, String> a = new LinkedHashMap<String, String>();
			Map<String, String> b = new LinkedHashMap<String, String>();
			ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
			switch(action){
				case "alive":
					map.put( "sn", snrec );
					map.put( "action", "alive_reply" );	
				break;
				
				case "normal":
					map.put( "sn", snrec );
					switch(anstype){
						case "100-3":
							map.put( "action", "display_normal" );
							map.put( "display_no", anstype );
						break;
						case "100-2":
							map.put( "action", "display_normal" );
							map.put( "display_no", anstype );
						break;
						case "101":
							map.put( "action", "display_normal" );
							map.put( "display_no", anstype );
						break;
						case "102":
							map.put( "action", "update_area" );
							map.put( "display_no", anstype );
							a.put("index", "1");
							a.put("text1", "具体内容1");
							b.put("index", "2");
							b.put("text1", "具体内容2");
							list.add(a);
							list.add(b);
							map.put("selects", list);
						break;
						case "103":
							map.put( "action", "update_equi" );
							map.put( "display_no", anstype );
							a.put("index", "1");
							a.put("text1", "具体内容3");
							b.put("index", "2");
							b.put("text1", "具体内容4");
							list.add(a);
							list.add(b);
							map.put("selects", list);
						break;
						
						case "104-1":
							map.put( "action", "update_pro" );
							map.put( "display_no", anstype );
							a.put("index", "1");
							a.put("text1", "具体内容5");
							b.put("index", "2");
							b.put("text1", "具体内容6");
							list.add(a);
							list.add(b);
							map.put("selects", list);
						break;
						case "104-2":
							map.put( "action", "update_pro" );
							map.put( "display_no", anstype );
							a.put("index", "1");
							a.put("text1", "具体内容7");
							b.put("index", "2");
							b.put("text1", "具体内容8");
							list.add(a);
							list.add(b);
							map.put("selects", list);
						break;
						
						case "105-1":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							a.put("index", "1");
							a.put("color", "red");
							a.put("textcolor", "white");
							a.put("text1", "具体内容9");
							b.put("index", "2");
							b.put("color", "red");
							b.put("textcolor", "white");
							b.put("text1", "具体内容10");
							list.add(a);
							list.add(b);
							map.put("selects", list);
						break;
						case "105-2":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							a.put("index", "1");
							a.put("color", "red");
							a.put("textcolor", "white");
							a.put("text1", "具体内容11");
							b.put("index", "2");
							b.put("color", "red");
							b.put("textcolor", "white");
							b.put("text1", "具体内容12");
							list.add(a);
							list.add(b);
							map.put("selects", list);
						break;
						case "105-3":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							a.put("index", "1");
							a.put("color", "red");
							a.put("textcolor", "white");
							a.put("text1", "具体内容13");
							b.put("index", "2");
							b.put("color", "red");
							b.put("textcolor", "white");
							b.put("text1", "具体内容14");
							list.add(a);
							list.add(b);
							map.put("selects", list);
						break;
						case "106-3":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							a.put("index", "1");
							a.put("color", "red");
							a.put("textcolor", "white");
							a.put("text1", "具体内容15");
							b.put("index", "2");
							b.put("color", "red");
							b.put("textcolor", "white");
							b.put("text1", "具体内容16");
							list.add(a);
							list.add(b);
							map.put("selects", list);
						break;
						
						case "106-1":	
							map.put( "action", "update_sel" );
							map.put( "display_no", anstype );
							map.put( "title", "具体内容51" );
							map.put( "titlecolor", "green" );
							a.put("index", "1");
							a.put("color", "green");
							a.put("text1", "具体内容17");
							a.put("text2", "提示内容1");
							b.put("index", "2");
							b.put("color", "red");
							b.put("text1", "具体内容18");
							b.put("text2", "提示内容2");
							list.add(a);
							list.add(b);
							map.put("selects", list);									
						break;
						case "106-2":	
							map.put( "action", "update_sel" );
							map.put( "display_no", anstype );
							map.put( "title", "具体内容52" );
							map.put( "titlecolor", "red" );
							a.put("index", "1");
							a.put("color", "green");
							a.put("text1", "具体内容17");
							a.put("text2", "提示内容1");
							b.put("index", "2");
							b.put("color", "red");
							b.put("text1", "具体内容18");
							b.put("text2", "提示内容2");
							list.add(a);
							list.add(b);
							map.put("selects", list);									
						break;
						case "107":	
							map.put( "action", "update_sel" );
							map.put( "display_no", anstype );
							map.put( "title", "具体内容53" );
							map.put( "titlecolor", "green" );
							a.put("index", "1");
							a.put("color", "green");
							a.put("text1", "具体内容17");
							a.put("text2", "提示内容1");
							b.put("index", "2");
							b.put("color", "red");
							b.put("text1", "具体内容18");
							b.put("text2", "提示内容2");
							list.add(a);
							list.add(b);
							map.put("selects", list);									
						break;
						
						case "108-1":
							map.put( "action", "update_top" );
							map.put( "display_no", anstype );
							a.put("index", "1");
							a.put("count", "2");
							a.put("color", "green");
							a.put("textcolor", "white");
							a.put("title1", "具体内容19");
							a.put("title2", "具体内容20");
							b.put("index", "2");
							b.put("count", "2");
							b.put("color", "yellow");
							b.put("textcolor", "blue");
							b.put("title1", "具体内容21");
							b.put("title2", "具体内容22");
							list.add(a);
							list.add(b);
							map.put("titles", list);									
						break;
					}
				break;				
			}
			jbsend = JSONObject.fromObject( map );
			test1 = jbsend.toString();
			String datetime=new SimpleDateFormat("HH:mm:ss").format( new java.util.Date());
			cc.send(str + "<--->" +test1+"---"+datetime);
			//cc.send(">>"+test1);
			test = test1.getBytes("gb2312");
			msg.setContents(test);
/*			String test1 = jbrec.toString();
			byte[] test= test1.getBytes();
			msg.setContents(test);*/			
			session.write(msg);
		}

		public void sessionIdle(IoSession session, IdleStatus status) throws Exception {
			// System.out.println("IDLE " + session.getIdleCount(status));
		}
	}
}
