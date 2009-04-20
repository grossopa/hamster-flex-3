package org.hamster.networks.service
{
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.mxml.HTTPService;
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 */
	 	
	public class HTTPServiceLocator
	{
		private static var instance:HTTPServiceLocator;
		
		public var urlPrefix:String = "";
		
		public static function getInstance():HTTPServiceLocator
		{
			return instance;
		}

		public function HTTPServiceLocator()
		{
			instance = this;
		}
		
		public function getService(id:String):HTTPService
		{
			return this.hasOwnProperty(id) ? (HTTPService) (this[id]) : null;
		}
		
		public function sendService(id:String, responder:IResponder, 
				param:Object = null, urlPrefix:String = ""):void
		{
			var s:HTTPService = this.getService(id);
			var originUrl:String = s.url;
			var temp:String = urlPrefix == "" ? this.urlPrefix : urlPrefix;
			s.url = temp + s.url;
			var call:AsyncToken = s.send(param);
			call.addResponder(responder);
			s.url = originUrl;
		}

	}
}