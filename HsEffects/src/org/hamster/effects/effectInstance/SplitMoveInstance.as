package org.hamster.effects.effectInstance
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Point;
	
	public class SplitMoveInstance extends SplitInstance
	{
		protected var _bdDraw:BitmapData;
		
		private var _randomDirs:Array;	
		
		public function SplitMoveInstance(target:Object)
		{
			super(target);
			
			needDrawBackground = false;
		}
		
		override public function play():void
		{
			super.play()
			
			_bdDraw = new BitmapData(uiTarget.width, uiTarget.height, true, 0x00);
			
			_randomDirs = new Array();
			for (var i:int = 0; i < columnCount; i++) {
				for(var j:int = 0; j < rowCount; j++) {
					var point:Point;
					
					//if (i % 2 == 0) {
						point = new Point((-0.5 - Math.random()) * 220 + 0, Math.random() * uiTarget.height);
					//} else {
					//	point = new Point((0.5 + Math.random()) * 220 + uiTarget.width, Math.random() * uiTarget.height);
					//}
//					if (i < columnCount / 2 && j < rowCount / 2) {
//						point = new Point((1.2 + Math.random()) * uiTarget.width, 
//								(1.2 + Math.random()) * uiTarget.height); 
//					} else if (i >= columnCount / 2 && j < rowCount / 2) {
//						point = new Point((-0.2 - Math.random()) * uiTarget.width, 
//								(1.2 + Math.random()) * uiTarget.height); 
//					} else if (i >= columnCount / 2 && j >= rowCount / 2) {
//						point = new Point((-0.2 - Math.random()) * uiTarget.width, 
//								(-0.2 - Math.random()) * uiTarget.height); 						
//					} else {
//						point = new Point((1.2 + Math.random()) * uiTarget.width, 
//								(-0.2 - Math.random()) * uiTarget.height); 
//					}
					_randomDirs.push(point);
				}
			}
		}
		
		override public function onTweenUpdate(value:Object):void
		{  
			super.onTweenUpdate(value);
			
			var g:Graphics = _overlay.graphics;
			
			_bdDraw.lock();
			
			_bdDraw.copyPixels(this._bdParentSnapshot, this._bdParentSnapshot.rect, this._zeroPoint);
			
			var curValue:Number = Number(value);
			
			for (var i:int = 0; i < columnCount; i++) {
				for(var j:int = 0; j < rowCount; j++) {
					var index:int = i * rowCount + j;
					var bd:BitmapData = BitmapData(this._bitmapDataList[index]);
					var point:Point = Point(_randomDirs[index]);
					_destPoint.x = (0.5 - Math.random()) * 420 + curValue * point.x + (1 - curValue) * i * _smallWidth;
					_destPoint.y = (0.5 - Math.random()) * 420 + curValue * point.y + (1 - curValue) * j * _smallHeight;
					_bdDraw.copyPixels(bd, bd.rect, _destPoint);
				}
			}
			
			g.beginBitmapFill(_bdDraw);
			g.drawRect(0, 0, this.uiTarget.width, this.uiTarget.height);
			g.endFill();
					
			_bdDraw.unlock();
		}
	}
}