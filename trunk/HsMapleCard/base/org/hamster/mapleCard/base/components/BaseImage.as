package org.hamster.mapleCard.base.components
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	import org.hamster.mapleCard.base.constants.BaseImagePlayMethod;
	
	public class BaseImage extends Sprite
	{
		protected var _speed:int = 6;
		public function set speed(value:int):void { this._speed = value; }
		public function get speed():int { return this._speed }
		
		protected var _direction:String = "left";
		public function set direction(value:String):void { this._direction = value; }
		public function get direction():String { return this._direction }
		
		protected var _playMethod:String = BaseImagePlayMethod.REVERSE_REPEAT;
		public function set playMethod(value:String):void { this._playMethod = value; }
		public function get playMethod():String { return this._playMethod }
		
		protected var _imgArray:Array;
		protected var _currentImgIndex:int = 0;
		protected var _frameCount:int = 0;
		protected var _matrixUtil:Matrix;
		protected var _measuredWidth:Number;
		protected var _measuredHeight:Number;
		
		// play method
		protected var _isPlayReverse:Boolean;
		
		public function BaseImage()
		{
			super();
			_matrixUtil = new Matrix();
			this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		protected function onEnterFrameHandler(evt:Event):void
		{
			if ((_frameCount % this._speed) == 0) {
				_frameCount = 1;
				updateDisplayContent(); 
				this.width = this._measuredWidth;
				this.height = this._measuredHeight;
			} else {
				_frameCount++;
			}
		}
		
		protected function updateCurrentImgIndex():void
		{
			if (_imgArray.length == 1) {
				this._currentImgIndex = 0;
				return;
			}
			
			if (this._playMethod == BaseImagePlayMethod.NORMAL) {
				if (this._currentImgIndex < this._imgArray.length - 1) {
					this._currentImgIndex++;
				}
			} else if (this._playMethod == BaseImagePlayMethod.REPEAT) {
				if (this._currentImgIndex < this._imgArray.length - 1) {
					this._currentImgIndex++;
				} else {
					this._currentImgIndex = 0;
				}
			} else if (this._playMethod == BaseImagePlayMethod.REVERSE_REPEAT) {
				if (!_isPlayReverse) {
					if (this._currentImgIndex == _imgArray.length - 1) {
						this._currentImgIndex--;
						_isPlayReverse = true;
					} else {
						this._currentImgIndex++;
					}
				} else {
					if (this._currentImgIndex == 0) {
						this._currentImgIndex++;
						_isPlayReverse = false;
					} else {
						this._currentImgIndex--;
					}				
				}
			}
		}
		
		protected function updateDisplayContent():void 
		{
			updateCurrentImgIndex();
			updateBitmapData();
		}
		
		protected function initializeFromImgArray(...imgArrays):void
		{
			var measuredWidth:Number = 0;
			var measuredHeight:Number = 0;
			var bitmap:Bitmap;
			
			for each (var imgArray:Array in imgArrays) {
				for each (bitmap in imgArray) {
					measuredWidth = Math.max(measuredWidth, bitmap.width);
					measuredHeight = Math.max(measuredHeight, bitmap.height);
				}
			}
			
			this._measuredWidth = measuredWidth;
			this._measuredHeight = measuredHeight;
			this._imgArray = imgArrays[0];
		}
		
		protected function updateBitmapData():void 
		{
			this.graphics.clear();
			var bitmap:Bitmap = _imgArray[_currentImgIndex];
			
			var measuredX:Number = (this._measuredWidth - bitmap.width) / 2;
			var measuredY:Number = this._measuredHeight - bitmap.height; 
			_matrixUtil.tx = measuredX;
			_matrixUtil.ty = measuredY;
			if (this._direction == "right") {
				_matrixUtil.a = -1;
				_matrixUtil.tx += bitmap.width;
			}
			this.graphics.drawRect(0, 0, this._measuredWidth, this._measuredHeight);
			this.graphics.beginBitmapFill(bitmap.bitmapData, _matrixUtil, false);
			this.graphics.drawRect(measuredX, measuredY, bitmap.width, bitmap.height);
			this.graphics.endFill();
		}
	}
}