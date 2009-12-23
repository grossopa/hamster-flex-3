package org.hamster.effects
{
	import mx.effects.IEffectInstance;
	import mx.effects.TweenEffect;
	
	import org.hamster.effects.effectInstance.SplitInstance;

	/**
	 * This is a abstract bitmapData-based effect class. You may extend this class to implement
	 * you own split animation.
	 * 
	 * <p>It will directly do some operations on UIComponent overlay,
	 * so this effect cannot work with Dissolve or other effects
	 * which are based on overlay.</p>
	 * 
	 * <p>Defaultly, before animation, it will split the target 
	 * UIComponent into several blocks which depends on <code>rowCount</code>
	 * and <code>columnCount</code>, then add a overlay target
	 * by calling UIComponment.mx_internal::addOverlay().</p>
	 * 
	 * <p>In instance class, you should override <code>onTweenUpdate</code>
	 * to draw bitmap blocks.</p>
	 * 
	 * @see org.hamster.effects.effectInstance.SplitInstance
	 */
	public class Split extends TweenEffect
	{
		/**
		 * Row number of blocks.
		 * 
		 * <p>The value should be larger than 0. In my test, the flash player will be hard to
		 * redraw when <code>rowCount</code> * <code>columnCount</code> is larger than 10000.<p>
		 * 
		 * <p>There is an issue when you have to set the value as 10 * 2x + 10 when the value is very big.
		 * Otherwise some mistery line will appear between each block.</p>
		 * 
		 * <p>Default value is 3</p>
		 */
		public var rowCount:uint = 3;
		/**
		 * Column number of blocks.
		 * 
		 * <p>The value should be larger than 0. In my test, the flash player will be hard to
		 * redraw when <code>rowCount</code> * <code>columnCount</code> is larger than 10000.<p>
		 * 
		 * <p>There is an issue when you have to set the value as 10 * 2x + 10 when the value is very big.
		 * Otherwise some mistery line will appear between each block.</p>
		 * 
		 * <p>Default value is 3</p>
		 */
		public var columnCount:uint = 3;
		
		/**
		 * @private
		 */
		public function Split(target:Object=null)
		{
			super(target);
			
			this.instanceClass = SplitInstance;
		}
		
		/**
		 * @private
		 */
		override protected function initInstance(instance:IEffectInstance):void
		{
			super.initInstance(instance);
			
			var inst:SplitInstance = SplitInstance(instance);
			inst.startDelay = this.startDelay;
			inst.columnCount = this.columnCount;
			inst.rowCount = this.rowCount;
		}
		
	}
}