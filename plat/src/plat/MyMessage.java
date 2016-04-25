package plat;

import java.io.Serializable;

public class MyMessage implements Serializable {
	/****/
	private static final long serialVersionUID = 5570201892267872279L;
	private byte command; //cmd
	private byte[] rtid; //id
	private byte[] num; //number
	private byte[] contents;//message

	public byte[] getrtid() {
		return rtid;
	}

	public void setrtid(byte[] rtid) {
		this.rtid = rtid;
	}
	
	public byte[] getnum() {
		return num;
	}

	public void setnum(byte[] num) {
		this.num = num;
	}
	
	public byte getCommand() {
		return command;
	}

	public void setCommand(byte command) {
		this.command = command;
	}
	

	public byte[] getContents() {
		return contents;
	}

	public void setContents(byte[] contents) {
		this.contents = contents;
	}

	public short length() {
		return (short) contents.length;
	}
}
