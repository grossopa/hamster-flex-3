package org.hamster.effects
{
	import mx.effects.IEffectInstance;
	
	import org.hamster.effects.effectInstance.ArchimedesSpiralMoveInstance;
	
	/**
	 * @author Jack Yin grossopaforever@gmail.com
	 * 
	 * x = cos(angle) * a * angle
	 * y = sin(angle) * a * angle
	 */
	public class ArchimedesSpiralMove extends AbstractCurveMove
	{
		public var a:Number;
		public var oX:Number;
		public var oY:Number;
		public var angleFrom:Number;
		public var angleTo:Number;
		
		public function ArchimedesSpiralMove(target:Object=null)
		{
			super(target);
			this.instanceClass = ArchimedesSpiralMoveInstance;
		}
		
		override protected function initInstance(instance:IEffectInstance):void
		{
			super.initInstance(instance);
			var inst:ArchimedesSpiralMoveInstance 
					= ArchimedesSpiralMoveInstance(instance);
			inst.a = this.a;
			inst.oX = this.oX;
			inst.oY = this.oY;
			inst.angleFrom = this.angleFrom;
			inst.angleTo = this.angleTo;
		} 
		
	}
}