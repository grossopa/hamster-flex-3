package org.hamster.effects
{
	import mx.effects.IEffectInstance;
	import mx.effects.TweenEffect;
	
	import org.hamster.effects.effectInstance.SplitInstance;

	public class Split extends TweenEffect
	{
		
		public var rowCount:uint = 3;
		public var columnCount:uint = 3;
		
		public function Split(target:Object=null)
		{
			super(target);
			
			this.instanceClass = SplitInstance;
		}
		
		override protected function initInstance(instance:IEffectInstance):void
		{
			super.initInstance(instance);
			
			var inst:SplitInstance = SplitInstance(instance);
			inst.startDelay = this.startDelay;
			inst.columnCount = this.columnCount;
			inst.rowCount = rowCount;
		}
		
	}
}