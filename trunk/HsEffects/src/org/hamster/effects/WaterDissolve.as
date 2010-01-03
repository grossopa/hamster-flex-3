package org.hamster.effects
{
	import mx.effects.Fade;
	import mx.effects.IEffectInstance;
	
	import org.hamster.effects.effectInstance.WaterDissolveInstance;

	/**
	 * This is a water disslove effect.
	 * 
	 * <p>This class will affect <code>alpha, DisplacementMapFilter, BlurFilter</code>, 
	 * if the target have DisplacementMapFilter or BlurFilter, they will be removed
	 * during animation.</p>.
	 * 
	 * @see org.hamster.effects.effectInstance.WaterDissolveInstance
	 */
	public class WaterDissolve extends Fade
	{
		/**
		 * @private
		 */
		public function WaterDissolve(target:Object=null)
		{
			super(target);
			this.alphaFrom = 1;
			this.alphaTo = 0;
			this.instanceClass = WaterDissolveInstance;
		}
		
	}
}