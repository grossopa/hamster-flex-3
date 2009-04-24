package org.hamster.effects
{
	import mx.effects.IEffectInstance;
	
	import org.hamster.effects.effectInstance.NikeMoveInstance;
	
	/**
	 * @author Jack Yin grossopaforever@gmail.com
	 * 
	 * y = a * x + b / x
	 * 
	 */
	public class NikeMove extends AbstractCurveMove
	{
		public var a:Number;
		public var b:Number;
		public var oX:Number;
		public var oY:Number;
		public var xFrom:Number;
		public var xTo:Number;
		
		public function NikeMove(target:Object=null)
		{
			super(target);
			this.instanceClass = NikeMoveInstance;
		}
		
		override protected function initInstance(instance:IEffectInstance):void
		{
			super.initInstance(instance);
			var inst:NikeMoveInstance = NikeMoveInstance(instance);
			inst.a = this.a;
			inst.b = this.b;
			inst.oX = this.oX;
			inst.oY = this.oY;
			inst.xFrom = this.xFrom;
			inst.xTo = this.xTo;
		}
		
	}
}