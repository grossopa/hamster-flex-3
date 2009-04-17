package org.hamster.effects.advancedviewstack
{
	import org.hamster.components.AdvancedViewStack;
	import org.hamster.effects.SkewEffect;
	import org.hamster.effects.advancedviewstack.base.AbstractAdvancedViewStackEffect;
	import org.hamster.log.Logger;
	import org.hamster.utils.SkewUtil;
	
	import mx.controls.Image;

	public class SkewAVS extends AbstractAdvancedViewStackEffect
	{
		private var skew1:SkewUtil;
		private var skew2:SkewUtil;
		
		private var logger:Logger = Logger.getLogger("SkewTest");
		
		public function SkewAVS(arg:AdvancedViewStack)
		{
			super(arg);
			this._isQueue = false;
		}
		
		override public function get type():String
		{
			return "Skew";
		}
		
		override public function advInitFunction(imgs1:Array, imgs2:Array):void
		{
			if(this.leftDirection()) {
				skew2 = new SkewUtil(advViewStack, imgs2[0], 5, 5);
				skew1 = new SkewUtil(advViewStack, imgs1[0], 5 ,5);
			} else {
				skew1 = new SkewUtil(advViewStack, imgs2[0], 5 ,5);
				skew2 = new SkewUtil(advViewStack, imgs1[0], 5, 5);
			}
			for each(var img:Image in imgs2) {
				img.visible = false;
			}
			for each(img in imgs1) {
				img.visible = false;
			}
		}
		
		override public function initAnimation():void
		{
			var height:Number = advViewStack.height;
			var width:Number = advViewStack.width;
			var left:Boolean = this.leftDirection();
			
			var skewEffect1:SkewEffect = new SkewEffect();
			var skewEffect2:SkewEffect = new SkewEffect();
			
			skewEffect1.skew = skew1;
			skewEffect2.skew = skew2;
			var dirCtrl:uint = left ? 0 : 1;
			
			skewEffect1.x0From 	= 0;
			skewEffect1.x0To 	= 0;
			skewEffect1.y0From 	= dirCtrl * height / 2;
			skewEffect1.y0To 	= (1 - dirCtrl) * height / 2;
			skewEffect1.x1From 	= width * (1 - dirCtrl);
			skewEffect1.x1To 	= width * dirCtrl;
			skewEffect1.y1From 	= 0;
			skewEffect1.y1To 	= 0;
			skewEffect1.x2From 	= width * (1 - dirCtrl);
			skewEffect1.x2To 	= width * dirCtrl;
			skewEffect1.y2From 	= height;
			skewEffect1.y2To 	= height;
			skewEffect1.x3From 	= 0;
			skewEffect1.x3To 	= 0;
			skewEffect1.y3From 	= (2 - dirCtrl) * height / 2;
			skewEffect1.y3To 	= (1 + dirCtrl) * height / 2;
			
			skewEffect2.x0From 	= width * (1 - dirCtrl);
			skewEffect2.x0To 	= width * dirCtrl;
			skewEffect2.y0From 	= 0;
			skewEffect2.y0To 	= 0;
			skewEffect2.x1From 	= width;
			skewEffect2.x1To 	= width;
			skewEffect2.y1From 	= (1 - dirCtrl) * height / 2;
			skewEffect2.y1To 	= (dirCtrl) * height / 2;
			skewEffect2.x2From 	= width;
			skewEffect2.x2To 	= width;
			skewEffect2.y2From 	= (dirCtrl + 1) * height / 2;
			skewEffect2.y2To 	= (2 - dirCtrl) * height / 2;
			skewEffect2.x3From 	= width * (1 - dirCtrl);
			skewEffect2.x3To 	= width * dirCtrl;
			skewEffect2.y3From 	= height;
			skewEffect2.y3To 	= height;
			
			_eff1 = [skewEffect1];
			_eff2 = [skewEffect2];
		}
		
	}
}