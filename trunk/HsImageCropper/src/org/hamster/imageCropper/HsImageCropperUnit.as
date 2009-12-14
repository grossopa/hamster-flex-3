package org.hamster.imageCropper
{
	import flash.display.Graphics;
	
	import mx.core.UIComponent;
	
	public class HsImageCropperUnit extends UIComponent
	{
		public var isMaintainRatio:Boolean = false;
		
		public function HsImageCropperUnit()
		{
			super();
			
			this.width = 10;
			this.height = 10;
			
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			var g:Graphics = this.graphics;
			
			g.clear();
			
			g.beginFill(0xffffff, 0.1);
			g.drawRect(0, 0, this.width, this.height);
			g.endFill();
			
			g.lineStyle(1, 0xffffff, 0.6);
			g.moveTo(0, 0);
			g.lineTo(this.width, 0);
			g.lineTo(this.width, this.height);
			g.lineTo(0, this.height);
			g.lineTo(0, 0);
			
		}
		


	}
}