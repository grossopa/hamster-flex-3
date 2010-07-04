package org.hamster.mapleCard.base.components.images
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	import org.hamster.commands.events.CommandEvent;
	import org.hamster.mapleCard.base.commands.CreatureImageLoaderCmd;
	import org.hamster.mapleCard.base.components.BaseImage;
	import org.hamster.mapleCard.base.constants.CreatureStatusConst;
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
		
		private var _speed:int = 11;
		public function set speed(value:int):void { this._speed = value; }
		public function get speed():int { return this._speed }
		
		private var _currentFrame:int = 0;
		private var _frameCount:int = 0;
		private var _matrixUtil:Matrix;
		private var _measuredWidth:Number;
		private var _measuredHeight:Number;
		
		public function CreatureImage(id:String)
		{
			super();
			this._id = id;
			_matrixUtil = new Matrix();
			this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		protected function addedToStageHandler(evt:Event):void
		{
			initialization();
		}
		
		protected function initialization():void
		{
			//if (!DS.imageCacheManager.exists(_subDir)) {
				var cmd:CreatureImageLoaderCmd = CreatureImageLoaderCmd.execute(id);
				cmd.addEventListener(CommandEvent.COMMAND_RESULT, loaderResultHandler);
				cmd.addEventListener(CommandEvent.COMMAND_FAULT, loaderFaultHandler);
			//}
		}
		
		private function loaderResultHandler(evt:CommandEvent):void
		{
			var cmd:CreatureImageLoaderCmd = CreatureImageLoaderCmd(evt.currentTarget);
			this._info = cmd.creatureImageInfo;
			var measuredWidth:Number = 0;
			var measuredHeight:Number = 0;
			for each (var bitmap:Bitmap in this._info.dieImages) {
				measuredWidth = Math.max(measuredWidth, bitmap.width);
				measuredHeight = Math.max(measuredHeight, bitmap.height);
			}
			for each (var bitmap:Bitmap in this._info.hitImages) {
				measuredWidth = Math.max(measuredWidth, bitmap.width);
				measuredHeight = Math.max(measuredHeight, bitmap.height);
			}
			for each (var bitmap:Bitmap in this._info.moveImages) {
				measuredWidth = Math.max(measuredWidth, bitmap.width);
				measuredHeight = Math.max(measuredHeight, bitmap.height);
			}
			for each (var bitmap:Bitmap in this._info.standImages) {
				measuredWidth = Math.max(measuredWidth, bitmap.width);
				measuredHeight = Math.max(measuredHeight, bitmap.height);
			}
			
			this._measuredWidth = measuredWidth;
			this._measuredHeight = measuredHeight;
			
			this.status = CreatureStatusConst.MOVE;
		}
		
		private function loaderFaultHandler(evt:CommandEvent):void
		{
			
		}
		
		protected function onEnterFrameHandler(evt:Event):void
		{
			if (this._info == null) return;
			if ((_frameCount % this._speed) == 0) {
				_frameCount = 1;
				playImageContent(); 
				this.width = this._measuredWidth;
				this.height = this._measuredHeight;
			} else {
				_frameCount++;
			}

		}
		
		protected function playImageContent():void
		{
			this.graphics.clear();
			
			var bitmap:Bitmap;
			if (status == CreatureStatusConst.MOVE) {
				this._currentFrame++;
				if (this._currentFrame >= this._info.moveImages.length) {
					this._currentFrame = 0;
				}
				bitmap = this._info.moveImages[this._currentFrame];
			}
			
			_matrixUtil.tx = (this._measuredWidth - bitmap.width) / 2;
			_matrixUtil.ty = this._measuredHeight - bitmap.height;
			this.graphics.beginBitmapFill(bitmap.bitmapData, _matrixUtil, false);
			this.graphics.drawRect(0, 0, this._measuredWidth, this._measuredHeight);
			this.graphics.endFill();
		}
	}
}