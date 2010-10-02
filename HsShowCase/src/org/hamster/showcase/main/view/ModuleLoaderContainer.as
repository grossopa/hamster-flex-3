package org.hamster.showcase.main.view
{
	import mx.events.ModuleEvent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.logging.LogEventLevel;
	import mx.modules.ModuleLoader;
	
	public class ModuleLoaderContainer extends ModuleLoader
	{
		private var logger:ILogger = Log.getLogger("hs.ModuleLoaderContainer");
		
		public function ModuleLoaderContainer()
		{
			super();
			
			this.addEventListener(ModuleEvent.ERROR, moduleErrorHandler);
			this.addEventListener(ModuleEvent.PROGRESS, moduleProgressHandler);
			this.addEventListener(ModuleEvent.READY, moduleReadyHandler);
		}
		
		private function moduleErrorHandler(evt:ModuleEvent):void
		{
			// show error screen
			logger.log(LogEventLevel.ERROR, "module '" + evt.module.url + "' load failed. Error: " + evt.errorText);
		}
		
		private function moduleProgressHandler(evt:ModuleEvent):void
		{
			// show progress screen
		}
		
		private function moduleReadyHandler(evt:ModuleEvent):void
		{
			// show ready screen
			logger.log(LogEventLevel.INFO, "module '" + evt.module.url + "' ready.");
		}
		
		
		
		
	}
}