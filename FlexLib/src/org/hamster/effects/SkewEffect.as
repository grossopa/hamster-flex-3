package org.hamster.effects
{
	import flash.display.Graphics;
	
	import mx.effects.IEffectInstance;
	import mx.effects.TweenEffect;
	
	import org.hamster.effects.effectInstance.SkewEffectInstance;
	import org.hamster.utils.SkewUtil;
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 */
	 
	public class SkewEffect extends TweenEffect
	{
		public var skew:SkewUtil;
		
		public var x0From:Number = 0;
		public var x0To:Number = 1;
		public var y0From:Number = 0;
		public var y0To:Number = 1;
		public var x1From:Number = 0;
		public var x1To:Number = 1;
		public var y1From:Number = 0;
		public var y1To:Number = 1;
		public var x2From:Number = 0;
		public var x2To:Number = 1;
		public var y2From:Number = 0;
		public var y2To:Number = 1;
		public var x3From:Number = 0;
		public var x3To:Number = 1;
		public var y3From:Number = 0;
		public var y3To:Number = 1;
		
		public function SkewEffect(target:Object=null)
		{
			super(target);
			instanceClass = SkewEffectInstance;  
		}  
   
		override public function getAffectedProperties():Array{  
			return [];  
		}  
		
		override protected function initInstance(instance:IEffectInstance):void{  
			super.initInstance(instance);  
			SkewEffectInstance(instance).skew = skew;
			SkewEffectInstance(instance).x0From = x0From;
			SkewEffectInstance(instance).x0To = x0To;
			SkewEffectInstance(instance).x1From = x1From;
			SkewEffectInstance(instance).x1To = x1To;
			SkewEffectInstance(instance).x2From = x2From;
			SkewEffectInstance(instance).x2To = x2To;
			SkewEffectInstance(instance).x3From = x3From;
			SkewEffectInstance(instance).x3To = x3To;
			SkewEffectInstance(instance).y0From = y0From;
			SkewEffectInstance(instance).y0To = y0To;
			SkewEffectInstance(instance).y1From = y1From;
			SkewEffectInstance(instance).y1To = y1To;
			SkewEffectInstance(instance).y2From = y2From;
			SkewEffectInstance(instance).y2To = y2To;
			SkewEffectInstance(instance).y3From = y3From;
			SkewEffectInstance(instance).y3To = y3To;
			
         }  
		
	}
}