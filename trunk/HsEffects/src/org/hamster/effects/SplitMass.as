package org.hamster.effects
{
	import flash.geom.Point;
	
	import mx.effects.IEffectInstance;
	
	import org.hamster.effects.effectInstance.SplitMassInstance;
	
	/**
	 * <p>A bitmap animation to split UIComponent object into blocks 
	 * and do move with different directions.</p>
	 * 
	 */
	public class SplitMass extends Split
	{
		/**
		 * All blocks will start moving from one point.
		 */
		public static const FROM_ONE_POINT:String = "fromOnePoint";
		
		/**
		 * All blocks will start moving from different point.
		 */
		public static const FROM_POINTS:String = "fromPoints";
		
		/**
		 * <p>Animation type, possible values are <code>FROM_ONE_POINT</code> and <code>FROM_POINTS</code>.</p>
		 * 
		 * <p>Default value is <code>FROM_ONE_POINT</code>.</p>
		 */
		public var aniType:String = FROM_ONE_POINT;
		
		/**
		 * <p>Start point value.  You should specify this value before play if use FROM_ONE_POINT</p>.
		 */
		public var startPoint:Point;
		
		/**
		 * <p>Start points value array. If you use FROM_POINTS and leave it empty, the instance class
		 * will auto create a random points array whose length is equals to 
		 * <code>rowCount</code> * <code>columnCount</code>.</p>
		 */
		public var startPoints:Array;
		
		/**
		 * constructor
		 */
		public function SplitMass(target:Object=null)
		{
			super(target);
			
			this.instanceClass = SplitMassInstance;
		}
		
		/**
		 * override
		 */
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