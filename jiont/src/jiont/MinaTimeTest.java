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
		cc = new MinaTimeTest(new URI("ws://127.0.0.1:80/webtest/websocket/chat"), new Draft_17());
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
			
			String test1 = null;
			byte[] test;
			Map<String, Object> map = new LinkedHashMap<String, Object>(); 
			Map<String, String> list01 = new LinkedHashMap<String, String>();
			Map<String, String> list02 = new LinkedHashMap<String, String>();
			Map<String, String> list03 = new LinkedHashMap<String, String>();
			Map<String, String> list04 = new LinkedHashMap<String, String>();
			Map<String, String> list05 = new LinkedHashMap<String, String>();
			Map<String, String> list06 = new LinkedHashMap<String, String>();
			Map<String, String> list07 = new LinkedHashMap<String, String>();
			Map<String, String> list08 = new LinkedHashMap<String, String>();
			Map<String, String> list09 = new LinkedHashMap<String, String>();
			Map<String, String> list10 = new LinkedHashMap<String, String>();
			Map<String, String> list11 = new LinkedHashMap<String, String>();
			Map<String, String> list12 = new LinkedHashMap<String, String>();
			Map<String, String> list13 = new LinkedHashMap<String, String>();
			Map<String, String> list14 = new LinkedHashMap<String, String>();
			Map<String, String> list15 = new LinkedHashMap<String, String>();
			Map<String, String> list16 = new LinkedHashMap<String, String>();
			Map<String, String> list17 = new LinkedHashMap<String, String>();
			Map<String, String> list18 = new LinkedHashMap<String, String>();
			Map<String, String> list19 = new LinkedHashMap<String, String>();
			Map<String, String> list20 = new LinkedHashMap<String, String>();
			Map<String, String> list21 = new LinkedHashMap<String, String>();
			
			ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
			switch(action){
				case "alive":
					map.put( "sn", snrec );
					map.put( "action", "alive_reply" );	
				break;
				
				case "alive_req":
					map.put( "sn", snrec );
					map.put( "action", "alive_reply" );	
				break;
				
				case "normal_req":
					map.put( "sn", snrec );
					switch(anstype){
						case "202":
							map.put( "action", "update_form" );
							map.put( "display_no", anstype );
							map.put( "title", "只有一项作业项目,确认请打卡登记!" );
							map.put( "project_num", "1" );
							map.put( "loger_num", "2" );
							list01.put("index", "1");
							list01.put("color", "green");
							list01.put("text", "轧机区域F1主电机碳刷检查更换");
							list.add(list01);
							map.put("selects", list);
						break;						
						case "203":
							map.put( "action", "update_form" );
							map.put( "display_no", anstype );
							map.put( "title", "确认作业项目请打卡登记,不确认请选择!" );
							map.put( "project_num", "3" );
							map.put( "loger_num", "2" );
							list01.put("index", "1");
							list01.put("color", "green");
							list01.put("text", "轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "green");
							list02.put("text", "轧机区域F1主电机进线螺丝检查与紧固");
							list03.put("index", "3");
							list03.put("color", "green");
							list03.put("text", "轧机区域F1主电机背包冷却器检查与除尘");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);
						break;						
						case "204":
							map.put( "action", "update_form" );
							map.put( "display_no", anstype );
							map.put( "title", "确认作业项目请打卡登记,不确认请选择!" );
							map.put( "project_num", "1" );
							map.put( "loger_num", "2" );
							list01.put("index", "1");
							list01.put("color", "green");
							list01.put("text", "轧机区域F1主电机碳刷检查更换");
							list.add(list01);
							map.put("selects", list);
						break;				
						case "205":
							map.put( "action", "update_form" );
							map.put( "display_no", anstype );
							map.put( "title", "登记成功,请安全作业!" );
							map.put( "project_num", "1" );
							map.put( "loger_num", "2" );
							list01.put("index", "1");
							list01.put("color", "green");
							list01.put("text", "轧机区域F1主电机碳刷检查更换");
							list.add(list01);
							map.put("selects", list);
						break;
						case "206":
							map.put( "action", "update_form" );
							map.put( "display_no", anstype );
							map.put( "title", "登记无效,请勿越权操作!" );
							map.put( "project_num", "1" );
							map.put( "loger_num", "2" );
							list01.put("index", "1");
							list01.put("color", "blue");
							list01.put("text", "轧机区域F1主电机碳刷检查更换");
							list.add(list01);
							map.put("selects", list);
						break;
						case "207":
							map.put( "action", "update_form" );
							map.put( "display_no", anstype );
							map.put( "title", "请先复位异地作业登记,请规范操作!" );
							map.put( "project_num", "1" );
							map.put( "loger_num", "2" );
							list01.put("index", "1");
							list01.put("color", "blue");
							list01.put("text", "轧机区域F1主电机碳刷检查更换");
							list.add(list01);
							map.put("selects", list);
						break;
						case "208":
							map.put( "action", "update_form" );
							map.put( "display_no", anstype );
							map.put( "title", "复位完成,您辛苦了!" );
							map.put( "project_num", "1" );
							map.put( "loger_num", "2" );
							list01.put("index", "1");
							list01.put("color", "blue");
							list01.put("text", "轧机区域F1主电机碳刷检查更换");
							list.add(list01);
							map.put("selects", list);
						break;
						
						case "209":
							map.put( "action", "update_form" );
							map.put( "display_no", anstype );
							map.put( "color", "yellow" );
							map.put( "text", "没有作业项目,请规范操作!" );
							map.put( "textcolor", "red" );
						break;
						case "210":
							map.put( "action", "update_form" );
							map.put( "display_no", anstype );
							map.put( "color", "yellow" );
							map.put( "text", "点检登记成功!" );
							map.put( "textcolor", "red" );
						break;
						case "211":
							map.put( "action", "update_form" );
							map.put( "display_no", anstype );
							map.put( "color", "yellow" );
							map.put( "text", "登记无效,请勿越权操作!" );
							map.put( "textcolor", "red" );
						break;
						
						case "212":
							map.put( "action", "update_form" );
							map.put( "display_no", anstype );
							map.put( "title", "只有一个作业项目,不能选择,请规范操作!" );
							map.put( "project_num", "1" );
							map.put( "loger_num", "2" );
							list01.put("index", "1");
							list01.put("color", "green");
							list01.put("text", "轧机区域F1主电机碳刷检查更换");
							list.add(list01);
							map.put("selects", list);
						break;
					
						default:
						break;
					}
					
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
							list01.put("index", "1");
							list01.put("text1", "轧机");
							list02.put("index", "2");
							list02.put("text1", "接杆");
							list03.put("index", "3");
							list03.put("text1", "导下");
							list04.put("index", "4");
							list04.put("text1", "压下");
							list05.put("index", "5");
							list05.put("text1", "立轧机");
							list06.put("index", "6");
							list06.put("text1", "活套");
							list07.put("index", "7");
							list07.put("text1", "除尘");
							list08.put("index", "8");
							list08.put("text1", "除鳞");
							list09.put("index", "9");
							list09.put("text1", "测厚仪");
							list10.put("index", "10");
							list10.put("text1", "液压站");
							list11.put("index", "11");
							list11.put("text1", "小车、平台");
							list12.put("index", "12");
							list12.put("text1", "联舟");
							list13.put("index", "13");
							list13.put("text1", "联舟测试");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							list.add(list04);
							list.add(list05);
							list.add(list06);
							list.add(list07);
							list.add(list08);
							list.add(list09);
							list.add(list10);
							list.add(list11);
							list.add(list12);
							list.add(list13);
							map.put("selects", list);
							map.put("title", "请选择作业区域！");
						break;
						case "103":
							map.put( "action", "update_equi" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("text1", "F0主电机");
							list02.put("index", "2");
							list02.put("text1", "F1主电机");
							list03.put("index", "3");
							list03.put("text1", "F2主电机");
							list04.put("index", "4");
							list04.put("text1", "F3主电机");
							list05.put("index", "5");
							list05.put("text1", "F4主电机");
							list06.put("index", "6");
							list06.put("text1", "F5主电机");
							list07.put("index", "7");
							list07.put("text1", "F6主电机");
							list08.put("index", "8");
							list08.put("text1", "F1侧导板");
							list09.put("index", "9");
							list09.put("text1", "F2侧导板");
							list10.put("index", "10");
							list10.put("text1", "F3侧导板");
							list11.put("index", "11");
							list11.put("text1", "F4侧导板");
							list12.put("index", "12");
							list12.put("text1", "F5侧导板");
							list13.put("index", "13");
							list13.put("text1", "F6侧导板");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							list.add(list04);
							list.add(list05);
							list.add(list06);
							list.add(list07);
							list.add(list08);
							list.add(list09);
							list.add(list10);
							list.add(list11);
							list.add(list12);
							list.add(list13);
							map.put("selects", list);
							map.put("title", "轧机区域，请选择作业设备！");
						break;
						
						case "104-1":
							map.put( "action", "update_pro" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("text1", "主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("text1", "主电机进线螺丝检查与紧固");
							list03.put("index", "3");
							list03.put("text1", "主电机背包冷却器检查与除尘");
							list04.put("index", "4");
							list04.put("text1", "主电机传动装置检查");
							list05.put("index", "5");
							list05.put("text1", "主电机减速箱测温");
							list06.put("index", "6");
							list06.put("text1", "其他");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							list.add(list04);
							list.add(list05);
							list.add(list06);
							map.put("selects", list);
							map.put("title", "轧机区域F1主电机，请选择作业项目！");
						break;
						case "104-2":
							map.put( "action", "update_pro" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("text1", "主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("text1", "主电机进线螺丝检查与紧固");
							list03.put("index", "3");
							list03.put("text1", "主电机背包冷却器检查与除尘");
							list04.put("index", "4");
							list04.put("text1", "主电机传动装置检查");
							list05.put("index", "5");
							list05.put("text1", "主电机减速箱测温");
							list06.put("index", "6");
							list06.put("text1", "其他");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							list.add(list04);
							list.add(list05);
							list.add(list06);
							map.put("selects", list);
							map.put("title", "请选择作业项目！");
						break;
						
						case "105-1":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "green");
							list01.put("textcolor", "white");
							list01.put("text1", "申请作业项目:轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "yellow");
							list02.put("textcolor", "black");
							list02.put("text1", "请作业负责人打卡确认!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;
						case "105-2":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "申请作业项目:轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("text1", "项目已启动,请规范操作!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;
						case "105-3":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "green");
							list01.put("textcolor", "white");
							list01.put("text1", "申请作业项目:轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("text1", "选择无效,请勿越权操作!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;
											
						case "106-1":	
							map.put( "action", "update_sel" );
							map.put( "display_no", anstype );
							map.put( "title", "申请作业项目:轧机区域F1主电机碳刷检查更换" );
							map.put( "titlecolor", "green" );
							list01.put("index", "1");
							list01.put("color", "green");
							list01.put("text1", "F1高压开关");
							list01.put("text2", "请安全关闭!");
							list02.put("index", "2");
							list02.put("color", "green");
							list02.put("text1", "F1励磁进线电源");
							list02.put("text2", "请安全关闭!");
							list03.put("index", "3");
							list03.put("color", "green");
							list03.put("text1", "F1主回路接触器");
							list03.put("text2", "请安全关闭!");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);									
						break;
						case "106-2":	
							map.put( "action", "update_sel" );
							map.put( "display_no", anstype );
							map.put( "title", "申请作业项目:轧机区域F1主电机碳刷检查更换" );
							map.put( "titlecolor", "green" );
							list01.put("index", "1");
							list01.put("color", "green");
							list01.put("text1", "F1高压开关");
							list01.put("text2", "请安全关闭!");
							list02.put("index", "2");
							list02.put("color", "red");
							list02.put("text1", "F1励磁进线电源");
							list02.put("text2", "安全绑定完成!");
							list03.put("index", "3");
							list03.put("color", "green");
							list03.put("text1", "F1主回路接触器");
							list03.put("text2", "请安全关闭!");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);									
						break;
						case "106-3":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "green");
							list01.put("textcolor", "white");
							list01.put("text1", "申请作业项目:轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "yellow");
							list02.put("textcolor", "black");
							list02.put("text1", "请作业负责人打卡确认!");
							list03.put("index", "3");
							list03.put("color", "white");
							list03.put("textcolor", "red");
							list03.put("text1", "确认无效, 请勿 越权操作!");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);
						break;
						case "106-4":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "green");
							list01.put("textcolor", "white");
							list01.put("text1", "申请作业项目:轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "yellow");
							list02.put("textcolor", "black");
							list02.put("text1", "请作业负责人打卡确认!");
							list03.put("index", "3");
							list03.put("color", "white");
							list03.put("textcolor", "red");
							list03.put("text1", "确认无效, 请规范操作!");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);
						break;
						
						case "107":	
							map.put( "action", "update_sel" );
							map.put( "display_no", anstype );
							map.put( "title", "申请作业项目:轧机区域F1主电机碳刷检查更换" );
							map.put( "titlecolor", "green" );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("text1", "F1高压开关");
							list01.put("text2", "请确认!");
							list02.put("index", "2");
							list02.put("color", "red");
							list02.put("text1", "F1励磁进线电源");
							list02.put("text2", "请确认!");
							list03.put("index", "3");
							list03.put("color", "red");
							list03.put("text1", "F1主回路接触器");
							list03.put("text2", "请确认!");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);									
						break;
						
						case "108-1":
							map.put( "action", "update_top" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("count", "1");
							list01.put("color", "green");
							list01.put("textcolor", "white");
							list01.put("title1", "F1高压开关");
							list02.put("index", "2");
							list02.put("count", "1");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("title1", "请实施介质安全关闭!");
							list.add(list01);
							list.add(list02);
							map.put("titles", list);									
						break;
						case "108-2":
							map.put( "action", "update_top" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("count", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("title1", "F1高压开关");
							list02.put("index", "2");
							list02.put("count", "1");
							list02.put("color", "yellow");
							list02.put("textcolor", "black");
							list02.put("title1", "请实施介质安全关闭!");
							list.add(list01);
							list.add(list02);
							map.put("titles", list);									
						break;
						case "108-3":
							map.put( "action", "update_top" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("count", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("title1", "F1高压开关");
							list02.put("index", "2");
							list02.put("count", "1");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("title1", "已完成确认,请规范操作!");
							list.add(list01);
							list.add(list02);
							map.put("titles", list);									
						break;
						case "108-4":
							map.put( "action", "update_top" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("count", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("title1", "F1高压开关");
							list02.put("index", "2");
							list02.put("count", "1");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("title1", "已绑定完成,请规范操作!");
							list.add(list01);
							list.add(list02);
							map.put("titles", list);									
						break;
						case "109-1":
							map.put( "action", "update_top" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("count", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("title1", "F1高压开关");
							list02.put("index", "2");
							list02.put("count", "1");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("title1", "安全关闭确认成功!");
							list.add(list01);
							list.add(list02);
							map.put("titles", list);									
						break;
						case "109-2":
							map.put( "action", "update_top" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("count", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("title1", "F1高压开关");
							list02.put("index", "2");
							list02.put("count", "1");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("title1", "确认无效,请勿越权操作!");
							list.add(list01);
							list.add(list02);
							map.put("titles", list);									
						break;
						case "109-3":
							map.put( "action", "update_top" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("count", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("title1", "F1高压开关");
							list02.put("index", "2");
							list02.put("count", "1");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("title1", "确认无效,请规范操作!");
							list.add(list01);
							list.add(list02);
							map.put("titles", list);									
						break;
						
						case "110":	
							map.put( "action", "update_sel" );
							map.put( "display_no", anstype );
							map.put( "title", "申请作业项目:轧机区域F1主电机碳刷检查更换" );
							map.put( "titlecolor", "green" );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("text1", "F1高压开关");
							list01.put("text2", "安全绑定完成!");
							list02.put("index", "2");
							list02.put("color", "red");
							list02.put("text1", "F1励磁进线电源");
							list02.put("text2", "安全绑定完成!");
							list03.put("index", "3");
							list03.put("color", "red");
							list03.put("text1", "F1主回路接触器");
							list03.put("text2", "安全绑定完成!");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);									
						break;
						
						case "111-1":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "申请作业项目:轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("text1", "启动成功,请遵章作业,保障安全!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;
						case "111-2":
							map.put( "action", "update_top" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("count", "1");
							list01.put("color", "white");
							list01.put("textcolor", "red");
							list01.put("title1", "确认无效,请勿越权操作!");
							list.add(list01);
							map.put("titles", list);									
						break;
						case "111-3":
							map.put( "action", "update_top" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("count", "1");
							list01.put("color", "white");
							list01.put("textcolor", "red");
							list01.put("title1", "确认无效,请规范操作!");
							list.add(list01);
							map.put("titles", list);									
						break;
						
						case "112":
							map.put( "action", "update_pro" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("text1", "1、轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("text1", "2、轧机区域F1主电机进线螺丝检查与紧固");
							list03.put("index", "3");
							list03.put("text1", "3、轧机区域F1主电机背包冷却器检查与除尘");
							list04.put("index", "4");
							list04.put("text1", "4、轧机区域F1主电机传动装置检查");
							list05.put("index", "5");
							list05.put("text1", "5、轧机区域F1主电机减速箱测温");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							list.add(list04);
							list.add(list05);
							map.put("selects", list);
						break;
						
						case "113-1":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "撤销作业项目:轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "yellow");
							list02.put("textcolor", "black");
							list02.put("text1", "请作业负责人打卡确认!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;
						case "113-2":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "撤销作业项目:轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("text1", "选择无效,请勿越权操作!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;
						case "113-3":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "撤销作业项目:轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("text1", "有人作业,禁止撤销作业项目!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;
						case "113-4":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "撤销作业项目:轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "gray");
							list02.put("textcolor", "black");
							list02.put("text1", "1号终端登记器作业期间出现通讯故障");
							list03.put("index", "3");
							list03.put("color", "yellow");
							list03.put("textcolor", "black");
							list03.put("text1", "请作业负责人打卡确认作业人员安全离开!");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);
						break;
						
						case "114-1":	
							map.put( "action", "update_sel" );
							map.put( "display_no", anstype );
							map.put( "title", "撤销作业项目:轧机区域F1主电机碳刷检查更换" );
							map.put( "titlecolor", "red" );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("text1", "F1高压开关");
							list01.put("text2", "请复位!");
							list02.put("index", "2");
							list02.put("color", "red");
							list02.put("text1", "F1励磁进线电源");
							list02.put("text2", "请复位!");
							list03.put("index", "3");
							list03.put("color", "red");
							list03.put("text1", "F1主回路接触器");
							list03.put("text2", "请复位!");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);									
						break;
						case "114-2":	
							map.put( "action", "update_sel" );
							map.put( "display_no", anstype );
							map.put( "title", "撤销作业项目:轧机区域F1主电机碳刷检查更换" );
							map.put( "titlecolor", "red" );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("text1", "F1高压开关");
							list01.put("text2", "已撤销绑定!");
							list02.put("index", "2");
							list02.put("color", "red");
							list02.put("text1", "F1励磁进线电源");
							list02.put("text2", "请复位!");
							list03.put("index", "3");
							list03.put("color", "red");
							list03.put("text1", "F1主回路接触器");
							list03.put("text2", "请复位!");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);									
						break;
						case "114-3":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "撤销作业项目:轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "yellow");
							list02.put("textcolor", "black");
							list02.put("text1", "请作业负责人打卡确认!");
							list03.put("index", "3");
							list03.put("color", "white");
							list03.put("textcolor", "red");
							list03.put("text1", "确认无效,请勿越权操作!");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);
						break;
						case "114-4":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "撤销作业项目:轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "yellow");
							list02.put("textcolor", "black");
							list02.put("text1", "请作业负责人打卡确认!");
							list03.put("index", "3");
							list03.put("color", "white");
							list03.put("textcolor", "red");
							list03.put("text1", "确认无效,请规范操作!");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);
						break;
						case "114-5":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "撤销作业项目:轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "yellow");
							list02.put("textcolor", "black");
							list02.put("text1", "请作业负责人打卡确认作业人员安全离开!");
							list03.put("index", "3");
							list03.put("color", "white");
							list03.put("textcolor", "red");
							list03.put("text1", "确认无效,请勿越权操作!");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);
						break;
						case "114-6":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "撤销作业项目:轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "yellow");
							list02.put("textcolor", "black");
							list02.put("text1", "请作业负责人打卡确认作业人员安全离开!");
							list03.put("index", "3");
							list03.put("color", "white");
							list03.put("textcolor", "red");
							list03.put("text1", "确认无效,请规范操作!");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);
						break;
						
						case "115":	
							map.put( "action", "update_sel" );
							map.put( "display_no", anstype );
							map.put( "title", "撤销作业项目:轧机区域F1主电机碳刷检查更换" );
							map.put( "titlecolor", "red" );
							list01.put("index", "1");
							list01.put("color", "green");
							list01.put("text1", "F1高压开关");
							list01.put("text2", "请确认!");
							list02.put("index", "2");
							list02.put("color", "green");
							list02.put("text1", "F1励磁进线电源");
							list02.put("text2", "请确认!");
							list03.put("index", "3");
							list03.put("color", "green");
							list03.put("text1", "F1主回路接触器");
							list03.put("text2", "请确认!");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);									
						break;
						
						case "116-1":
							map.put( "action", "update_top" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("count", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("title1", "F1高压开关");
							list02.put("index", "2");
							list02.put("count", "1");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("title1", "请实施介质复位!");
							list.add(list01);
							list.add(list02);
							map.put("titles", list);									
						break;
						case "116-2":
							map.put( "action", "update_top" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("count", "1");
							list01.put("color", "green");
							list01.put("textcolor", "white");
							list01.put("title1", "F1高压开关");
							list02.put("index", "2");
							list02.put("count", "1");
							list02.put("color", "yellow");
							list02.put("textcolor", "black");
							list02.put("title1", "请实施人打卡确认!");
							list.add(list01);
							list.add(list02);
							map.put("titles", list);									
						break;
						case "116-3":
							map.put( "action", "update_top" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("count", "1");
							list01.put("color", "green");
							list01.put("textcolor", "white");
							list01.put("title1", "F1高压开关");
							list02.put("index", "2");
							list02.put("count", "1");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("title1", "已完成确认,请规范操作!");
							list.add(list01);
							list.add(list02);
							map.put("titles", list);									
						break;
						case "116-4":
							map.put( "action", "update_top" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("count", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("title1", "F1高压开关");
							list02.put("index", "2");
							list02.put("count", "1");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("title1", "已撤销绑定,请规范操作!");
							list.add(list01);
							list.add(list02);
							map.put("titles", list);									
						break;
						case "117-1":
							map.put( "action", "update_top" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("count", "1");
							list01.put("color", "green");
							list01.put("textcolor", "white");
							list01.put("title1", "F1高压开关");
							list02.put("index", "2");
							list02.put("count", "1");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("title1", "复位确认成功!");
							list.add(list01);
							list.add(list02);
							map.put("titles", list);									
						break;
						case "117-2":
							map.put( "action", "update_top" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("count", "1");
							list01.put("color", "green");
							list01.put("textcolor", "white");
							list01.put("title1", "F1高压开关");
							list02.put("index", "2");
							list02.put("count", "1");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("title1", "确认无效,请勿越权操作!");
							list.add(list01);
							list.add(list02);
							map.put("titles", list);									
						break;
						case "117-3":
							map.put( "action", "update_top" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("count", "1");
							list01.put("color", "green");
							list01.put("textcolor", "white");
							list01.put("title1", "F1高压开关");
							list02.put("index", "2");
							list02.put("count", "1");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("title1", "确认无效,请规范操作!");
							list.add(list01);
							list.add(list02);
							map.put("titles", list);									
						break;
						
						case "118":	
							map.put( "action", "update_sel" );
							map.put( "display_no", anstype );
							map.put( "title", "撤销作业项目:轧机区域F1主电机碳刷检查更换" );
							map.put( "titlecolor", "red" );
							list01.put("index", "1");
							list01.put("color", "green");
							list01.put("text1", "F1高压开关");
							list01.put("text2", "确认完成");
							list02.put("index", "2");
							list02.put("color", "green");
							list02.put("text1", "F1励磁进线电源");
							list02.put("text2", "确认完成");
							list03.put("index", "3");
							list03.put("color", "green");
							list03.put("text1", "F1主回路接触器");
							list03.put("text2", "确认完成");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);									
						break;
						
						case "119-1":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "green");
							list01.put("textcolor", "white");
							list01.put("text1", "撤销作业项目:轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("text1", "撤销成功!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;						
						case "119-2":
							map.put( "action", "update_top" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("count", "1");
							list01.put("color", "white");
							list01.put("textcolor", "red");
							list01.put("title1", "确认无效,请勿越权操作!");
							list.add(list01);
							map.put("titles", list);									
						break;
						case "119-3":
							map.put( "action", "update_top" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("count", "1");
							list01.put("color", "white");
							list01.put("textcolor", "red");
							list01.put("title1", "确认无效,请规范操作!");
							list.add(list01);
							map.put("titles", list);									
						break;
						
						case "120":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "gray");
							list01.put("textcolor", "black");
							list01.put("text1", "01号终端登记器通讯故障!");
							list02.put("index", "2");
							list02.put("color", "yellow");
							list02.put("textcolor", "black");
							list02.put("text1", "请岗位操作人员打卡确认!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;
						case "121-1":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "gray");
							list01.put("textcolor", "black");
							list01.put("text1", "01号终端登记器通讯故障!");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("text1", "确认成功!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;
						case "121-2":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "gray");
							list01.put("textcolor", "black");
							list01.put("text1", "01号终端登记器通讯故障!");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("text1", "确认无效,请勿越权操作!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;
						case "122":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "gray");
							list01.put("textcolor", "black");
							list01.put("text1", "01号终端登记器通讯故障!");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("text1", "确认无效,请规范操作!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;
						case "123":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "gray");
							list01.put("textcolor", "black");
							list01.put("text1", "上位机通讯故障!");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("text1", "请检查!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;
						
						case "124":
							map.put( "action", "system" );
							map.put( "display_no", anstype );
						break;
						case "125-1":
							map.put( "action", "update_pro" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("text1", "1、轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("text1", "2、轧机区域F1主电机进线螺丝检查与紧固");
							list03.put("index", "3");
							list03.put("text1", "3、轧机区域F1主电机背包冷却器检查与除尘");
							list04.put("index", "4");
							list04.put("text1", "4、轧机区域F1主电机传动装置检查");
							list05.put("index", "5");
							list05.put("text1", "5、轧机区域F1主电机减速箱测温");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							list.add(list04);
							list.add(list05);
							map.put("selects", list);
						break;
						case "125-2":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "blue");
							list01.put("textcolor", "yellow");
							list01.put("text1", "作业项目查询");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("text1", "没有作业项目启动!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;
						case "126-1":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "red");
							list02.put("textcolor", "white");
							list02.put("text1", "01号终端登记器");
							list03.put("index", "3");
							list03.put("color", "white");
							list03.put("textcolor", "black");
							list03.put("text1", "作业登记人员:***(工种),***(工种),***(工种)等5人");
							list04.put("index", "4");
							list04.put("color", "white");
							list04.put("textcolor", "black");
							list04.put("text1", "作业启动时间:2016-07-05 15:20");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							list.add(list04);
							map.put("selects", list);
						break;
						case "126-2":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "red");
							list02.put("textcolor", "white");
							list02.put("text1", "01号终端登记器");
							list03.put("index", "3");
							list03.put("color", "white");
							list03.put("textcolor", "black");
							list03.put("text1", "作业人员登记已全部复位!");
							list04.put("index", "4");
							list04.put("color", "white");
							list04.put("textcolor", "black");
							list04.put("text1", "作业启动时间:2016-07-05 15:20");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							list.add(list04);
							map.put("selects", list);
						break;
						case "127-1":
							map.put( "action", "update_pro" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("text1", "1、F1高压开关");
							list02.put("index", "2");
							list02.put("text1", "2、F1励磁进线电源");
							list03.put("index", "3");
							list03.put("text1", "3、F1主回路接触器");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);
						break;
						case "127-2":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "blue");
							list01.put("textcolor", "yellow");
							list01.put("text1", "介质状态查询");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("text1", "全部介质复位状态!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;
						case "128":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "F1高压开关");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "black");
							list02.put("text1", "介质实施人:***");
							list03.put("index", "3");
							list03.put("color", "white");
							list03.put("textcolor", "black");
							list03.put("text1", "绑定项目1:轧机区域F1主电机碳刷检查更换");
							list04.put("index", "4");
							list04.put("color", "white");
							list04.put("textcolor", "black");
							list04.put("text1", "绑定项目2:***");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							list.add(list04);
							map.put("selects", list);
						break;
						case "129":
							map.put( "action", "system" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "01号终端登记机");
							list02.put("index", "2");
							list02.put("color", "green");
							list02.put("textcolor", "white");
							list02.put("text1", "02号终端登记机");
							list03.put("index", "3");
							list03.put("color", "green");
							list03.put("textcolor", "white");
							list03.put("text1", "03号终端登记机");
							list04.put("index", "4");
							list04.put("color", "green");
							list04.put("textcolor", "white");
							list04.put("text1", "04号终端登记机");
							list05.put("index", "5");
							list05.put("color", "green");
							list05.put("textcolor", "white");
							list05.put("text1", "05号终端登记机");
							list06.put("index", "6");
							list06.put("color", "green");
							list06.put("textcolor", "white");
							list06.put("text1", "06号终端登记机");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							list.add(list04);
							list.add(list05);
							list.add(list06);
							map.put("selects", list);
						break;
						case "130-1":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "01号终端登记器");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "black");
							list02.put("text1", "位置:轧机区域东2");
							list03.put("index", "3");
							list03.put("color", "white");
							list03.put("textcolor", "black");
							list03.put("text1", "作业项目1:F1主电机碳刷检查更换");
							list04.put("index", "4");
							list04.put("color", "white");
							list04.put("textcolor", "black");
							list04.put("text1", "作业项目2:F1主电机进线螺丝检查与紧固");
							list05.put("index", "5");
							list05.put("color", "white");
							list05.put("textcolor", "black");
							list05.put("text1", "作业项目3:F1主电机背包冷却器检查与除尘");
							list06.put("index", "6");
							list06.put("color", "white");
							list06.put("textcolor", "black");
							list06.put("text1", "作业项目4:F1主电机主电机传动装置检查");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							list.add(list04);
							list.add(list05);
							list.add(list06);
							map.put("selects", list);
						break;
						case "130-2":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "blue");
							list01.put("textcolor", "yellow");
							list01.put("text1", "01号终端登记器");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "black");
							list02.put("text1", "轧机区域东2");
							list03.put("index", "3");
							list03.put("color", "white");
							list03.put("textcolor", "red");
							list03.put("text1", "没有作业项目启动!");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);
						break;
						case "130-3":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "gray");
							list01.put("textcolor", "black");
							list01.put("text1", "01号终端登记器通讯故障!");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "black");
							list02.put("text1", "确认人:***");
							list03.put("index", "3");
							list03.put("color", "white");
							list03.put("textcolor", "black");
							list03.put("text1", "故障发生时间:2016-07-05 15:20");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);
						break;
						case "131":
							map.put( "action", "update_area" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("text1", "轧机");
							list02.put("index", "2");
							list02.put("text1", "接杆");
							list03.put("index", "3");
							list03.put("text1", "导下");
							list04.put("index", "4");
							list04.put("text1", "压下");
							list05.put("index", "5");
							list05.put("text1", "立轧机");
							list06.put("index", "6");
							list06.put("text1", "活套");
							list07.put("index", "7");
							list07.put("text1", "除尘");
							list08.put("index", "8");
							list08.put("text1", "除鳞");
							list09.put("index", "9");
							list09.put("text1", "测厚仪");
							list10.put("index", "10");
							list10.put("text1", "液压站");
							list11.put("index", "11");
							list11.put("text1", "小车、平台");
							list12.put("index", "12");
							list12.put("text1", "其他");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							list.add(list04);
							list.add(list05);
							list.add(list06);
							list.add(list07);
							list.add(list08);
							list.add(list09);
							list.add(list10);
							list.add(list11);
							list.add(list12);
							map.put("selects", list);
							map.put("title", "请选择查询区域!");
						break;
						case "132":
							map.put( "action", "update_pro" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("text1", "F0主电机|1号|轧机东1-1");
							list02.put("index", "2");
							list02.put("text1", "F1主电机|1号|轧机东1-1");
							list03.put("index", "3");
							list03.put("text1", "F2主电机|2号|轧机东1-2");
							list04.put("index", "4");
							list04.put("text1", "F3主电机|2号|轧机东1-3");
							list05.put("index", "5");
							list05.put("text1", "F4主电机|3号|轧机东1-4");
							list06.put("index", "6");
							list06.put("text1", "F4主电机|3号|轧机东1-4");
							list07.put("index", "7");
							list07.put("text1", "F4主电机|3号|轧机南1-1");
							list08.put("index", "8");
							list08.put("text1", "F5主电机|4号|轧机南1-1");
							list09.put("index", "9");
							list09.put("text1", "F6主电机|4号|轧机南1-2");
							list10.put("index", "10");
							list10.put("text1", "F7主电机|5号|轧机西1-1");
							list11.put("index", "11");
							list11.put("text1", "F8主电机|5号|轧机西1-1");
							list12.put("index", "12");
							list12.put("text1", "F9主电机|6号|轧机北1-1");
							list13.put("index", "13");
							list13.put("text1", "F10主电机|6号|轧机北1-1");
							list14.put("index", "14");
							list14.put("text1", "F11主电机|6号|轧机北1-1");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							list.add(list04);
							list.add(list05);
							list.add(list06);
							list.add(list07);
							list.add(list08);
							list.add(list09);
							list.add(list10);
							list.add(list11);
							list.add(list12);
							list.add(list13);
							list.add(list14);
							map.put("selects", list);
						break;
						case "133":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "blue");
							list01.put("textcolor", "yellow");
							list01.put("text1", "标签身份查询");
							list02.put("index", "2");
							list02.put("color", "yellow");
							list02.put("textcolor", "blue");
							list02.put("text1", "请在用户确认键打卡查询!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;
						
						case "134-1":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "blue");
							list01.put("textcolor", "yellow");
							list01.put("text1", "标签身份查询");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "black");
							list02.put("text1", "ID:***");
							list03.put("index", "3");
							list03.put("color", "white");
							list03.put("textcolor", "black");
							list03.put("text1", "姓名:***   工号:***");
							list04.put("index", "4");
							list04.put("color", "white");
							list04.put("textcolor", "black");
							list04.put("text1", "单位:***   部门:***");
							list05.put("index", "5");
							list05.put("color", "white");
							list05.put("textcolor", "black");
							list05.put("text1", "职务:***   工种:***");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							list.add(list04);
							list.add(list05);
							map.put("selects", list);
						break;
						case "134-2":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "blue");
							list01.put("textcolor", "yellow");
							list01.put("text1", "标签身份查询");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("text1", "没有标签信息,请联系管理人员!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;
						case "134-3":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "blue");
							list01.put("textcolor", "yellow");
							list01.put("text1", "标签身份查询");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("text1", "请在用户确认键打卡,请规范操作!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;
						case "135-1":
							map.put( "action", "update_pro" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("text1", "1、轧机区域F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("text1", "2、轧机区域F1主电机进线螺丝检查与紧固");
							list03.put("index", "3");
							list03.put("text1", "3、轧机区域F1主电机背包冷却器检查与除尘");
							list04.put("index", "4");
							list04.put("text1", "4、轧机区域F1主电机传动装置检查");
							list05.put("index", "5");
							list05.put("text1", "5、轧机区域F1主电机减速箱测温");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							list.add(list04);
							list.add(list05);
							map.put("selects", list);
						break;
						case "135-2":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "blue");
							list01.put("textcolor", "yellow");
							list01.put("text1", "复位作业人员登记");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("text1", "没有作业项目启动,请规范操作!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;
						
						case "136-1":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "复位作业人员登记:电工F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "yellow");
							list02.put("textcolor", "black");
							list02.put("text1", "请检修负责人打卡确认!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;
						case "136-2":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "复位作业人员登记:电工F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "white");
							list02.put("textcolor", "red");
							list02.put("text1", "作业人员登记已全部复位,请规范操作!");
							list.add(list01);
							list.add(list02);
							map.put("selects", list);
						break;		
						case "137-1":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "复位作业人员登记:电工F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "yellow");
							list02.put("textcolor", "black");
							list02.put("text1", "请检修负责人打卡确认!");
							list03.put("index", "3");
							list03.put("color", "white");
							list03.put("textcolor", "red");
							list03.put("text1", "确认成功!");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);
						break;
						case "137-2":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "复位作业人员登记:电工F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "yellow");
							list02.put("textcolor", "black");
							list02.put("text1", "请检修负责人打卡确认!");
							list03.put("index", "3");
							list03.put("color", "white");
							list03.put("textcolor", "red");
							list03.put("text1", "确认无效,请勿越权操作!");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);
						break;
						case "137-3":
							map.put( "action", "display_form" );
							map.put( "display_no", anstype );
							list01.put("index", "1");
							list01.put("color", "red");
							list01.put("textcolor", "white");
							list01.put("text1", "复位作业人员登记:电工F1主电机碳刷检查更换");
							list02.put("index", "2");
							list02.put("color", "yellow");
							list02.put("textcolor", "black");
							list02.put("text1", "请检修负责人打卡确认!");
							list03.put("index", "3");
							list03.put("color", "white");
							list03.put("textcolor", "red");
							list03.put("text1", "确认无效,请规范操作!");
							list.add(list01);
							list.add(list02);
							list.add(list03);
							map.put("selects", list);
						break;
					
						default:
						break;
					}
				break;	
				default:
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
