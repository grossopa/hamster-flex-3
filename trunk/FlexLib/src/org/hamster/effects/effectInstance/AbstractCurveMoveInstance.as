package org.hamster.effects.effectInstance
{
	import mx.core.mx_internal;
	import mx.effects.Tween;
	import mx.effects.effectClasses.TweenEffectInstance;
	import mx.events.TweenEvent;
	
	use namespace mx_internal;
	
	/**
	 * @author Jack Yin grossopaforever@gmail.com
	 * 
	 */
	public class AbstractCurveMoveInstance extends TweenEffectInstance
	{
		
		public function AbstractCurveMoveInstance(target:Object)
		{
			super(target);
		}
		
		override public function play():void
		{
			super.play();
			if(this.playReversed) {
				new Tween(this, 1, 0, duration);
			} else {
				new Tween(this, 0, 1, duration);
			}
		}
		
		override public function onTweenUpdate(value:Object):void
		{
			this.dispatchEvent(new TweenEvent(TweenEvent.TWEEN_UPDATE));
		}
		
	}
}