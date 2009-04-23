package org.hamster.effects
{
	import mx.effects.IEffectInstance;
	
	import org.hamster.effects.effectInstance.CircleMoveInstance;
	
	public class CircleMove extends AbstractCurveMove
	{
		public var radius:Number;
		public var oX:Number;
		public var oY:Number;
		public var angleFrom:Number;
		public var angleTo:Number;
		
		public function CircleMove(target:Object=null)
		{
			super(target);
			this.instanceClass = CircleMoveInstance;
		}
		
		override protected function initInstance(instance:IEffectInstance):void
		{
			super.initInstance(instance);
			var inst:CircleMoveInstance = CircleMoveInstance(instance);
			inst.radius = this.radius;
			inst.oX = this.oX;
			inst.oY = this.oY;
			inst.angleFrom = this.angleFrom;
			inst.angleTo = this.angleTo;
		} 
		
	}
}