package org.hamster.effects.effectInstance
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.effects.Tween;
	import mx.effects.easing.Linear;
	import mx.effects.effectClasses.TweenEffectInstance;
	
	use namespace mx_internal;
	
	public class RainDropInstance extends TweenEffectInstance
	{
		
		public static const LEFT:uint = 0;
		public static const RIGHT:uint = 1;
		
		private var _bmDraw:BitmapData;
		private var _startDelayList:Array;
		private var _startXList:Array;
		private var _boundList:Array;
		private var _pointList:Array;
		private var _bmDrawIndexList:Array;
		
		private var _dropPercent:Number;
		
		public var bitmapDataList:Array;
		
		public var intervalDuration:Number;
		public var dropDuration:Number;
		
		public var windFrom:Number;
		public var windTo:Number;
		
		public var rockHorizontal:Number;
		public var rockSpeed:Number = 0;
		
		
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
			/**
			 * x bound
			 * y direction
			 */
			_boundList = new Array();
			
			var count:int = int(this.duration / intervalDuration);
			_dropPercent = this.dropDuration / this.duration;
			
			for (var i:int = 0; i < count; i++) {
				_startDelayList.push(i / count);
				var xValue:Number = Math.random() * uiTarget.width;
				_startXList.push(xValue);
				
				if (!isNaN(this.rockHorizontal) && this.rockHorizontal > 0) {
					var bound:Number = Math.random() * this.rockHorizontal;
//					if (bound < 20) {
//						bound = 0;
//					}
					var pb:Point = new Point(bound, i % 2);
					_boundList.push(pb);
				}
				
				_pointList.push(new Point(xValue + bound, -80));
				_bmDrawIndexList.push(Math.random() * this.bitmapDataList.length);
			}
			
			super.play();
			
			var tween:Tween;
			if(this.playReversed) {
				tween = new Tween(this, 1, 0, duration);
				tween.easingFunction = Linear.easeNone;
			} else {
				tween= new Tween(this, 0, 1, duration);
				tween.easingFunction = Linear.easeNone;
			}
			
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
				
				
				if (percent > 1.2) {
					continue;
				}
				
				var startX:Number = Number(_startXList[i]);
				var bound:Point = Point(this._boundList[i]);
				
				if (!isNaN(this.rockHorizontal) && this.rockHorizontal != 0 && bound.x != 0) {
					var isChanged:Boolean = false;
					if (bound.y == RIGHT && (point.x - startX > bound.x)) {
						bound.y = LEFT;
						isChanged = true;
					} else if (bound.y == LEFT && (startX - point.x > bound.x)) {
						bound.y = RIGHT;
						isChanged = true;
					}
					
					var dist:Number = Math.max(2, bound.x - Math.abs(startX - point.x));
					
					if (!isChanged && dist == 2) {
						dist = 100;
						if (bound.y == RIGHT) {
							bound.y = LEFT;
						} else if (bound.y == LEFT) {
							bound.y = RIGHT;
						}						
					}
					
					if (bound.y == RIGHT) {
						point.x = point.x + dist * 0.03;
					} else {
						point.x = point.x - dist * 0.03;
					}
						//dist = bound.x - startX + point.x;
						//point.x = point.x - dist * 0.02;					
					//}
				}
				
				point.y = percent * uiTarget.height - 80;
				
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