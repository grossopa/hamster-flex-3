package org.hamster.effects.effectInstance
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	import mx.effects.effectClasses.TweenEffectInstance;
	
	public class RainDropInstance extends TweenEffectInstance
	{
		private var _bmDraw:BitmapData;
		
		private var _startDelayList:Array;
		private var _startXList:Array;
		/**
		 * x bound
		 * y speed
		 */
		private var _boundList:Array;
		private var _pointList:Array;
		private var _bmDrawIndexList:Array;
		
		private var _dropPercent:Number;
		private var _maxBdHeight:Number = 0;
		
		public var bitmapDataList:Array;
		
		public var intervalDuration:Number;
		public var dropDuration:Number;
		
		public var wind:Number;
		
		public var rockHorizontal:Number;
		public var rockSpeed:Number;
		
		
		public function get uiTarget():UIComponent
		{
			return UIComponent(target);
		}
		
		public function RainDropInstance(target:Object)
		{
			super(target);
		}
		
		override public function play():void
		{
			_startDelayList = new Array();
			_pointList = new Array();
			_bmDrawIndexList = new Array();
			_startXList = new Array();
			_boundList = new Array();
			
			var count:int = int(this.duration / intervalDuration);
			_dropPercent = this.dropDuration / this.duration;
			
			for (var i:int = 0; i < count; i++) {
				_startDelayList.push(i / count);
				var xValue:Number = Math.random() * uiTarget.width;
				_startXList.push(xValue);
				var bound:Number = 0;
				if (!isNaN(this.rockHorizontal) && this.rockHorizontal > 0) {
					bound = Math.random() * this.rockHorizontal;
					
					if (bound < 3) {
						bound = 3;
					}
					
					var pb:Point = new Point(bound, (0.5 - Math.random()) * bound);
					_boundList.push(pb);
				}
				
				_pointList.push(new Point(xValue + bound, -80));
				_bmDrawIndexList.push(Math.random() * this.bitmapDataList.length);
			}
			
			for each (var bd:BitmapData in this.bitmapDataList) {
				_maxBdHeight = Math.max(_maxBdHeight, bd.height);
			}
			
			super.play();
			
			tween = createTween(this, 0, 1, duration);
		}
		
		override public function onTweenUpdate(value:Object):void
		{
			super.onTweenUpdate(value);
			
			var numValue:Number = Number(value);
			
			_bmDraw = new BitmapData(uiTarget.width, uiTarget.height, true, 0x00);
			_bmDraw.lock();
			for (var i:int = 0; i < _pointList.length; i++) {
				var startDelay:Number = Number(_startDelayList[i]);
				if (startDelay > numValue) {
					continue;
				}
				var point:Point = Point(_pointList[i]);
				var percent:Number = (numValue - startDelay) / _dropPercent;
				
				
				if (percent > 1) {
					continue;
				}
				
				var startX:Number = Number(_startXList[i]);
				var bound:Point = Point(this._boundList[i]);
				var dist:Number = Math.abs(startX - point.x);
				
				if (!isNaN(this.rockHorizontal) && this.rockHorizontal != 0 && bound.x != 0) {
					var isChanged:Boolean = false;
					
					if (bound.y >= bound.x) {
						bound.y -= this.rockSpeed;
					} else if (bound.y <= -bound.x) {
						bound.y += this.rockSpeed;
					}
					
					if (point.x > startX) {
						bound.y -= this.rockSpeed;
					} else if (point.x < startX) {
						bound.y += this.rockSpeed;
					}
					
					point.x += bound.y;
				}
				
				point.x += wind;
				point.y = percent * (uiTarget.height + _maxBdHeight * 2) - _maxBdHeight;
				
				var bd:BitmapData = BitmapData(this.bitmapDataList[int(_bmDrawIndexList[i])]);
				_bmDraw.copyPixels(bd,bd.rect, point, null, null, true);
			}
			
			_bmDraw.unlock();
			
			var g:Graphics = this.uiTarget.graphics;
			g.clear();
			g.beginBitmapFill(_bmDraw);
			g.drawRect(0, 0, this.uiTarget.width, this.uiTarget.height);
			g.endFill();
		}
		
		

	}
}