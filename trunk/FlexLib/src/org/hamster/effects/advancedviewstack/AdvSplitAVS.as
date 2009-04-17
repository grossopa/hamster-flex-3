package org.hamster.effects.advancedviewstack
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.hamster.components.AdvancedViewStack;
	import org.hamster.effects.advancedviewstack.base.AbstractAdvancedViewStackEffect;
	import org.hamster.effects.advancedviewstack.base.IAdvancedViewStackEffect;
	import org.hamster.utils.ImageUtil;
	
	import mx.controls.Image;
	import mx.effects.Fade;
	import mx.effects.Move;
	import mx.effects.Parallel;
	import mx.effects.easing.Linear;

	public class AdvSplitAVS extends AbstractAdvancedViewStackEffect implements IAdvancedViewStackEffect
	{
		public function AdvSplitAVS(arg:AdvancedViewStack)
		{
			super(arg);
			this._isQueue = true;
		}
		
		override public function get type():String
		{
			return "AdvancedSplit";
		}
		
		override public function advInitFunction(imgs1:Array, imgs2:Array):void
		{
			var curImage:Image = imgs1[0] as Image;
			var nextImage:Image = imgs2[0] as Image;
				
			var img11:Image = ImageUtil.splitImage(curImage, 
						new Rectangle(0, 0, advViewStack.width, advViewStack.height >> 1), new Point(0,0));
			var img12:Image = ImageUtil.splitImage(curImage, 
						new Rectangle(0, advViewStack.height >> 1, advViewStack.width, advViewStack.height >> 1), new Point(0,0));
			var img21:Image = ImageUtil.splitImage(nextImage, 
						new Rectangle(0, 0, advViewStack.width, advViewStack.height >> 1), new Point(0,0));
			var img22:Image = ImageUtil.splitImage(nextImage, 
						new Rectangle(0, advViewStack.height >> 1, advViewStack.width, advViewStack.height >> 1), new Point(0,0));
				
			img12.y = advViewStack.height >> 1;
			img22.y = advViewStack.height >> 1;
				
			imgs1.pop();
			imgs1.push(img11);
			imgs1.push(img12);
			imgs2.pop();
			imgs2.push(img21);
			imgs2.push(img22);		
		}
		
		override public function initAnimation():void
		{
			var par11:Parallel = new Parallel();
			var par12:Parallel = new Parallel();
			
			var move11:Move = new Move();
			move11.yFrom = 0;
			move11.yTo = - advViewStack.height / 2;
			move11.easingFunction = Linear.easeOut;
			var fade1:Fade = new Fade();
			fade1.alphaFrom = 1;
			fade1.alphaTo = 0;
			var move12:Move = new Move();
			move12.yFrom = advViewStack.height / 2;
			move12.yTo = advViewStack.height;
			move12.easingFunction = Linear.easeOut;
			
			par11.addChild(move11);
			par11.addChild(fade1);
			par12.addChild(move12);
			par12.addChild(fade1);
			
			var par21:Parallel = new Parallel();
			var par22:Parallel = new Parallel();
			
			var move21:Move = new Move();
			move21.yFrom = - advViewStack.height / 2;
			move21.yTo = 0;
			move21.easingFunction = Linear.easeOut;
			var fade2:Fade = new Fade();
			fade2.alphaFrom = 0;
			fade2.alphaTo = 1;
			var move22:Move = new Move();
			move22.yFrom = advViewStack.height;
			move22.yTo = advViewStack.height / 2;
			move22.easingFunction = Linear.easeOut;
			
			par21.addChild(move21);
			par21.addChild(fade2);
			par22.addChild(move22);
			par22.addChild(fade2);
			
			_eff1 = [par11, par12];
			_eff2 = [par21, par22];
		}
		
	}
}