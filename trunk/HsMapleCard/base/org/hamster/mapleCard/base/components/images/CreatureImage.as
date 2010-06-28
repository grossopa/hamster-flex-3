package org.hamster.mapleCard.base.components.images
{
	import flash.events.Event;
	
	import org.hamster.mapleCard.base.components.BaseImage;
	import org.hamster.mapleCard.base.services.DataService;
	
	public class CreatureImage extends BaseImage
	{
		private static const DS:DataService = DataService.instance;
		
		public static var rootDir:String;
		
		private var _subDir:String;
		public function set subDir(value:String):void
		{
			this._subDir = value;
		}
		public function get subDir():String
		{
			return this._subDir;
		}
		
		private var _status:String;
		public function set status(value:String):void
		{
			this._status = value;
		}
		public function get status():String
		{
			return this._status;
		}
		
		
		public function CreatureImage()
		{
			super();
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		protected function initialization():void
		{
			if ()
		}
		
		protected function onEnterFrameHandler(evt:Event):void
		{
			
		}
	}
}