package org.hamster.showcase.common.vo.proxy
{
	import flash.xml.XMLNode;
	
	import mx.rpc.IResponder;
	
	import org.hamster.showcase.common.util.ValidatorUtil;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class BaseRemoteProxy extends Proxy implements IResponder
	{
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
		}
		
		protected function processResult(xml:XML):void
		{
			
		}
		
		protected function processFault(xml:XML):void
		{
			
		}
		

	}
}