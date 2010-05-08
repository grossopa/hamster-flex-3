package org.hamster.effects.utils
{
	import flash.display.DisplayObject;
	
	import mx.core.Application;
	import mx.core.Container;
	import mx.effects.Effect;
	import mx.effects.IEffect;
	import mx.events.EffectEvent;

	public class HsEffectUtil
	{
		public function HsEffectUtil()
		{
		}
		
		/**
		 * play an effect, from fromContainer to toContainer,
		 * and tween in effectContainer. used when the position of targets 
		 * will be changed during effects and the targets wants to jump from one target to
		 * another target.
		 * 
		 * FIXME : add other EffectEvent.EFFECT_END listener after calling playBetweenContainers
		 * function.
		 *  
		 * @param toContainer target container
		 * @param effectContainer default value is Application.application
		 * @param fromContainer default value is targets.parents
		 * 
		 */
		public static function playBetweenContainers(
			targets:Array,
			effect:IEffect,
			toContainer:Container, 
			effectContainer:Container = null,
			playReversedFromEnd:Boolean = false):void 
		{
			if (effectContainer == null) {
				effectContainer = Container(Application.application);
			}
			
			for each (var disObj:DisplayObject in targets) {
				if (disObj.parent != null) {
					disObj.x = disObj.x + disObj.parent.x - effectContainer.x;
					disObj.y = disObj.y + disObj.parent.y - effectContainer.y;
				}
				effectContainer.addChild(disObj);
			}
			
			var effEndFunc:Function = function (evt:EffectEvent):void
			{
				if (toContainer == null) {
					// to container is null, do nothing but return.
					return;
				}
				effect.removeEventListener(EffectEvent.EFFECT_END, effEndFunc);
				for each (var disObj:DisplayObject in targets) {
					disObj.x = disObj.x + disObj.parent.x - toContainer.x;
					disObj.y = disObj.y + disObj.parent.y - toContainer.y;
					toContainer.addChild(disObj);
				}
			};
			effect.addEventListener(EffectEvent.EFFECT_END, effEndFunc, false, int.MAX_VALUE);
			effect.play(targets, playReversedFromEnd);
		}
	}
}