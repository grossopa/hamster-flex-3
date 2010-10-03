package org.hamster.showcase.common.util
{
	import flash.events.Event;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import org.hamster.showcase.common.facade.AppFacade;
	import org.puremvc.as3.interfaces.IFacade;

	public class CommonUtil
	{
		private static var _facade:IFacade = AppFacade.instance;
		private static var _evtLogger:ILogger = Log.getLogger("hs.commonEvent");
		private static var _localeLogger:ILogger = Log.getLogger("hs.locale");
		
		public static const LOCALES:Array = ["en_US", "zh_CN"];
		
		public static function set facade(value:IFacade):void { _facade = value; }
		public static function get facade():IFacade { return _facade; }
		
		public static function traceEvent(evt:Event, ...rest):void
		{
			_evtLogger.info(evt.type + " , " + rest.join(" , "));
		}
		
		
		public static function setLocale(value:String = "en_US"):void
		{
			var rm:IResourceManager = ResourceManager.getInstance();
			if (rm.localeChain.length == 0 || rm.localeChain[0] != value) {
				rm.localeChain = [value];
				_localeLogger.info("Locale has changed to " + value);
			}
		}
		
		
	}
}