package org.hamster.effects.advancedviewstack
{
	import org.hamster.components.AdvancedViewStack;
	import org.hamster.effects.advancedviewstack.base.AbstractAdvancedViewStackEffect;
	import org.hamster.effects.advancedviewstack.base.IAdvancedViewStackEffect;
	
	import mx.effects.AnimateProperty;
	import mx.effects.Fade;
	import mx.effects.Parallel;
	import mx.effects.Rotate;
	import mx.effects.Zoom;
	import mx.effects.easing.Linear;
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 */
	 
	public class RotateScaleYAVS extends AbstractAdvancedViewStackEffect 
	{
		public function RotateScaleYAVS(arg:AdvancedViewStack)
		{
			super(arg);
			_isQueue = true;
		}
		
		override public function get type():String
		{
			return "RotateScaleY";
		}
		
		override public function advInitFunction(imgs1:Array, imgs2:Array):void
		{
		}
		
		override public function initAnimation():void
		{
			var parallel1:Parallel = new Parallel();
			var rotate1:Rotate = new Rotate();
			rotate1.angleFrom = advViewStack.direction == AdvancedViewStack.TURN_LEFT ? 0 : 360;
			rotate1.angleTo = advViewStack.direction == AdvancedViewStack.TURN_LEFT ? 360 : 0;
			rotate1.originX = advViewStack.width / 2;
			rotate1.originY = advViewStack.height / 2;
			var ap1:AnimateProperty = new AnimateProperty();
			ap1.property = "scaleY";
			ap1.fromValue = 1;
			ap1.toValue = 0;
			parallel1.addChild(rotate1);
			parallel1.addChild(ap1);
			
			var ap2:AnimateProperty = new AnimateProperty();
			ap2.easingFunction = Linear.easeNone;
			ap2.property = "scaleY";
			ap2.fromValue = 0;
			ap2.toValue = 1;
			
			_eff1 = [parallel1];
			_eff2 = [ap2];
		}
		
	}
}