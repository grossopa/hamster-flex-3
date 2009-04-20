package org.hamster.effects.advancedviewstack
{
	import org.hamster.components.AdvancedViewStack;
	import org.hamster.effects.advancedviewstack.base.AbstractAdvancedViewStackEffect;
	import org.hamster.effects.advancedviewstack.base.IAdvancedViewStackEffect;
	
	import mx.effects.Move;
	import mx.events.EffectEvent;
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 */
	 	
	public class MoveAVS extends AbstractAdvancedViewStackEffect 
	{
		public function MoveAVS(arg:AdvancedViewStack)
		{
			super(arg);
		}

		override public function get type():String
		{
			return "Move";
		}

		override public function advInitFunction(imgs1:Array, imgs2:Array):void
		{
			
		}
		
		override public function initAnimation():void
		{
			var move1:Move = new Move();
			var move2:Move = new Move();
			move1.xFrom = 0;
			move1.xTo = - advViewStack.direction * advViewStack.width;
			move2.xFrom = advViewStack.direction * advViewStack.width;
			move2.xTo = 0;			
			_eff1 = [move1];
			_eff2 = [move2];		
		}
		
	}
}