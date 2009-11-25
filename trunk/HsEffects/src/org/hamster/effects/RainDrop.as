package org.hamster.effects
{
	import mx.effects.IEffectInstance;
	import mx.effects.TweenEffect;
	
	import org.hamster.effects.effectInstance.RainDropInstance;

	public class RainDrop extends TweenEffect
	{
		public var bitmapDataList:Array;
		
		public var dropDuration:Number = 500;
		public var intervalDuration:Number = 100;
		
		public var windFrom:Number = -5;
		public var windTo:Number = 20;
		
		public var rockHorizontal:Number = 200;
		public var rockSpeed:Number = 0;
		
		public function RainDrop(target:Object=null)
		{
			super(target);
			this.instanceClass = RainDropInstance;
		}
		
		override public function createInstance(target:Object=null):IEffectInstance
		{
			var inst:RainDropInstance = RainDropInstance(super.createInstance(target));
			inst.bitmapDataList = this.bitmapDataList;
			inst.dropDuration = this.dropDuration;
			inst.intervalDuration = this.intervalDuration;
			inst.windFrom = this.windFrom;
			inst.windTo = this.windTo;
			inst.rockHorizontal = this.rockHorizontal;
			inst.rockSpeed = this.rockSpeed;
			
			return inst;
		}
		
		
		
	}
}