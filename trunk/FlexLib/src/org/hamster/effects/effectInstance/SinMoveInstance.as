package org.hamster.effects.effectInstance
{
	import mx.effects.Move;
	import mx.effects.Tween;
	
	
	/**
	 * @author Jack Yin grossopaforever@gmail.com
	 * 
	 */
	public class SinMoveInstance extends AbstractCurveMoveInstance
	{
		public var a:Number;
		public var b:Number;
		public var c:Number;
		public var d:Number;
		
		public var xFrom:Number;
		public var xTo:Number;
		
		public function SinMoveInstance(target:Object)
		{
			super(target);
		}
		
		override public function play():void
		{
			if(isNaN(a)) a = 0;
			if(isNaN(b)) b = 0;
			if(isNaN(c)) c = 0;
			if(isNaN(d)) d = 0;
			if(isNaN(xFrom)) xFrom = target.x;
			super.play();
		}
		
		override public function onTweenUpdate(value:Object):void
		{
			// value is from 0 to 1
			var val:Number = Number(value);
			
			var curX:Number = this.xFrom + val * (this.xTo - this.xFrom);
			target.x = curX;
			target.y = a * Math.sin(b * curX + c) + d;
		}
		
	}
}