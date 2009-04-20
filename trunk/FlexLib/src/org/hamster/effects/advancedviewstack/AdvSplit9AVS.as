package org.hamster.effects.advancedviewstack
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.hamster.components.AdvancedViewStack;
	import org.hamster.effects.advancedviewstack.base
			.AbstractAdvancedViewStackEffect;
	import org.hamster.effects.advancedviewstack.base.IAdvancedViewStackEffect;
	import org.hamster.utils.ImageUtil;
	
	import mx.controls.Image;
	import mx.effects.Fade;
	import mx.effects.Move;
	import mx.effects.Parallel;
	import mx.effects.Zoom;
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 */
	 
	public class AdvSplit9AVS extends AbstractAdvancedViewStackEffect 
	{
		public function AdvSplit9AVS(arg:AdvancedViewStack)
		{
			super(arg);
			this._isQueue = true;
		}
		
		override public function get type():String
		{
			return "AdvancedSplit9";
		}
		
		override public function advInitFunction(imgs1:Array, imgs2:Array):void
		{
			var curImage:Image = imgs1.pop() as Image;
			var nextImage:Image = imgs2.pop() as Image;
				
			var smallWidth:Number = advViewStack.width / 3;
			var smallHeight:Number = advViewStack.height / 3;
				
			for (var i:int = 0; i < 3; i++) {
				for(var j:int = 0; j < 3; j++) {
					var imgTemp1:Image = ImageUtil.splitImage(curImage, 
							new Rectangle(smallWidth * j, smallHeight * i, 
									smallWidth, smallHeight), 
							new Point(0,0));
					imgTemp1.x = smallWidth * j;
					imgTemp1.y = smallHeight * i;
					var imgTemp2:Image = ImageUtil.splitImage(nextImage, 
							new Rectangle(smallWidth * j, smallHeight * i, 
									smallWidth, smallHeight), 
							new Point(0,0));
					imgTemp2.x = smallWidth * j;
					imgTemp2.y = smallHeight * i;
					imgs1.push(imgTemp1);
					imgs2.push(imgTemp2);	
				}
			}
		}
		
		override public function initAnimation():void
		{
			var smallWidth:Number = advViewStack.width / 3;
			var smallHeight:Number = advViewStack.height / 3;
			
			var a1:Array = new Array();
			var a2:Array = new Array();
			
			for(var k:int = 0; k < 9; k++) {
				var p1:Parallel = new Parallel();
				var zoom1:Zoom = new Zoom();
				zoom1.zoomHeightFrom = 1;
				zoom1.zoomHeightTo = 0;
				zoom1.zoomWidthFrom = 1;
				zoom1.zoomHeightTo = 0;
				var fade1:Fade = new Fade();
				fade1.alphaFrom = 1;
				fade1.alphaTo = 0;
				var move1:Move = new Move();
				move1.xFrom = k % 3 * smallWidth;
				move1.xTo = advViewStack.direction 
								== AdvancedViewStack.TURN_RIGHT
						? advViewStack.width - k / 3 * smallWidth
						: k / 3 * smallWidth;
				move1.yFrom = Math.floor(k / 3) * smallHeight;
				move1.yTo = k / 3 * smallHeight;
				p1.addChild(zoom1);
				p1.addChild(fade1);
				p1.addChild(move1);
				a1.push(p1);
				
				var p2:Parallel = new Parallel();
				var zoom2:Zoom = new Zoom();
				zoom2.zoomHeightFrom = 0;
				zoom2.zoomHeightTo = 1;
				zoom2.zoomWidthFrom = 0;
				zoom2.zoomHeightTo = 1;
				var fade2:Fade = new Fade();
				fade2.alphaFrom = 0;
				fade2.alphaTo = 1;
				var move2:Move = new Move();
				move2.xTo = k % 3 * smallWidth;
				move2.xFrom = advViewStack.direction 
								== AdvancedViewStack.TURN_RIGHT
						? k / 3 * smallWidth
						: advViewStack.width - k / 3 * smallWidth;
				move2.yTo = Math.floor(k / 3) * smallHeight;
				move2.yFrom = k / 3 * smallHeight;
				p2.addChild(zoom2);
				p2.addChild(fade2);
				p2.addChild(move2);
				a2.push(p2);
			}
			
			_eff1 = a1;
			_eff2 = a2;
		}
		
	}
}