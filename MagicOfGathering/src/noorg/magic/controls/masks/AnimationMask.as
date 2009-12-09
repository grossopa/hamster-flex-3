package noorg.magic.controls.masks
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Point;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.effects.Move;
	
	public class AnimationMask extends Canvas
	{
		public static const DURATION:Number = 500;
		
		private var mainImage:Image;
		
		public function AnimationMask()
		{
			this.verticalScrollPolicy = ScrollPolicy.OFF;
			this.horizontalScrollPolicy = ScrollPolicy.OFF;
			
			this.percentWidth = 100;
			this.percentHeight = 100;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			this.mainImage = new Image();
			this.addChild(mainImage);
		}
		
		public function doMove(target:UIComponent, toPoint:Point,  fromPoint:Point = null):void {
			if (fromPoint == null) {
				fromPoint = target.localToGlobal(new Point());
			}
			
			var move:Move = new Move(mainImage);
			move.xFrom = fromPoint.x;
			move.yFrom = fromPoint.y;
			move.xTo = toPoint.x;
			move.yTo = toPoint.y;
			move.duration = DURATION;
			move.play();
		}
		
		
		
		private function drawComponent(target:UIComponent):void
		{
			var g:Graphics = this.mainImage.graphics;
			this.mainImage.width = target.width;
			this.mainImage.height = target.height;
			g.clear();
			target.validateNow();
			var bd:BitmapData = new BitmapData(target.width, target.height, true, 0x00);
			bd.draw(target);
			g.beginBitmapFill(bd);
			g.drawRect(0, 0, bd.width, bd.height);
			g.endFill();
		}

	}
}