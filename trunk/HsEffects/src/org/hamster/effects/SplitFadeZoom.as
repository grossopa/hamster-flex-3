package org.hamster.effects
{
	import mx.effects.IEffectInstance;
	
	import org.hamster.effects.effectInstance.SplitFadeZoomInstance;
	
	public class SplitFadeZoom extends Split
	{
		public var zoomFrom:Number = 1;
		public var zoomTo:Number = 1;
		public var fadeFrom:Number = 1;
		public var fadeTo:Number = 1;
		
		public function SplitFadeZoom(target:Object=null)
		{
			super(target);
			
			this.instanceClass = SplitFadeZoomInstance;
		}
		
		override public function createInstance(target:Object=null):IEffectInstance
		{
			var inst:SplitFadeZoomInstance = SplitFadeZoomInstance(super.createInstance(target));
			
			inst.fadeFrom = fadeFrom;
			inst.fadeTo = fadeTo;
			inst.zoomFrom = zoomFrom;
			inst.zoomTo = zoomTo;
			
			return inst;
		}
		
	}
}