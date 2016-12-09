package jiont;

import org.apache.mina.core.buffer.IoBuffer;
import org.apache.mina.core.session.IoSession;
import org.apache.mina.filter.codec.ProtocolEncoder;
import org.apache.mina.filter.codec.ProtocolEncoderOutput;

public class MyEncoder implements ProtocolEncoder {
	@Override
	public void encode(IoSession session, Object message, ProtocolEncoderOutput out) throws Exception {
		MyMessage msg = (MyMessage) message;
		IoBuffer buffer = IoBuffer.allocate(1024);
		buffer.setAutoExpand(true);
		//buffer.putShort((short) (msg.length() + 9));
		//buffer.put(msg.getrtid());
		//buffer.put(msg.getnum());
		//buffer.put(msg.getCommand());		
		buffer.put(msg.getContents());
		buffer.flip();

		out.write(buffer);
	}

	@Override
	public void dispose(IoSession session) throws Exception {

	}
}
