package org.hamster.alive30.common.vo.proxy
{
	import flash.xml.XMLNode;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.hamster.services.HTTPServiceLocator;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class BaseRemoteProxy extends Proxy implements IResponder
	{
		protected var locator:HTTPServiceLocator = HTTPServiceLocator.getInstance();
		private static var _logger:ILogger = Log.getLogger("hs.BaseRemoteProxy");
		
		public function BaseRemoteProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
		
		public function load(serviceId:String, params:Object = null):AsyncToken
		{
			var httpService:HTTPService = HTTPServiceLocator.getInstance().getService(serviceId);
			if (httpService == null) {
				_logger.error('Get service "' + serviceId + '" failed.');
				return null;
			} else {
				_logger.info('Begin load service "' + serviceId + '".');
				var asyncToken:AsyncToken = httpService.send(params);
				asyncToken.addResponder(this);
				return asyncToken;
			}
		}
		
		public final function result(data:Object):void
		{
			_logger.info('  Load complete. Begin to handle result.');
			var xml:XML = new XML(data.result);
			this.processResult(xml);
//			if (ValidatorUtil.remoteRequest(xml) != 0) {
//				this.processFault(xml);
//			} else {
//				this.processResult(xml);
//			}
			_logger.info('Handle complete.');
		}
		
		public final function fault(info:Object):void
		{
			var faultEvt:FaultEvent = FaultEvent(info);
			_logger.error(faultEvt.fault.toString());
		//	this.processFault(faultEvt.fault);
		}
		
		protected function processResult(xml:XML):void
		{
			
		}
		
		protected function processFault(xml:XML):void
		{
			
		}
		

	}
}