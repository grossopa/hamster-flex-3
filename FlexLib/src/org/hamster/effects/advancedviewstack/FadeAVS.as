package org.hamster.effects.advancedviewstack
{
	import org.hamster.components.AdvancedViewStack;
	import org.hamster.effects.advancedviewstack.base.AbstractAdvancedViewStackEffect;
	import org.hamster.effects.advancedviewstack.base.IAdvancedViewStackEffect;
	
	import mx.effects.Fade;
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 */
	 
	public class FadeAVS extends AbstractAdvancedViewStackEffect 
	{
		public function FadeAVS(arg:AdvancedViewStack)
		{
			super(arg);
		}
		
		override public function get type():String
		{
			return "Fade";
		}
		
		override public function advInitFunction(imgs1:Array, imgs2:Array):void
		{
		}
		
		override public function initAnimation():void
		{
			var fade1:Fade = new Fade();
			fade1.alphaFrom = 1;
			fade1.alphaTo = 0;
			
			var fade2:Fade = new Fade();
			fade2.alphaFrom = 0;
			fade2.alphaTo = 1;
			
			_eff1 = [fade1];
			_eff2 = [fade2];		
		}
		
	}
}