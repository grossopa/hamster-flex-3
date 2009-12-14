package org.hamster.controls
{
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	
	import mx.containers.Canvas;
	
	import org.hamster.graphics.tip.ITipArrow;
	import org.hamster.graphics.tip.TipArrowImpl;
	import org.hamster.graphics.tip.TipUtil;

	public class TipWindow extends Canvas
	{
		private var fillColor:Number = 0xFFFFFF;
		
		public function TipWindow()
		{
			super();
			this.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function clickHandler(evt:MouseEvent):void
		{
			fillColor = Math.random() * 256 * 256 * 256;
			
			this.invalidateDisplayList();
		}
		
		override protected function updateDisplayList(uw:Number, uh:Number):void
		{
			super.updateDisplayList(uw, uh);
			
			var g2:Graphics = this.graphics;
			g2.clear();
			g2.lineStyle(3, 0x7F7F7F, 1);
			g2.beginFill(fillColor);
			var iTipArrow1:ITipArrow = new TipArrowImpl(TipUtil.TOP, 50, 70, 40, 20);
			var iTipArrow2:ITipArrow = new TipArrowImpl(TipUtil.BOTTOM, 50, 70, 80, 20);
			TipUtil.drawTipRect(g2, 0, 0, uw, uh, [iTipArrow1, iTipArrow2], false);
			g2.endFill();
		}
		
	}
}