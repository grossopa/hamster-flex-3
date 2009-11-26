package org.hamster.effects
{
	import mx.effects.IEffectInstance;
	import mx.effects.TweenEffect;
	import mx.effects.easing.Linear;
	
	import org.hamster.effects.effectInstance.RainDropInstance;

	public class RainDrop extends TweenEffect
	{
		public var bitmapDataList:Array;
		
		/**
		 * dropDuration of one piece
		 */
		public var dropDuration:Number = 500;
		
		/**
		 * num of pieces = duration / intervalDuration 
		 */
		public var intervalDuration:Number = 100;
		
		/**
		 * 0 ~ 0.5
		 */
		public var wind:Number = 0;
		
		/**
		 * 0 ~ 10
		 */
		public var rockHorizontal:Number = 0;
		/**
		 * 0 ~ 0.1
		 */
		public var rockSpeed:Number = 0;
		
		public function RainDrop(target:Object=null)
		{
			super(target);
			
			this.instanceClass = RainDropInstance;
			this.easingFunction = Linear.easeNone;
		}
		
		override protected function initInstance(instance:IEffectInstance):void
		{
			super.initInstance(instance);
			
			var inst:RainDropInstance = RainDropInstance(instance);
			
			inst.bitmapDataList = this.bitmapDataList;
			inst.dropDuration = this.dropDuration;
			inst.intervalDuration = this.intervalDuration;
			
			inst.wind = this.wind;
			
			inst.rockHorizontal = this.rockHorizontal;
			inst.rockSpeed = this.rockSpeed;
		}
		
		override public function play(targets:Array=null, playReversedFromEnd:Boolean=false):Array
		{
			if (this.bitmapDataList.length == 0) {
				return [];
			}
			
			return super.play();
		}
		
		
	}
}