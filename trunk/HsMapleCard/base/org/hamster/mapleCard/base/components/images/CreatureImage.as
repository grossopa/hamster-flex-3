package org.hamster.mapleCard.base.components.images
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	import org.hamster.commands.events.CommandEvent;
	import org.hamster.mapleCard.base.commands.CreatureImageLoaderCmd;
	import org.hamster.mapleCard.base.constants.BaseImagePlayMethod;
	import org.hamster.mapleCard.base.constants.Constants;
	import org.hamster.mapleCard.base.constants.CreatureStatus;
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
		public function set status(value:String):void 
		{
			this._status = value;
			this._currentImgIndex = 0;
		}
		public function get status():String { return this._status; }
		
		public function CreatureImage(id:String)
		{
			super();
			this._id = id;
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler);
		}
		
		protected function addedHandler(evt:Event):void
		{
			initialization();
		}
		
		protected function initialization():void
		{
			if (!DS.imageCacheManager.exists(Constants.CREATE_KEY_PREFIX + id)) {
				trace ("Load Image " + id + " from file system");
				var cmd:CreatureImageLoaderCmd = CreatureImageLoaderCmd.execute(id);
				cmd.addEventListener(CommandEvent.COMMAND_RESULT, loaderResultHandler);
				cmd.addEventListener(CommandEvent.COMMAND_FAULT, loaderFaultHandler);
			} else {
				trace ("Load Image " + id + " from cache service");
				this._info = CreatureImageInfo(DS.imageCacheManager.get(Constants.CREATE_KEY_PREFIX + id));
				initializeFromImgArray(_info.moveImages, _info.standImages, _info.hitImages, _info.dieImages);
			}
		}
		
		private function loaderResultHandler(evt:CommandEvent):void
		{
			var cmd:CreatureImageLoaderCmd = CreatureImageLoaderCmd(evt.currentTarget);
			this._info = cmd.creatureImageInfo;
			
			// save item to cache
			DS.imageCacheManager.put(Constants.CREATE_KEY_PREFIX + id, _info);
			initializeFromImgArray(_info.moveImages, _info.standImages, _info.hitImages, _info.dieImages);
		}
		
		
		private function loaderFaultHandler(evt:CommandEvent):void
		{
			trace ("Load image " + id + " failed");
		}
		
		override protected function updateDisplayContent():void
		{
			if (this._info == null) return;
			
			if (status == CreatureStatus.MOVE) {
				_imgArray = this._info.moveImages;
			} else if (status == CreatureStatus.HIT) {
				_imgArray = this._info.hitImages;
			} else if (status == CreatureStatus.STAND) {
				_imgArray = this._info.standImages;
			} else if (status == CreatureStatus.DIE) {
				_imgArray = this._info.dieImages;
			}
			
			if (status != CreatureStatus.DIE) {
				this.playMethod = BaseImagePlayMethod.REVERSE_REPEAT;
			} else {
				this.playMethod = BaseImagePlayMethod.NORMAL;
			}
			
			super.updateDisplayContent();
		}
	}
}