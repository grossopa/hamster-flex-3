package org.hamster.pm.test.web;

import java.io.IOException;

import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.PostMethod;
import org.hamster.pm.test.base.BaseWebServiceTest;
import org.junit.Test;

public class TestLoginController extends BaseWebServiceTest {
	
	@Test
	public void testRegister() throws HttpException, IOException {
		PostMethod postMethod = new PostMethod(TEST_URL + "/main/register");
		postMethod.addParameter("email", "grossopaforever@gmail.com");
		postMethod.addParameter("password", "asdf");
		super.executeMethodFile(postMethod, "00_register.log");
	}	
	
	@Test
	public void testLogin() throws HttpException, IOException {
		PostMethod postMethod = new PostMethod(TEST_URL + "/main/login");
		postMethod.addParameter("email", "grossopaforever@gmail.com");
		postMethod.addParameter("password", "asdf");
		super.executeMethodFile(postMethod, "01_login.log");
	}
	
	@Test
	public void testLogout() throws HttpException, IOException {
		PostMethod postMethod = new PostMethod(TEST_URL + "/main/logout");
		super.executeMethodFile(postMethod, "03_logout.log");
	}
}
