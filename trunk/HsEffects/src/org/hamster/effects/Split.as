package org.hamster.effects
{
	import mx.effects.IEffectInstance;
	import mx.effects.TweenEffect;
	
	import org.hamster.effects.effectInstance.SplitInstance;

	/**
	 * <p>This is a abstract bitmapData-based effect class</p>
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
		 * row number of blocks
		 */
		public var rowCount:uint = 3;
		/**
		 * column number of blocks
		 */
		public var columnCount:uint = 3;
		
		/**
		 * constructor 
		 */
		public function Split(target:Object=null)
		{
			super(target);
			
			this.instanceClass = SplitInstance;
		}
		
		/**
		 * initialize instance.
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