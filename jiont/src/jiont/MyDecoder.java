package jiont;

import org.apache.mina.core.buffer.IoBuffer;
import org.apache.mina.core.session.IoSession;
import org.apache.mina.filter.codec.CumulativeProtocolDecoder;
import org.apache.mina.filter.codec.ProtocolDecoderOutput;

public class MyDecoder extends CumulativeProtocolDecoder {

	@Override
	protected boolean doDecode(IoSession session, IoBuffer in, ProtocolDecoderOutput out) throws Exception {

		int length = in.limit();
		
		//byte[] rtid = new byte[8];
		//in.get(rtid);
		//byte[] num = new byte[2];
		//in.get(num);
		//byte command = in.get();	
		byte[] bytes = new byte[length];
		in.get(bytes);
		
		// GET MESSAGE STRUCT JYC20160226
		MyMessage msg = new MyMessage();
		//msg.setrtid(rtid);
		//msg.setnum(num);
		//msg.setCommand(command);
		msg.setContents(bytes);
		out.write(msg);
		return true;
	}
}
