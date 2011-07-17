package org.hamster.pm.test.base;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.io.IOUtils;
import org.hamster.pm.test.functionalTest.JettyServer;
import org.junit.AfterClass;
import org.junit.BeforeClass;

public class BaseWebServiceTest extends BaseTest {

	public static final int PORT = 8080;
	public static final String TEST_URL = "http://127.0.0.1:" 
		+ PORT + JettyServer.CONTEXT_PATH;
	private static JettyServer server;
	public static boolean enableProxy = false;
	public static boolean localTest = true;
	
	public static File resultFolder = new File("test-result");
	
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		if (!resultFolder.exists()) {
			resultFolder.mkdir();
		}
		if (localTest) {
			server = new JettyServer(PORT, false);
		}
		System.out.println("----------set up---------------");
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		System.out.println("----------tear down------------");
		if (localTest) {
			server.stop();
		}
	}
	
	public final void executeMethod(HttpMethod method) 
			throws HttpException, IOException {
		executeMethod(method, HttpStatus.SC_OK);
	}
	
	public final void executeMethod(HttpMethod method, int status) 
			throws HttpException, IOException {
		int[] statusArray = {status};
		executeMethod(method, statusArray);
	}
	
	public final void executeMethod(HttpMethod method, int[] statusArray) 
			throws HttpException, IOException {
		HttpClient client = new HttpClient();
		if (enableProxy) {
			//HostConfiguration hostConfiguration = new HostConfiguration();
			//hostConfiguration.setProxy("proxy address", 8080);
			//client.setHostConfiguration(hostConfiguration);
		}
		client.executeMethod(method);
		boolean passed = false;
		for (int status : statusArray) {
			if (method.getStatusCode() == status) {
				passed = true;
				break;
			}
		}
		if (!passed) {
			System.out.println("result : " + method.getResponseBodyAsString());
			throw new IOException("response is not same as excepted." 
					+ method.getStatusCode());
		}
		System.out.println(method.getURI() + " " 
				+ method.getStatusCode());		
	}
	
	public final void executeMethodFile(
			HttpMethod method, String fileName) 
			throws IOException {
		HttpClient client = new HttpClient();
		if (enableProxy) {
			//HostConfiguration hostConfiguration = new HostConfiguration();
			//hostConfiguration.setProxy("proxy address", 8080);
			//client.setHostConfiguration(hostConfiguration);
		}
		client.executeMethod(method);
		OutputStream fos = new FileOutputStream(
				new File(resultFolder, fileName));
		IOUtils.copy(method.getResponseBodyAsStream(), fos);
		fos.flush();
		fos.close();
		System.out.println("File write to " + fileName);
	}
	
	public final String executeMethodFileString(
			HttpMethod method, String fileName) 
			throws IOException {
		HttpClient client = new HttpClient();
		if (enableProxy) {
			//HostConfiguration hostConfiguration = new HostConfiguration();
			//hostConfiguration.setProxy("proxy address", 8080);
			//client.setHostConfiguration(hostConfiguration);
		}
		client.executeMethod(method);
		OutputStream fos = new FileOutputStream(
				new File(resultFolder, fileName));
		String result = method.getResponseBodyAsString();
		IOUtils.write(result, fos);
		fos.flush();
		fos.close();
		System.out.println("File write to " + fileName);
		return result;
	}
}
