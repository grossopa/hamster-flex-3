package org.hamster.framework.puremvc
{
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.logging.LogEventLevel;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class HsMediator extends Mediator
	{
		private var log:ILogger = Log.getLogger("pureMVC");
		
		public function HsMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
		}
		
		override public function handleNotification(notification:INotification):void
		{
			log.log(LogEventLevel.INFO, "PureMVC " + this.getMediatorName() + " received " + notification.getName());
			super.handleNotification(notification);
		}
	}
}