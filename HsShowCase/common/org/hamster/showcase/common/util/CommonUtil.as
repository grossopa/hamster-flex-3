package org.hamster.showcase.common.util
{
	import flash.events.Event;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import org.hamster.showcase.common.facade.AppFacade;
	import org.puremvc.as3.interfaces.IFacade;

	public class CommonUtil
	{
		private static var _facade:IFacade = AppFacade.instance;
		private static var _evtLogger:ILogger = Log.getLogger("hs.commonEvent");
		
		public static function set facade(value:IFacade):void { _facade = value; }
		public static function get facade():IFacade { return _facade; }
		
		public static function traceEvent(evt:Event, ...rest):void
		{
			_evtLogger.info(evt.type + " , " + rest.join(" , "));
		}
		
		
	}
}