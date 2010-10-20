package org.hamster.alive30.game.item
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	
	import org.hamster.alive30.common.component.BaseImage;
	import org.hamster.alive30.common.util.IVector2DItem;
	import org.hamster.alive30.common.util.Vector2D;
	
	public class DangerCircle extends Sprite implements IVector2DItem
	{
		private const _speedVector:Vector2D = new Vector2D();
		private const _accelVector:Vector2D = new Vector2D();
		
		public function get speedVector():Vector2D { return _speedVector }
		public function get accelVector():Vector2D { return _accelVector }
		
		public function DangerCircle()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
	
		protected function addedToStageHandler(evt:Event):void
		{
			//var bm:Bitmap = new ResourceConstants.IMG_();
			//initializeFromImgArray([bm]);
			this.filters = [new GlowFilter(0xBFEFFF, 0.7,4,4,2,3)];
		}
		
		protected function enterFrameHandler(evt:Event):void
		{
			var g:Graphics = this.graphics;
			g.clear();
			g.lineStyle(2, 0xBFEFFF);
			g.beginGradientFill(GradientType.RADIAL, [0xFFFFFF, 0xBFEFFF], [1, 1], [0, 255]);
			g.drawCircle(0, 0, 10);
			g.endFill();
			
		}
	}
}