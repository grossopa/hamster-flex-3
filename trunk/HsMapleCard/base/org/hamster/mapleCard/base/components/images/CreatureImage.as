package org.hamster.mapleCard.base.components.images
{
	import flash.events.Event;
	
	import org.hamster.commands.events.CommandEvent;
	import org.hamster.mapleCard.base.commands.CreatureImageLoaderCmd;
	import org.hamster.mapleCard.base.components.BaseImage;
	import org.hamster.mapleCard.base.model.support.CreatureImageInfo;
	import org.hamster.mapleCard.base.services.DataService;
	
	public class CreatureImage extends BaseImage
	{
		private static const DS:DataService = DataService.instance;
		
		private var _id:String;
		public function get id():String { return this._id; }
		
		private var _info:CreatureImageInfo;
		public function get info():CreatureImageInfo { return this._info };
		
		private var _status:String;
		public function set status(value:String):void { this._status = value; }
		public function get status():String { return this._status; }
		
		private var _
		
		public function CreatureImage(id:String)
		{
			super();
			this.id = id;
			this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		protected function initialization():void
		{
			if (!DS.imageCacheManager.exists(_subDir)) {
				var cmd:CreatureImageLoaderCmd = CreatureImageLoaderCmd.execute(id);
				cmd.addEventListener(CommandEvent.COMMAND_RESULT, loaderResultHandler);
				cmd.addEventListener(CommandEvent.COMMAND_FAULT, loaderFaultHandler);
			}
		}
		
		private function loaderResultHandler(evt:CommandEvent):void
		{
			var cmd:CreatureImageLoaderCmd = CreatureImageLoaderCmd(evt.currentTarget);
			this._info = cmd.creatureImageInfo;
		}
		
		private function loaderFaultHandler(evt:CommandEvent):void
		{
			
		}
		
		protected function onEnterFrameHandler(evt:Event):void
		{
			if (this._info == null) return;
			
			switch (status)
		}
	}
}