package org.hamster.effects
{
	import mx.effects.TweenEffect;
	
	import org.hamster.effects.effectInstance.AbstractCurveMoveInstance;
	
	/**
	 * @author Jack Yin grossopaforever@gmail.com
	 */
	public class AbstractCurveMove extends TweenEffect
	{
		public function AbstractCurveMove(target:Object = null)
		{
			super(target);
			this.instanceClass = AbstractCurveMoveInstance;
		}
		
		override public function getAffectedProperties():Array 
		{  
			return ["x", "y"];  
		}  
		
	}
}