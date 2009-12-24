package org.hamster.effects.effectInstance
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Point;
	
	import org.hamster.effects.SplitMass;
	
	/**
	 * <p>Instance class of <code>org.hamster.effects.SplitMass</code>.</p>
	 */
	public class SplitMassInstance extends SplitInstance
	{
		/**
		 * <p>Block animation duration percent, the actual duration value is 
		 * <code>duration</code> * <code>UNIT_DURATION</code>.</p>
		 */
		public static const UNIT_DURATION:Number = 0.3;
		
		/**
		 * <p>Start points value array. If you use FROM_POINTS and leave it empty, the instance class
		 * will auto create a random points array whose length is equals to 
		 * <code>rowCount</code> * <code>columnCount</code>.</p>
		 */
		public var startPoints:Array;
		
		/**
		 * <p>stores start delay percent value of each block.</p>
		 * 
		 * <p>It contains a list of random numbers range from 0 to 1, and <code>length</code> equals
		 * <code>rowCount</code> * <code>columnCount</code>,
		 * 
		 */
		private var _startDelayList:Array;
		
		/**
		 * constructor
		 */
		public function SplitMassInstance(target:Object)
		{
			super(target);
		}
		
		/**
		 * override
		 */
		override protected function beginPlay():void
		{
			super.beginPlay();
			
			var isAutoCreate:Boolean;
			if (startPoints == null || startPoints.length == 0) {
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
		}
		
		/**
		 * override
		 */
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
					sp = Point(this.startPoints[index % this.startPoints.length]);
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