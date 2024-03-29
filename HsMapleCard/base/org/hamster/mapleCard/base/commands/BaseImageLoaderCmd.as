package org.hamster.mapleCard.base.commands
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import org.hamster.commands.AbstractCommand;
	
	public class BaseImageLoaderCmd extends AbstractCommand
	{
		public var key:String;
		public var filePath:String;
		public var bitmap:Bitmap;
		
		public function BaseImageLoaderCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			var loader:Loader = new Loader();
			var urlRequest:URLRequest = new URLRequest(this.filePath);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, result);
			loader.load(urlRequest);
		}
		
		override public function result(data:Object):void
		{
			this.bitmap = data.target.content;
			super.result(data);
		}
	}
}