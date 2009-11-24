package org.hamster.effects.effectInstance
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class SplitFadeZoomInstance extends SplitInstance
	{
		public var zoomFrom:Number;
		public var zoomTo:Number;
		public var fadeFrom:Number;
		public var fadeTo:Number;
		
		public function SplitFadeZoomInstance(target:Object)
		{
			super(target);
			
		}
		
		override public function play():void
		{
			super.play();
			
			if (!isLegal(fadeFrom)) {
				fadeFrom = uiTarget.alpha;
			}
			
			if (!isLegal(fadeTo)) {
				fadeTo = 1;
			}
			
			if (!isLegal(zoomFrom)) {
				zoomFrom = uiTarget.scaleX;
			}
			
			if (!isLegal(zoomTo)) {
				zoomTo = 1;
			}

			_mDraw = new Matrix();
		}
		
		protected function isLegal(value:Number):Boolean
		{
			return !isNaN(fadeFrom) && fadeFrom <= 1 && fadeFrom >= 0;
		}
		
		override public function onTweenUpdate(value:Object):void
		{  
			super.onTweenUpdate(value);
			
			var zoomValue:Number = Number(value) * (zoomTo - zoomFrom) + zoomFrom;
			var fadeValue:Number = Number(value) * (fadeTo - fadeFrom) + fadeFrom;
			
			var g:Graphics = _overlay.graphics;
			var colorTrans:ColorTransform = new ColorTransform();
			colorTrans.alphaMultiplier = 1;
			colorTrans.alphaOffset = - (1 - fadeValue) * 256;
			
			var bdDrawData:BitmapData;
			for each (bdDrawData in this._bdDrawList) {
				bdDrawData.lock();
			}
			
			for (var i:int = 0; i < columnCount; i++) {
				for(var j:int = 0; j < rowCount; j++) {
					var index:int = i * rowCount + j;
					var bd:BitmapData = BitmapData(this._bitmapDataList[index]);
					var bdDraw:BitmapData = BitmapData(this._bdDrawList[index]);
					_mDraw.createBox(zoomValue, zoomValue, 0, 
							(i + 0.5 - zoomValue / 2) * this._smallWidth,
							(j + 0.5 - zoomValue / 2) * this._smallHeight);
					bdDraw.copyPixels(bd, bd.rect, _zeroPoint);
					if (fadeValue != 1) {
						bdDraw.colorTransform(bd.rect, colorTrans);
					}
					g.beginBitmapFill(bdDraw, _mDraw);
					g.drawRect((i + 0.5 - zoomValue / 2) * this._smallWidth, 
							   (j + 0.5 - zoomValue / 2) * this._smallHeight,
							this._smallWidth * zoomValue, this._smallHeight * zoomValue);
					g.endFill();
				}
			}
			
			for each (bdDrawData in this._bdDrawList) {
				bdDrawData.unlock();
			}
		}
		
	}
}