/*
 *  Licensed to the Apache Software Foundation (ASF) under one or more
 *  contributor license agreements.  See the NOTICE file distributed with
 *  this work for additional information regarding copyright ownership.
 *  The ASF licenses this file to You under the Apache License, Version 2.0
 *  (the "License"); you may not use this file except in compliance with
 *  the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.*/

package com.websocket.chat;

import java.io.IOException;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.concurrent.atomic.AtomicInteger;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.apache.juli.logging.Log;
import org.apache.juli.logging.LogFactory;

import util.HTMLFilter;

@ServerEndpoint(value = "/websocket/chat")
public class ChatAnnotation {

	private static final Log log = LogFactory.getLog(ChatAnnotation.class);

	private static final String GUEST_PREFIX = "G"/* "Guest" */;
	private static final AtomicInteger connectionIds = new AtomicInteger(0);
	private static final Set<ChatAnnotation> connections = new CopyOnWriteArraySet<ChatAnnotation>();

	// private final String nickname;
	private String nickname;
	private Session session;

	public ChatAnnotation() {
		/*
		 * //String name = request.getParameter("userName") ; String name =
		 * Request.getParameter("userName"); nickname = name;
		 */

		nickname = GUEST_PREFIX + connectionIds.getAndIncrement();
	}

	@OnOpen
	public void start(Session session) {
		this.session = session;
		connections.add(this);
		String message = String.format("* %s %s", nickname, "has joined.");
		broadcast(message);
	}

	@OnClose
	public void end() {
		connections.remove(this);
		String message = String.format("* %s %s", nickname, "has disconnected.");
		broadcast(message);
	}

	@OnMessage
	public void incoming(String message) {
		// Never trust the client
		String[] s1 = message.split(":",3); // from to message
		/*
		 * String s11 = s1[1]; String s12 = s1[2]; String transfer = "tran";
		 */
		nickname = s1[0];

		if (nickname.equals("tran") == false){ // transfer down
			senduser(s1[1], s1[2]);
		} else{ // transfer up
			sendgroup(s1[1], s1[2]);
		}
	}

	@OnError
	public void onError(Throwable t) throws Throwable {
		log.error("Chat Error: " + t.toString(), t);
	}

	private static void senduser(String user, String msg) {
		for (ChatAnnotation client : connections) {
			if (client.nickname.equals(user) == false)
				continue;
			try {
				synchronized (client) {
					client.session.getBasicRemote().sendText(msg);
				}
			} catch (IOException e) {
				log.debug("Chat Error: Failed to send message to client", e);
				connections.remove(client);
				try {
					client.session.close();
				} catch (IOException e1) {
					// Ignore
				}
				String message = String.format("* %s %s", client.nickname, "has been disconnected.");
				broadcast(message);
			}
		}
	}

	private static void sendgroup(String user, String msg) {
		for (ChatAnnotation client : connections) {
			String traname = client.nickname;
			if (traname.length() < 8)
				continue;
			if (traname.substring(0, 8).equals(user) == false)
				continue;
			try {
				synchronized (client) {
					client.session.getBasicRemote().sendText(msg);
				}
			} catch (IOException e) {
				log.debug("Chat Error: Failed to send message to client", e);
				connections.remove(client);
				try {
					client.session.close();
				} catch (IOException e1) {
					// Ignore
				}
				String message = String.format("* %s %s", client.nickname, "has been disconnected.");
				broadcast(message);
			}
		}
	}

	private static void broadcast(String msg) {
		for (ChatAnnotation client : connections) {
			try {
				synchronized (client) {
					client.session.getBasicRemote().sendText(msg);
				}
			} catch (IOException e) {
				log.debug("Chat Error: Failed to send message to client", e);
				connections.remove(client);
				try {
					client.session.close();
				} catch (IOException e1) {
					// Ignore
				}
				String message = String.format("* %s %s", client.nickname, "has been disconnected...");
				broadcast(message);
			}
		}
	}
}
