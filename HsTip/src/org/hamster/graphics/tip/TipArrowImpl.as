package org.hamster.graphics.tip
{
	import flash.display.Graphics;
	
	public class TipArrowImpl implements ITipArrow
	{
		private var _arrowDirection:uint;
		private var _distanceA:Number;
		private var _distanceB:Number;
		private var _tipHeight:Number;
		
		public var distanceC:Number;
		
		public function TipArrowImpl(dir:uint, a:Number, b:Number, c:Number, h:Number)
		{
			this.arrowDirection = dir;
			this.distanceA = a;
			this.distanceB = b;
			this.distanceC = c;
			this._tipHeight = h;
		}

		public function set arrowDirection(value:uint):void
		{
			this._arrowDirection = value;
		}
		
		public function get arrowDirection():uint
		{
			return this._arrowDirection;
		}
		
		public function set distanceA(value:Number):void
		{
			this._distanceA = value;
		}
		
		public function get distanceA():Number
		{
			return this._distanceA;
		}
		
		public function set distanceB(value:Number):void
		{
			this._distanceB = value;
		}
		
		public function get distanceB():Number
		{
			return this._distanceB;
		}
		
		public function set tipHeight(value:Number):void
		{
			this._tipHeight = value;
		}
		
		public function get tipHeight():Number
		{
			return this._tipHeight;
		}
		
		public function drawTip(g:Graphics,
				startX:Number, startY:Number,
				endX:Number, endY:Number):void
		{
			if (arrowDirection == TipUtil.LEFT) {
				g.lineTo(startX - this.tipHeight, this.distanceC);
			} else if (arrowDirection == TipUtil.TOP) {
				g.lineTo(this.distanceC, startY - this.tipHeight);
			} else if (arrowDirection == TipUtil.RIGHT) {
				g.lineTo(startX + this.tipHeight, this.distanceC);
			} else if (arrowDirection == TipUtil.BOTTOM) {
				g.lineTo(this.distanceC, startY + this.tipHeight);
			}
		}
		
	}
}