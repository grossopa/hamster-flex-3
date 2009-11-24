package org.hamster.effects
{
	import mx.effects.IEffectInstance;
	
	import org.hamster.effects.effectInstance.SplitMoveInstance;
	
	public class SplitMove extends Split
	{
		public function SplitMove(target:Object=null)
		{
			super(target);
			
			this.instanceClass = SplitMoveInstance;
		}
		
		override public function createInstance(target:Object=null):IEffectInstance
		{
			var inst:SplitMoveInstance = SplitMoveInstance(super.createInstance(target));
			
			return inst;
		}
		
	}
}