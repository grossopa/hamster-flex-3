package org.hamster.framework.puremvc
{
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class HsFacade extends Facade
	{
		private var log:ILogger = Log.getLogger("pureMVC");
		
		public function HsFacade()
		{
			super();
		}
		
		override public function registerCommand(notificationName:String, commandClassRef:Class):void
		{
			log.info("PureMVC facade registerCommand " + notificationName + " " + commandClassRef);
			super.registerCommand(notificationName, commandClassRef);
		}
		
		override public function removeCommand(notificationName:String):void
		{
			log.info("PureMVC facade removeCommand " + notificationName);
			super.removeCommand(notificationName);
		}
		
		override public function registerMediator(mediator:IMediator):void
		{
			log.info("PureMVC facade registerMediator " + mediator.getMediatorName());
			super.registerMediator(mediator);
		}
		
		override public function removeMediator(mediatorName:String):IMediator
		{
			log.info("PureMVC facade removeMediator " + mediatorName);
			return super.removeMediator(mediatorName);
		}
		
		override public function registerProxy(proxy:IProxy):void
		{
			log.info("PureMVC facade registerProxy " + proxy.getProxyName());
			super.registerProxy(proxy);
		}
		
		override public function removeProxy(proxyName:String):IProxy
		{
			log.info("PureMVC facade removeProxy " + proxyName);
			return super.removeProxy(proxyName);
		}
		
		override public function sendNotification(notificationName:String, body:Object=null, type:String=null):void
		{
			log.info("PureMVC facade sendNotification " + notificationName);
			super.sendNotification(notificationName, body, type);
		}
	}
}