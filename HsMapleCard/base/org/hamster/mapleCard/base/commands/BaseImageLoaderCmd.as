package org.hamster.mapleCard.base.commands
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.core.BitmapAsset;
	
	import org.hamster.commands.AbstractCommand;
	
	import spark.utils.BitmapUtil;
	
	public class BaseImageLoaderCmd extends AbstractCommand
	{
		public var fileDir:String;
		
		public function BaseImageLoaderCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			var loader:Loader = new URLLoader();
			var urlRequest:URLRequest = new URLRequest(fileDir);
			loader.loaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.load(urlRequest);
		}
	}
}