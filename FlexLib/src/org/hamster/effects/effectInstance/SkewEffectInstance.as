package org.hamster.effects.effectInstance
{
	import org.hamster.log.Logger;
	import org.hamster.utils.SkewUtil;
	
	import mx.effects.Tween;
	import mx.effects.effectClasses.TweenEffectInstance;

	public class SkewEffectInstance extends TweenEffectInstance
	{
		public var skew:SkewUtil;
		
		public var x0From:Number = 0;
		public var x0To:Number = 1;
		public var y0From:Number = 0;
		public var y0To:Number = 1;
		public var x1From:Number = 0;
		public var x1To:Number = 1;
		public var y1From:Number = 0;
		public var y1To:Number = 1;
		public var x2From:Number = 0;
		public var x2To:Number = 1;
		public var y2From:Number = 0;
		public var y2To:Number = 1;
		public var x3From:Number = 0;
		public var x3To:Number = 1;
		public var y3From:Number = 0;
		public var y3To:Number = 1;
		
		public function SkewEffectInstance(target:Object)
		{
			super(target);
		}

		override public function play():void {  
			super.play(); 
			new Tween(this, 0, 1, duration);  
		}  
   
		override public function onTweenUpdate(value:Object):void {  
			super.onTweenUpdate(value);
			var val:Number = Number(value);
			var x0:Number = (1 - val) * x0From + val * x0To;
			var x1:Number = (1 - val) * x1From + val * x1To;
			var x2:Number = (1 - val) * x2From + val * x2To;
			var x3:Number = (1 - val) * x3From + val * x3To;
			var y0:Number = (1 - val) * y0From + val * y0To;
			var y1:Number = (1 - val) * y1From + val * y1To;
			var y2:Number = (1 - val) * y2From + val * y2To;
			var y3:Number = (1 - val) * y3From + val * y3To;
			skew.setTransform(x0, y0, x1, y1, x2, y2, x3, y3);
		}  
		
	}
}