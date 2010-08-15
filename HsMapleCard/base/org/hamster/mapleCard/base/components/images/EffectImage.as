package org.hamster.mapleCard.base.components.images
{
	import flash.events.Event;
	
	import org.hamster.commands.events.CommandEvent;
	import org.hamster.mapleCard.base.commands.EffectImageLoaderCmd;
	import org.hamster.mapleCard.base.constants.BaseImagePlayMethod;
	import org.hamster.mapleCard.base.constants.Constants;
	import org.hamster.mapleCard.base.model.support.EffectImageInfo;
	import org.hamster.mapleCard.base.services.DataService;

	public class EffectImage extends BaseImage
	{
		private static const DS:DataService = DataService.instance;
		
		private var _id:String;
		public function get id():String { return this._id; }
		
		private var _info:EffectImageInfo;
		public function get info():EffectImageInfo { return this._info };
		
		public function EffectImage(id:String)
		{
			super();
			this._alignment = "center";
			this.playMethod = BaseImagePlayMethod.NORMAL;
			this.speed = 10;
			this._id = id;
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler);
		}
		
		protected function addedHandler(evt:Event):void
		{
			initialization();
		}
		
		protected function initialization():void
		{
			if (!DS.imageCacheManager.exists(Constants.EFFECT_KEY_PREFIX + id)) {
				trace ("Load Effect Image " + id + " from file system");
				var cmd:EffectImageLoaderCmd = EffectImageLoaderCmd.execute(id);
				cmd.addEventListener(CommandEvent.COMMAND_RESULT, loaderResultHandler);
				cmd.addEventListener(CommandEvent.COMMAND_FAULT, loaderFaultHandler);
			} else {
				trace ("Load Effect Image " + id + " from cache service");
				this._info = EffectImageInfo(DS.imageCacheManager.get(Constants.EFFECT_KEY_PREFIX + id));
				initializeFromImgArray(_info.images);
			}
		}
		
		private function loaderResultHandler(evt:CommandEvent):void
		{
			var cmd:EffectImageLoaderCmd = EffectImageLoaderCmd(evt.currentTarget);
			this._info = cmd.effectImageInfo;
			
			// save item to cache
			DS.imageCacheManager.put(Constants.EFFECT_KEY_PREFIX + id, _info);
			initializeFromImgArray(_info.images);
		}
		
		
		private function loaderFaultHandler(evt:CommandEvent):void
		{
			trace ("Load effect image " + id + " failed");
		}
	}
}