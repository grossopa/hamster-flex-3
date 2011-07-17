package org.hamster.pm.test.functionalTest;

import org.mortbay.jetty.Connector;
import org.mortbay.jetty.Server;
import org.mortbay.jetty.nio.SelectChannelConnector;
import org.mortbay.jetty.webapp.WebAppContext;

public class JettyServer {

	private static final int PORT = 8081;
	private final Server server;
	public static final String CONTEXT_PATH = "/PersonalManager";
	
	public JettyServer(final int port, 
			final boolean testMode) throws Exception {
		
		server = new Server();

		Connector connector = new SelectChannelConnector();
		connector.setPort(port);
		server.setConnectors(new Connector[]{connector});

		WebAppContext wac = new WebAppContext();
		wac.setContextPath(CONTEXT_PATH);
		wac.setWar("WebContent");
		server.setHandler(wac);
		server.setStopAtShutdown(true);
		Runtime.getRuntime().gc();
		server.start();
	}
	
	/**
	 * start Jetty Server.
	 * 
	 * @param args
	 * @return void
	 */
	public static final void main(final String[] args) {
		try {
			new JettyServer(PORT, false);
		} catch (Exception e) {
			System.exit(0);
		}
	}

	public void stop() throws Exception {
		server.stop();
	}

}