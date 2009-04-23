package org.hamster.effects.effectInstance
{
	import mx.effects.Tween;
	import mx.effects.effectClasses.TweenEffectInstance;
	
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
		
		override public function set target(value:Object):void
		{
			super.target = value;
		}
		
		override public function play():void
		{
			super.play();
			new Tween(this, 0, 1, duration);
		}
		
	}
}