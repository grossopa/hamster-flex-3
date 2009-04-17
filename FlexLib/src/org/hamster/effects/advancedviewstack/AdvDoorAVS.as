package org.hamster.effects.advancedviewstack
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.hamster.components.AdvancedViewStack;
	import org.hamster.effects.SkewEffect;
	import org.hamster.effects.advancedviewstack.base.AbstractAdvancedViewStackEffect;
	import org.hamster.utils.ImageUtil;
	import org.hamster.utils.SkewUtil;
	
	import mx.controls.Image;
	import mx.effects.Fade;
	import mx.effects.Parallel;

	public class AdvDoorAVS extends AbstractAdvancedViewStackEffect
	{
		public var skew11:SkewUtil;
		public var skew12:SkewUtil;
		public var skew21:SkewUtil;
		public var skew22:SkewUtil;
		
		public function AdvDoorAVS(arg:AdvancedViewStack)
		{
			super(arg);
			_isQueue = false;
		}
		
		override public function get type():String {
			return "AdvDoorAVS";
		}
		
		override public function advInitFunction(imgs1:Array, imgs2:Array):void
		{
			var img1:Image = Image(imgs1.pop());
			var img2:Image = Image(imgs2.pop());
			
			var rect1:Rectangle = new Rectangle(0,0, img1.width / 2, img1.height);
			var rect2:Rectangle = new Rectangle(img1.width / 2, 0, img1.width / 2, img1.height); 
			var img11:Image = ImageUtil.splitImage(img1, rect1, new Point(0, 0));
			var img12:Image = ImageUtil.splitImage(img1, rect2, new Point(0, 0));
			var img21:Image = ImageUtil.splitImage(img2, rect1, new Point(0, 0));
			var img22:Image = ImageUtil.splitImage(img2, rect2, new Point(0, 0));
			
			imgs1.push(img11);
			imgs1.push(img12);
			imgs2.push(img21);
			imgs2.push(img22);
			
			skew11 = new SkewUtil(advViewStack, img11, 5, 5);
			skew12 = new SkewUtil(advViewStack, img12, 5, 5);
			skew21 = new SkewUtil(advViewStack, img21, 5, 5);
			skew22 = new SkewUtil(advViewStack, img22, 5, 5);
			
			for each(var img:Image in imgs2) {
				img.visible = false;
			}
			for each(img in imgs1) {
				img.visible = false;
			}
		}
		
		override public function initAnimation():void
		{
			var width:Number = this.advViewStack.width;
			var height:Number = this.advViewStack.height;
			
			var p1:Parallel = new Parallel();
			var p2:Parallel = new Parallel();
			
			var skewEff11:SkewEffect = new SkewEffect();
			var skewEff12:SkewEffect = new SkewEffect();
			var skewEff21:SkewEffect = new SkewEffect();
			var skewEff22:SkewEffect = new SkewEffect();
			
			skewEff11.skew = skew11;
			skewEff12.skew = skew12;
			skewEff21.skew = skew21;
			skewEff22.skew = skew22;
			
			skewEff11.x0From 	= 0;
			skewEff11.x0To 		= 0;
			skewEff11.y0From 	= 0;
			skewEff11.y0To 		= 0;
			skewEff11.x1From 	= width / 2;
			skewEff11.x1To 		= 0;
			skewEff11.y1From 	= 0;
			skewEff11.y1To 		= height / 4;
			skewEff11.x2From 	= width / 2;
			skewEff11.x2To 		= 0;
			skewEff11.y2From 	= height;
			skewEff11.y2To 		= height / 4 * 3;
			skewEff11.x3From 	= 0;
			skewEff11.x3To 		= 0;
			skewEff11.y3From 	= height;
			skewEff11.y3To 		= height;
			
			skewEff12.x0From 	= width / 2;
			skewEff12.x0To 		= width;
			skewEff12.y0From 	= 0;
			skewEff12.y0To 		= height / 4;
			skewEff12.x1From 	= width;
			skewEff12.x1To 		= width;
			skewEff12.y1From 	= 0;
			skewEff12.y1To 		= 0;
			skewEff12.x2From 	= width;
			skewEff12.x2To 		= width;
			skewEff12.y2From 	= height;
			skewEff12.y2To 		= height;
			skewEff12.x3From 	= width / 2;
			skewEff12.x3To 		= width;
			skewEff12.y3From 	= height;
			skewEff12.y3To 		= height / 4 * 3;
			
			skewEff21.x0To 		= 0;
			skewEff21.x0From 	= 0;
			skewEff21.y0To 		= 0;
			skewEff21.y0From 	= 0;
			skewEff21.x1To 		= width / 2;
			skewEff21.x1From 	= 0;
			skewEff21.y1To 		= 0;
			skewEff21.y1From 	= height / 4;
			skewEff21.x2To 		= width / 2;
			skewEff21.x2From 	= 0;
			skewEff21.y2To 		= height;
			skewEff21.y2From 	= height / 4 * 3;
			skewEff21.x3To 		= 0;
			skewEff21.x3From 	= 0;
			skewEff21.y3To 		= height;
			skewEff21.y3From	= height;
			
			skewEff22.x0To		= width / 2;
			skewEff22.x0From	= width;
			skewEff22.y0To		= 0;
			skewEff22.y0From	= height / 4;
			skewEff22.x1To		= width;
			skewEff22.x1From	= width;
			skewEff22.y1To		= 0;
			skewEff22.y1From	= 0;
			skewEff22.x2To		= width;
			skewEff22.x2From	= width;
			skewEff22.y2To		= height;
			skewEff22.y2From	= height;
			skewEff22.x3To		= width / 2;
			skewEff22.x3From	= width;
			skewEff22.y3To		= height;
			skewEff22.y3From 	= height / 4 * 3;
			
			p1.addChild(skewEff11);
			p1.addChild(skewEff12);
			p2.addChild(skewEff21);
			p2.addChild(skewEff22);
			
			_eff1 = [p1];
			_eff2 = [p2];
			
		}
		
	}
}