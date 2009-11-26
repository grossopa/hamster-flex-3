package org.hamster.effects.effectInstance
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Point;
	
	import org.hamster.effects.SplitMass;
	
	public class SplitMassInstance extends SplitInstance
	{
		public static const UNIT_DURATION:Number = 0.3;
		
		/**
		 * properties from SplitShowImage
		 */
		public var aniType:String;
		public var startPoint:Point;
		public var startPoints:Array;
		private var _startDelayList:Array;
		
		public function SplitMassInstance(target:Object)
		{
			super(target);
		}
		
		override protected function beginPlay():void
		{
			super.beginPlay();
			
			var isAutoCreate:Boolean;
			if (aniType == SplitMass.FROM_POINTS && startPoints == null) {
				startPoints = new Array();
				isAutoCreate = true;
			}
			_startDelayList = new Array();
			
			for (var i:int = 0; i < this.columnCount; i++) {
				for (var j:int = 0; j < this.rowCount; j++) {
					_startDelayList.push(Math.random() * (1 - UNIT_DURATION));
					if (isAutoCreate) {
						startPoints.push(new Point(Math.random() * uiTarget.width, 0));
					}
				}
			}
			
			if (startPoint == null) {
				startPoint = new Point();
			}
		}
		
		
		override public function onTweenUpdate(value:Object):void
		{
			super.onTweenUpdate(value);
			
			var numValue:Number = Number(value);
			
			this._bdDraw = new BitmapData(uiTarget.width, uiTarget.height, true, 0x00);
			this._bdDraw.lock();
			
			for (var i:int = 0; i < this.columnCount; i++) {
				for (var j:int = 0; j < this.rowCount; j++) {
					var index:int = i * rowCount + j;
					var startDelay:Number = Number(_startDelayList[index]);
					if (startDelay > numValue) {
						continue;
					}
					var bd:BitmapData = BitmapData(this._bitmapDataList[index]);
					var sp:Point;
					if (this.aniType == SplitMass.FROM_ONE_POINT) {
						sp = startPoint;
					} else {
						sp = Point(this.startPoints[index % this.startPoints.length]);
					}
					var percent:Number = Math.min((numValue - startDelay) / UNIT_DURATION, 1);
					
					
					this._destPoint.x = (i * _smallWidth - sp.x) * percent + sp.x;
					this._destPoint.y = (j * _smallHeight - sp.y) * percent + sp.y;
					
					this._bdDraw.copyPixels(bd, bd.rect, _destPoint);
				}
			}
			this._bdDraw.unlock();
			
			var g:Graphics = this._overlay.graphics;
			g.clear();
			g.beginBitmapFill(_bdDraw);
			g.drawRect(0, 0, uiTarget.width, uiTarget.height);
			g.endFill();
		}
		
	}
}