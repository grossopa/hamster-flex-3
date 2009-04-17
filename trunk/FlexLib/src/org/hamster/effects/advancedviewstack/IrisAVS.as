package org.hamster.effects.advancedviewstack
{
	import org.hamster.components.AdvancedViewStack;
	import org.hamster.effects.advancedviewstack.base.AbstractAdvancedViewStackEffect;
	import org.hamster.effects.advancedviewstack.base.IAdvancedViewStackEffect;
	
	import mx.effects.Iris;

	public class IrisAVS extends AbstractAdvancedViewStackEffect implements IAdvancedViewStackEffect
	{
		public function IrisAVS(arg:AdvancedViewStack)
		{
			super(arg);
			_isQueue = true;
		}
		
		override public function get type():String
		{
			return "Iris";
		}
		
		override public function advInitFunction(imgs1:Array, imgs2:Array):void
		{
		}
		
		override public function initAnimation():void
		{
			var iris1:Iris = new Iris();
			iris1.showTarget = false;
			
			var iris2:Iris = new Iris();
			iris2.showTarget = true;
			
			_eff1 = [iris1];
			_eff2 = [iris2];
		}
		
	}
}