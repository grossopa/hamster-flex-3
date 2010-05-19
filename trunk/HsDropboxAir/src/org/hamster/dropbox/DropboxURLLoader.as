package org.hamster.dropbox
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class DropboxURLLoader extends URLLoader
	{
		private var _resultType:Class;
		
		public function DropboxURLLoader(request:URLRequest=null)
		{
			super(request);
		}
		
		override public function load(request:URLRequest):void
		{
			super.load(request);
			this.addEventListener(Event.COMPLETE, loadCompleteHandler);
		}
		
		protected function loadCompleteHandler(evt:Event):void
		{
			
		}
		
	}
}