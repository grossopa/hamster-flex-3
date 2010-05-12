package org.hamster.dropbox.test
{
	import flexunit.framework.TestCase;
	
	import mx.controls.Alert;
	
	import org.hamster.dropbox.Authenticator;
	import org.hamster.dropbox.utils.DropboxConstants;
	import org.hamster.dropbox.DropboxEvent;
	
	public class OAuthTestCase extends TestCase
	{
		public function OAuthTestCase(methodName:String=null)
		{
			super("OAuthTestCase");
		}
		
		override public function setUp():void
		{
			super.setUp();
		}
		
		override public function tearDown():void
		{
			super.tearDown();
		}
		
		private var auth:Authenticator;
		
		public function testOAuth():void
		{
			var config:Object = new Object();
			config["consumer_key"] = 'wnl0erseogu50mk';
			config["consumer_secret"] = 'eypos93aukcysdw';
			config["request_token_url"] = DropboxConstants.REQUEST_TOKEN_URL;
			config["access_token_url"] = DropboxConstants.ACCESS_TOKEN_URL;
			config["authorization_url"] = DropboxConstants.AUTHORIZATION_URL;
			auth = new Authenticator(config);
			auth.addEventListener(DropboxEvent.REQUEST_TOKEN_RESULT, requestTokenResultHandler);
			auth.addEventListener(DropboxEvent.REQUEST_TOKEN_FAULT, requestTokenFaultHandler);
			auth.retrieveRequestToken();
		}
		
		private function requestTokenResultHandler(evt:DropboxEvent):void
		{
			Alert.show("go to " + auth.getAuthorizeUrl());
		}
		
		private function requestTokenFaultHandler(evt:DropboxEvent):void
		{
			Alert.show("requestTokenFaultHandler Fault");
		}
		
	}
}