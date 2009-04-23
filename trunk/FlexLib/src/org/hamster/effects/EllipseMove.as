package org.hamster.effects
{
	import mx.effects.IEffectInstance;
	
	import org.hamster.effects.effectInstance.EllipseMoveInstance;
	
	/**
	 * @author Jack Yin grossopaforever@gmail.com
	 * 
	 * (x - oX)^2   (y - oY)^2
	 * ---------- + ---------- = 1
	 *     a^2          b^2
	 * 
	 * x = oX + a * cos(angle)
	 * y = oY + b * sin(angle)
	 */
	public class EllipseMove extends AbstractCurveMove
	{
		public var a:Number;
		public var b:Number;
		public var oX:Number;
		public var oY:Number;
		public var angleFrom:Number;
		public var angleTo:Number;
		
		public function EllipseMove(target:Object=null)
		{
			super(target);
			this.instanceClass = EllipseMoveInstance;
		}
		
		override protected function initInstance(instance:IEffectInstance):void
		{
			super.initInstance(instance);
			var inst:EllipseMoveInstance = EllipseMoveInstance(instance);
			inst.a = this.a;
			inst.b = this.b;
			inst.oX = this.oX;
			inst.oY = this.oY;
			inst.angleFrom = this.angleFrom;
			inst.angleTo = this.angleTo;
		} 
		
		
	}
}