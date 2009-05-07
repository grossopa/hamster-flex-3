package org.hamster.networks.service
{
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.mxml.HTTPService;
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 * 
	 * How to use:
	 *   The propose of this class is to convert HTTPServices as a configure 
	 * format.  You should extend this class and add your own HTTPService
	 * to extended class.  The best way of extending is using MXML.  Thus
	 * you can add HTTPService just like:
	 * 
	 * <?xml version="1.0" encoding="utf-8"?>
	 * <HTTPServiceLocator xmlns:mx="http://www.adobe.com/2006/mxml"
	 *     xmlns="org.hamster.networks.service.*" urlPrefix="http://www.">
	 *   <mx:HTTPService id="baidu" url="" resultFormat="text" />
	 *   <mx:HTTPService id="google" url="google.com" resultFormat="text" />
     * </HTTPServiceLocator>
     * 
     *   Please remember this is a SINGLETON service so that you should write
     * "new ExtendedHTTPServiceLocator();" at the beginning of your 
     * application.
     * 
	 */
	 	
	public class HTTPServiceLocator
	{
		private static var instance:HTTPServiceLocator;
		
		/**
		 * global url prefix
		 */
		public var urlPrefix:String = "";
		
		/**
		 * @return HTTPServiceLocator
		 * s
		 * Normally, this function will return the child class.
		 */
		public static function getInstance():HTTPServiceLocator
		{
			return instance;
		}

		/**
		 * construct function
		 */
		public function HTTPServiceLocator()
		{
			instance = this; // "this" is the class instance you extended
		}
		
		/**
		 * @param id
		 * 
		 * get HTTPService, return null if HTTPService doesn't exist.
		 */
		public function getService(id:String):HTTPService
		{
			return this.hasOwnProperty(id) ? (HTTPService) (this[id]) : null;
		}
		
		/**
		 * @param id
		 * @param responder
		 * @param param
		 * @param urlPrefix
		 * 
		 * You can use this function to send a HTTPService request.
		 * 
		 * a sample creation of param:
		 * var obj:Object = new Object();
		 * obj["param1"] = "test";
		 * obj["param2"] = 0.235;
		 * 
		 * there are three ways to specify a urlPrefix, the priority is:
		 * 
		 * HTTPService.rootURL > urlPrefix(parameter) > this.urlPrefix
		 * 
		 */
		public function sendService(id:String, responder:IResponder, 
				param:Object = null, urlPrefix:String = ""):void
		{
			var s:HTTPService = this.getService(id);
			var originUrl:String = s.url;
			var tmp:String = urlPrefix == "" ? this.urlPrefix : urlPrefix;
			if(s.rootURL == null || s.rootURL.length == 0) s.url = tmp + s.url;
			var call:AsyncToken = s.send(param);
			call.addResponder(responder);
			s.url = originUrl;
		}

	}
}