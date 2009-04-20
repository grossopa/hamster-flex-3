package org.hamster.effects.advancedviewstack
{
	import org.hamster.components.AdvancedViewStack;
	import org.hamster.effects.advancedviewstack.base.AbstractAdvancedViewStackEffect;
	import org.hamster.effects.advancedviewstack.base.IAdvancedViewStackEffect;
	
	import mx.effects.Fade;
	import mx.effects.Move;
	import mx.effects.Parallel;
	import mx.effects.Zoom;
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 */
	 
	public class FadeScaleAVS extends AbstractAdvancedViewStackEffect 
	{
		public function FadeScaleAVS(arg:AdvancedViewStack)
		{
			super(arg);
			_isQueue = true;
		}
		
		override public function advInitFunction(imgs1:Array, imgs2:Array):void
		{
			
		}
		
		override public function initAnimation():void
		{
			var parallel1:Parallel = new Parallel();
			var fade1:Fade = new Fade();
			fade1.alphaTo = 0;
			var move1:Move = new Move();
			move1.xTo = advViewStack.width >> 1;
			move1.yTo = advViewStack.height;
			var zoom1:Zoom = new Zoom();
			zoom1.zoomHeightFrom = 1;
			zoom1.zoomHeightTo = 0;
			zoom1.zoomWidthFrom = 1;
			zoom1.zoomWidthTo = 0;
			parallel1.addChild(fade1);
			parallel1.addChild(move1);
			parallel1.addChild(zoom1);
			
			var parallel2:Parallel = new Parallel();
			var fade2:Fade = new Fade();
			fade2.alphaTo = 1;
			var move2:Move = new Move();
			move2.xFrom = advViewStack.width >> 1;
			move2.yFrom = advViewStack.height;
			move2.xTo = 0;
			move2.yTo = 0;
			var zoom2:Zoom = new Zoom();
			zoom2.zoomHeightFrom = 0;
			zoom2.zoomHeightTo = 1;
			zoom2.zoomWidthFrom = 0;
			zoom2.zoomWidthTo = 1;
			parallel2.addChild(fade2);
			parallel2.addChild(move2);
			parallel2.addChild(zoom2);
			
			_eff1 = [parallel1];
			_eff2 = [parallel2];
		}
		
	}
}