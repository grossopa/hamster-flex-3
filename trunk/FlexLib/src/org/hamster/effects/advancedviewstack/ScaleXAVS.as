package org.hamster.effects.advancedviewstack
{
	import org.hamster.components.AdvancedViewStack;
	import org.hamster.effects.advancedviewstack.base.AbstractAdvancedViewStackEffect;
	import org.hamster.effects.advancedviewstack.base.IAdvancedViewStackEffect;
	
	import mx.effects.AnimateProperty;
	import mx.effects.Move;
	import mx.effects.Parallel;
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 */
	 
	public class ScaleXAVS extends AbstractAdvancedViewStackEffect 
	{
		public function ScaleXAVS(arg:AdvancedViewStack)
		{
			super(arg);
		}
		
		override public function get type():String
		{
			return "Zoom";
		}
		
		override public function advInitFunction(imgs1:Array, imgs2:Array):void
		{
		}
		
		override public function initAnimation():void
		{
			var pa1:Parallel = new Parallel();
			var ap1:AnimateProperty = new AnimateProperty();
			ap1.property = "scaleX";
			ap1.fromValue = 1;
			ap1.toValue = 0;
			var move1:Move = new Move();
			if(advViewStack.direction == AdvancedViewStack.TURN_RIGHT) {
				move1.xFrom = 0;
				move1.xTo = advViewStack.width;
			}
			pa1.addChild(ap1);
			pa1.addChild(move1);
			
			var pa2:Parallel = new Parallel();
			var ap2:AnimateProperty = new AnimateProperty();
			ap2.property = "scaleX";
			ap2.fromValue = 0;
			ap2.toValue = 1;
			var move2:Move = new Move();
			if(advViewStack.direction == AdvancedViewStack.TURN_LEFT) {
				move2.xFrom = advViewStack.width;
				move2.xTo = 0;
			}
			pa2.addChild(ap2);
			pa2.addChild(move2);
			
			_eff1 = [pa1];
			_eff2 = [pa2];
			
			
		}
		
	}
}