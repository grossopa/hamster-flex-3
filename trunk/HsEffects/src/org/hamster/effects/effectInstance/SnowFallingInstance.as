package org.hamster.effects.effectInstance
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	import mx.effects.effectClasses.TweenEffectInstance;
	
	/**
	 * Instance class of SnowFalling. You do not create the instance manually.
	 * 
	 * 
	 * @see org.hamster.effects.SnowFalling
	 */
	public class SnowFallingInstance extends TweenEffectInstance
	{
		/**
		 * @private
		 * 
		 * a temporary bitmapData object for drawing work.
		 */
		private var _bmDraw:BitmapData;
		
		/**
		 * @private
		 * 
		 * Stores a list of start delay value.
		 * 
		 * <p>Each piece will have a start delay value, the value ranges from [0, 1 - dropDuration / duration].
		 * if current duration percent is smaller than <code>startDelay</code> or larger than 
		 * <code>startDelay + dropDuration / duration</code>, then do nothing else treat it as a playing piece.</p>
		 * 
		 */
		private var _startDelayList:Array;
		
		/**
		 * @private
		 * 
		 * Stores a list of start x value.
		 * 
		 * <p>Original x values of each piece is randomly defined, range from [0, target.width],
	 	 * and stored in <code>_startXList<code>. Original y is max height of all bitmapData.</p>
		 */
		private var _startXList:Array;
		
		/**
		 * @private
		 * 
		 * Stores bound and speed information.
		 * 
		 * <p>Contains a Point list, x means bound and y means speed.</p>
		 */
		private var _boundList:Array;
		
		/**
		 * @private
		 * 
		 * Stores location value of each piece.
		 */
		private var _pointList:Array;
		
		/**
		 * @private
		 * 
		 * Stores a random sequence bitmapData index.
		 * 
		 * <p>The index value range from 0 to <code>bitmapDataList.length - 1</code>, for using different
		 * piece style during falling.</p>
		 */
		private var _bmDrawIndexList:Array;
		
		/**
		 * @private
		 * 
		 * Equals <code>this.dropDuration / this.duration</code>. It's a temporary attribute.
		 */
		private var _dropPercent:Number;
		
		/**
		 * @private
		 * 
		 * Max height value of bitmapData list.
		 */
		private var _maxBdHeight:Number = 0;
		
		/**
		 * Contains a list of bitmapData.
		 * 
		 * <p>You must add at least one bitmapData. If you input several bitmapData,
		 * it will drop all of them randomly during playing.</p>
		 */
		public var bitmapDataList:Array;
	
		/**
		 * Drop duration of each pieces.
		 * 
		 * <p>Default value is 500.</p>
		 */
		public var dropDuration:Number;
		
		/**
		 * Interval duration between one and another pieces.
		 * 
		 * <p>The pieces are dropping one after another, so the intervalDuration
		 * is the duration of one and the next one.</p>
		 * 
		 * <p>Default value is 100.</p>
		 */
		public var intervalDuration:Number;
		
		/**
		 * Wind to control direction of falling pieces.
		 * 
		 * <p>Like winds in nature, the wind will add an offset value while pieces are falling.
		 * If the value is larger than 0 then the direction is right, if less than 0 then the direction
		 * is left.</p>
		 * 
		 * <p>Default value is 0, recommended value is in [-0.5, 0.5].</p>
		 */
		public var wind:Number;
		
		/**
		 * Horizontal rock range.
		 * 
		 * <p>The piece will move from left to right and then move back 
		 * duration animation.</p>
		 * 
		 * <p>Default value is 0, recommended value is in [0, 10].</p>
		 */
		public var rockHorizontal:Number;
		
		/**
		 * Horizontal rock speed.
		 * 
		 * <p>Horizontal rock speed value, if you want each piece to rock during
		 * falling, then you must set <code>rockSpeed</code> to a non-zero value.</p>
		 * 
		 * <p>Default value is 0, Recommended value is in [0, 0.1].</p>
		 */
		public var rockSpeed:Number;
		
		/**
		 * @private
		 * 
		 * Return target as UIComponent.
		 */
		public function get uiTarget():UIComponent
		{
			return UIComponent(target);
		}
		
		/**
		 * @private
		 */
		public function SnowFallingInstance(target:Object)
		{
			super(target);
		}
		
		/**
		 * @private
		 */
		override public function play():void
		{
			// initialize
			this._startDelayList 	= new Array();
			this._pointList 		= new Array();
			this._bmDrawIndexList 	= new Array();
			this._startXList 		= new Array();
			this._boundList 		= new Array();
			
			// count the total number of piece
			var count:int = int(this.duration / intervalDuration);
			
			this._dropPercent = this.dropDuration / this.duration;
			
			// find the max height of bitmapData List
			for each (var bd:BitmapData in this.bitmapDataList) {
				_maxBdHeight = Math.max(_maxBdHeight, bd.height);
			}	
			
			for (var i:int = 0; i < count; i++) {
				// push start delay value
				_startDelayList.push(i / count);
				// randomly generate originX
				var xValue:Number = Math.random() * uiTarget.width;
				_startXList.push(xValue);
				
				var bound:Number = 0;
				if (!isNaN(this.rockHorizontal) && this.rockHorizontal > 0) {
					bound = Math.random() * this.rockHorizontal;
					
					// the bound should not be too small.
					bound = Math.max(3, bound);
					
					var pb:Point = new Point(bound, (0.5 - Math.random()) * bound);
					_boundList.push(pb);
				}
				
				_pointList.push(new Point(xValue + bound, - _maxBdHeight));
				_bmDrawIndexList.push(Math.random() * this.bitmapDataList.length);
			}
			
			super.play();
			
			tween = createTween(this, 0, 1, duration);
		}
		
		/**
		 * @private
		 */
		override public function onTweenUpdate(value:Object):void
		{
			super.onTweenUpdate(value);
			
			var numValue:Number = Number(value);
			
			_bmDraw = new BitmapData(uiTarget.width, uiTarget.height, true, 0x00);
			// lock main palette for performance
			_bmDraw.lock();
			for (var i:int = 0; i < _pointList.length; i++) {
				var startDelay:Number = Number(_startDelayList[i]);
				// not started, skip
				if (startDelay > numValue) {
					continue;
				}
				var point:Point = Point(_pointList[i]);
				var percent:Number = (numValue - startDelay) / _dropPercent;
				
				// finished falling, skip
				if (percent > 1) {
					continue;
				}
				
				var startX:Number = Number(_startXList[i]);
				var bound:Point = Point(this._boundList[i]);
				var dist:Number = Math.abs(startX - point.x);
				
				// if rock
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
				
				// offset
				point.x += wind;
				point.y = percent * (uiTarget.height + _maxBdHeight * 2) - _maxBdHeight;
				
				var bd:BitmapData = BitmapData(this.bitmapDataList[int(_bmDrawIndexList[i])]);
				_bmDraw.copyPixels(bd,bd.rect, point, null, null, true);
			}
			
			// unlock and begin draw
			_bmDraw.unlock();
			
			var g:Graphics = this.uiTarget.graphics;
			g.clear();
			g.beginBitmapFill(_bmDraw);
			g.drawRect(0, 0, this.uiTarget.width, this.uiTarget.height);
			g.endFill();
		}
		
		

	}
}