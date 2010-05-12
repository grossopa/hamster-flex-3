package org.hamster.dropbox
{
	import flash.events.Event;
	
	import org.hamster.dropbox.test.OAuthTestCase;
	import org.iotashan.oauth.OAuthToken;
	
	public class DropboxEvent extends Event
	{
		public static const REQUEST_TOKEN_RESULT:String = 'DropboxEvent_RequestTokenResult';
		public static const REQUEST_TOKEN_FAULT:String = 'DropboxEvent_RequestTokenFault';
		public static const ACCESS_TOKEN_RESULT:String = 'DropboxEvent_AccessTokenResult';
		public static const ACCESS_TOKEN_FAULT:String = 'DropboxEvent_AccessTokenFault';
		
		public static const HTTP_RESULT:String = 'DropboxEvent_HttpResult';
		public static const HTTP_FAULT:String = 'DropboxEvent_HttpFault';
		
		public var relatedEvent:Event;
		
		public var requestToken:OAuthToken;
		public var accessToken:OAuthToken;
		
		public function DropboxEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:DropboxEvent = new DropboxEvent(type, bubbles, cancelable);
			result.relatedEvent = this.relatedEvent;
			result.requestToken = this.requestToken;
			result.accessToken = this.accessToken;
			return result;
		}
	}
}