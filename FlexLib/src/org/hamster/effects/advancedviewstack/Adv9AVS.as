package org.hamster.effects.advancedviewstack
{
	import mx.effects.Fade;
	import mx.effects.Parallel;
	import mx.effects.Zoom;
	
	import org.hamster.components.AdvancedViewStack;

	/**
	 * @author Jack Yin grossopaforever@gmail.com
	 * 
	 */
	public class Adv9AVS extends AdvSplit9AVS
	{
		public function Adv9AVS(arg:AdvancedViewStack)
		{
			super(arg);
		}
		
		override public function get type():String
		{
			return "Adv9AVS";
		}
		
		override public function initAnimation():void
		{
			var smallWidth:Number = advViewStack.width / 3;
			var smallHeight:Number = advViewStack.height / 3;
			
			var a1:Array = new Array();
			var a2:Array = new Array();
			
			for(var k:int = 0; k < 9; k++) {
				var p1:Parallel = new Parallel();
				var zoom1:Zoom = new Zoom();
				zoom1.zoomHeightFrom = 1;
				zoom1.zoomHeightTo = 0;
				zoom1.zoomWidthFrom = 1;
				zoom1.zoomHeightTo = 0;
				var fade1:Fade = new Fade();
				fade1.alphaFrom = 1;
				fade1.alphaTo = 0;
				p1.addChild(zoom1);
				p1.addChild(fade1);
				a1.push(p1);
								
				var p2:Parallel = new Parallel();
				var zoom2:Zoom = new Zoom();
				zoom2.zoomHeightFrom = 0;
				zoom2.zoomHeightTo = 1;
				zoom2.zoomWidthFrom = 0;
				zoom2.zoomHeightTo = 1;
				var fade2:Fade = new Fade();
				fade2.alphaFrom = 0;
				fade2.alphaTo = 1;
				p2.addChild(zoom2);
				p2.addChild(fade2);
				a2.push(p2);
			}
			
			_eff1 = a1;
			_eff2 = a2;			
		}
		
	}
}