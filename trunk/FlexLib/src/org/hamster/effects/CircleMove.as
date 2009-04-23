package org.hamster.effects
{
	import mx.effects.IEffectInstance;
	
	import org.hamster.effects.effectInstance.CircleMoveInstance;
	import org.hamster.errors.TodoError;
	
	public class CircleMove extends AbstractCurveMove
	{
		public var radius:Number;
		
		public function CircleMove(target:Object=null)
		{
			super(target);
			throw new TodoError();
			this.instanceClass = CircleMoveInstance;
		}
		
		override protected function initInstance(instance:IEffectInstance):void
		{
			
		} 
		
	}
}