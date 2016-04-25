package plat;

import java.io.IOException;

import java.net.InetSocketAddress;
import java.util.HashSet;
import java.util.Set;
import java.util.Calendar;
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

public class MinaTimeTest extends WebSocketClient {

	private final static Set<IoSession> sessions = Collections.synchronizedSet(new HashSet<IoSession>());
	static MinaTimeTest cc;
	private static final int PORTD = 10002;

	public MinaTimeTest(URI serverUri, Draft draft) {
		super(serverUri, draft);
	}

	public MinaTimeTest(URI serverURI) {
		super(serverURI);
	}

	public static void sendmessage(MyMessage message) {
		String rtid = new String(message.getrtid());
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
			String[] str2 = message.split(":");
			byte[] dealrtid = str2[0].getBytes(); 
			byte[] dealnum = {0,0}; //jyc20160310
			byte[] dealcontent = str2[1].getBytes();
			MyMessage wsmsg = new MyMessage(); /* jyc20151125 */
			wsmsg.setrtid(dealrtid);
			wsmsg.setnum(dealnum);
			wsmsg.setContents(dealcontent);
			sendmessage(wsmsg);			
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
			byte[] msgrtid = msg.getrtid();
			String rtid = new String(msgrtid);
			String cnum = new String(msg.getnum());
			String ctypedevid = "0"+rtid.substring(5,8);
			
			String msgcont = new String(msg.getContents());		
			//String str = "tran:" + rtid.substring(0,5) + ":" + msgcont;	
			String str = "tran:" + rtid + ":" + msgcont; //jyc20160323
			byte upcmd = msg.getCommand();

			if (upcmd == 0x07) {
				session.close(false);
				return;
			}
			if (upcmd == 0x3a) {
				cc.send(str);
			}
			// String user = (String) session.getAttribute("user");
			sessions.add(session);
			// session.setAttribute("user", user);

			//int port = ((InetSocketAddress) session.getLocalAddress()).getPort();
			session.setAttribute(rtid);

			MySQLcode h = new MySQLcode();
			h.connSQL();

			String datetime=new SimpleDateFormat("yyyy-MM-dd:HH-mm-ss").format( new java.util.Date());
			String[] str5 = datetime.split(":");
			String cdate = str5[0];
			String ctime = str5[1];
			String cyear = cdate.substring(0,4);
			
			String tbname = rtid.substring(0, 5) + "_" + cyear;

			String insert = "insert into " + tbname + "(cmd,num,date,time,typedevid,message) "
					+ "values(" + upcmd + ",'" + cnum + "','" + cdate + "','" + ctime + "','"+ ctypedevid +"','" + msgcont + "')";
			if (h.insertSQL(insert) == true) {
				System.out.println("insert successfully");
			}
			// h.deconnSQL();
			session.write(message);
		}

		public void sessionIdle(IoSession session, IdleStatus status) throws Exception {
			// System.out.println("IDLE " + session.getIdleCount(status));
		}
	}
}
