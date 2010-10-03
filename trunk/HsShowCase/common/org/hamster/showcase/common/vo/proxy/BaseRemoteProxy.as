package org.hamster.showcase.common.vo.proxy
{
	import flash.xml.XMLNode;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.Fault;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	
	import org.hamster.services.HTTPServiceLocator;
	import org.hamster.showcase.common.util.ValidatorUtil;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class BaseRemoteProxy extends Proxy implements IResponder
	{
		protected var locator:HTTPServiceLocator = HTTPServiceLocator.getInstance();
		private static var _logger:ILogger = Log.getLogger("hs.BaseRemoteProxy");
		
		public function BaseRemoteProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
		
		public final function result(data:Object):void
		{
			var xml:XML = new XML(data.result);
			if (ValidatorUtil.remoteRequest(xml) != 0) {
				this.processFault(xml);
			} else {
				this.processResult(xml);
			}
		}
		
		public final function fault(info:Object):void
		{
			var faultEvt:FaultEvent = FaultEvent(info);
			_logger.error(faultEvt.fault.toString());
		}
		
		protected function processResult(xml:XML):void
		{
			
		}
		
		protected function processFault(xml:XML):void
		{
			
		}
		

	}
}