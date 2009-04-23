package org.hamster.effects
{
	import mx.effects.IEffectInstance;
	
	import org.hamster.effects.effectInstance.SinMoveInstance;
	
	/**
	 * @author Jack Yin grossopaforever@gmail.com
	 * 
	 * this is a tween effect for move according y = a * sin(b * (x + c)) + d;
	 */
	public class SinMove extends AbstractCurveMove
	{
		public var a:Number;
		public var b:Number;
		public var c:Number;
		public var d:Number;
		
		public var xFrom:Number;
		public var xTo:Number;
		
		public function SinMove(target:Object=null)
		{
			super(target);
			this.instanceClass = SinMoveInstance;
		}
		
		override protected function initInstance(instance:IEffectInstance):void
		{
			super.initInstance(instance);
			var inst:SinMoveInstance = SinMoveInstance(instance);
			inst.a = this.a;
			inst.b = this.b;
			inst.c = this.c;
			inst.d = this.d;
			inst.xFrom = this.xFrom;
			inst.xTo = this.xTo;
		}
		
	}
}