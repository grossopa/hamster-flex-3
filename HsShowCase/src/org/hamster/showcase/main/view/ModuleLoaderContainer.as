package org.hamster.showcase.main.view
{
	import mx.events.ModuleEvent;
	import mx.modules.ModuleLoader;
	
	public class ModuleLoaderContainer extends ModuleLoader
	{
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
		}
		
		private function moduleProgressHandler(evt:ModuleEvent):void
		{
			// show progress screen
		}
		
		private function moduleReadyHandler(evt:ModuleEvent):void
		{
			// show ready screen
		}
		
		
		
		
	}
}