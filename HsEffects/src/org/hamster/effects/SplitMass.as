package org.hamster.effects
{
	import flash.geom.Point;
	
	import mx.effects.IEffectInstance;
	
	import org.hamster.effects.effectInstance.SplitMassInstance;
	
	/**
	 * A bitmap animation to split UIComponent object into blocks.
	 * 
	 * <p>At the point the effect starts, it will take a bitmapData snapshot of UIComponent target,
	 * remember <code>visible</code> of all children, and set it to <strong>false</strong>.  
	 * Remember <code>backgroundAlpha</code> and set it to 0, 
	 * then create a overlay by using internal method addOverlay(), 
	 * use overlay as bitmap palette. The target is divided into <code>rowCount</code> * <code>columnCount</code>
	 * blocks, each block has a <code>startPoint</code> value and <code>endPoint</code> value. 
	 * The start point values can be defined by user manaually or randomly generated.
	 * End point values is original point of each blocks.</p>
	 * 
	 * <p>Duration effect, location of each block is 
	 * <code>(1 - value) * startPoint + value * endPoint</code>.
	 * Like other tween effects, value is given by easing function.</p>
	 * 
	 * <p>When the effect is end, remove overlay of target, reset <code>backgroundAlpha</code>
	 * and <code>visible</code> of all children.</p>
	 * 
	 * @see org.hamster.effects.effectInstance.Split
	 * @see org.hamster.effects.effectInstance.SplitInstance
	 * @see org.hamster.effects.effectInstance.SplitMassInstance
	 */
	public class SplitMass extends Split
	{
		/**
		 * Start points value array. 
		 * 
		 * <p>If you use FROM_POINTS and leave it empty, the instance class
		 * will auto create a random points array whose length is equals to 
		 * <code>rowCount</code> * <code>columnCount</code>.</p>
		 * 
		 * <p>block number of each start point is 
		 * <code>int(rowCount * columnCount / startPoints.length)</code>. 
		 */
		public var startPoints:Array;
		
		/**
		 * @private
		 */
		public function SplitMass(target:Object=null)
		{
			super(target);
			
			this.instanceClass = SplitMassInstance;
		}
		
		/**
		 * @private
		 */
		override protected function initInstance(instance:IEffectInstance):void
		{
			super.initInstance(instance);
			
			var inst:SplitMassInstance = SplitMassInstance(instance);
			inst.startPoints = this.startPoints;
		}
		
	}
}