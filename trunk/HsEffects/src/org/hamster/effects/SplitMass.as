package org.hamster.effects
{
	import flash.geom.Point;
	
	import mx.effects.IEffectInstance;
	
	import org.hamster.effects.effectInstance.SplitMassInstance;
	
	public class SplitMass extends Split
	{
		public static const FROM_ONE_POINT:String = "fromOnePoint";
		public static const FROM_POINTS:String = "fromPoints";
		
		public var aniType:String = FROM_ONE_POINT;
		public var startPoint:Point;
		public var startPoints:Array;
		
		public function SplitMass(target:Object=null)
		{
			super(target);
			
			this.instanceClass = SplitMassInstance;
		}
		
		override protected function initInstance(instance:IEffectInstance):void
		{
			super.initInstance(instance);
			
			var inst:SplitMassInstance = SplitMassInstance(instance);
			inst.aniType = this.aniType;
			inst.startPoint = this.startPoint;
			inst.startPoints = this.startPoints;
		}
		
	}
}