package org.hamster.effects
{
	import mx.effects.IEffectInstance;
	import mx.effects.TweenEffect;
	import mx.effects.easing.Linear;
	
	import org.hamster.effects.effectInstance.SnowFallingInstance;

	/**
	 * This is a bitmap-based effect of snow falling.
	 * 
	 * <p>The target is a bitmap animation container, the effect instance will
	 * draw bitmapData on the canvas, so it's recommended that you create an
	 * empty UIComponent and play effect on it.</p>
	 * 
	 * <p>You must specify the bitmapDataList before play, put different bitmapData
	 * into <code>bitmapDataList</code>.</p>
	 * 
	 * @see org.hamster.effects.effectInstance.SnowFallingInstance
	 * @includeExample examples/SnowFallingExample.mxml
	 */
	public class SnowFalling extends TweenEffect
	{
		/**
		 * Contains a list of bitmapData.
		 * 
		 * <p>You must add at least one bitmapData. If you input several bitmapData,
		 * it will drop all of them randomly during playing.</p>
		 */
		public var bitmapDataList:Array;
		
		/**
		 * Drop duration of each pieces.
		 * 
		 * <p>Default value is 500.</p>
		 */
		public var dropDuration:Number = 500;
		
		/**
		 * Interval duration between one and another pieces.
		 * 
		 * <p>The pieces are dropping one after another, so the intervalDuration
		 * is the duration of one and the next one.</p>
		 * 
		 * <p>Default value is 100.</p>
		 */
		public var intervalDuration:Number = 100;
		
		/**
		 * Wind to control direction of falling pieces.
		 * 
		 * <p>Like winds in nature, the wind will add an offset value while pieces are falling.
		 * If the value is larger than 0 then the direction is right, if less than 0 then the direction
		 * is left.</p>
		 * 
		 * <p>Default value is 0, recommended value is in [-0.5, 0.5].</p>
		 */
		public var wind:Number = 0;
		
		/**
		 * Horizontal rock range.
		 * 
		 * <p>The piece will move from left to right and then move back 
		 * duration animation.</p>
		 * 
		 * <p>Default value is 0, recommended value is in [0, 10].</p>
		 */
		public var rockHorizontal:Number = 0;
		
		/**
		 * Horizontal rock speed.
		 * 
		 * <p>Horizontal rock speed value, if you want each piece to rock during
		 * falling, then you must set <code>rockSpeed</code> to a non-zero value.</p>
		 * 
		 * <p>Default value is 0, Recommended value is in [0, 0.1].</p>
		 */
		public var rockSpeed:Number = 0;
		
		/**
		 * @private
		 */
		public function SnowFalling(target:Object=null)
		{
			super(target);
			
			this.instanceClass = SnowFallingInstance;
			this.easingFunction = Linear.easeNone;
		}
		
		/**
		 * @private
		 */
		override protected function initInstance(instance:IEffectInstance):void
		{
			super.initInstance(instance);
			
			var inst:SnowFallingInstance = SnowFallingInstance(instance);
			
			inst.bitmapDataList = this.bitmapDataList;
			inst.dropDuration = this.dropDuration;
			inst.intervalDuration = this.intervalDuration;
			
			inst.wind = this.wind;
			
			inst.rockHorizontal = this.rockHorizontal;
			inst.rockSpeed = this.rockSpeed;
		}
		
		/**
		 * @private
		 */
		override public function play(targets:Array=null, playReversedFromEnd:Boolean=false):Array
		{
			// if no bitmapData is specified, then do nothing
			if (this.bitmapDataList == null && this.bitmapDataList.length == 0) {
				return [];
			}
			
			return super.play();
		}
		
		
	}
}