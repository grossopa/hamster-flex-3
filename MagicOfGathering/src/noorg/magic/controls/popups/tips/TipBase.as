package noorg.magic.controls.popups.tips
{
	import flash.display.GradientType;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	
	import mx.containers.Canvas;
	
	import noorg.magic.utils.TipArrowImpl;
	import noorg.magic.utils.TipArrowUtil;

	public class TipBase extends Canvas
	{
		public static const TIP_WIDTH:Number = 30;
		public static const TIP_HEIGHT:Number = 40;
		public static const CORNER_RADIUS:Number = 15;
		public const tipArrow:TipArrowImpl = new TipArrowImpl(TipArrowUtil.BOTTOM, 40, 80, 60, TIP_HEIGHT);
		
		public function TipBase()
		{
			super();
			
			this.filters = [new DropShadowFilter(5, 45, 0x000000, 0.7, 12, 12, 3, 3)];
			this.setStyle("cornerRadius", CORNER_RADIUS);
		}
		
		public function get heightWithTip():Number
		{
			return this.height + TIP_HEIGHT;
		}
		
		public function get widthWithTip():Number
		{
			return this.width + TIP_HEIGHT;
		}
		
		override protected function updateDisplayList(uw:Number, uh:Number):void
		{
			super.updateDisplayList(uw, uh);
			
			this.graphics.clear();
			var m:Matrix = new Matrix();
			m.createGradientBox(uw, uh, Math.PI / 2, 0, 0);
			this.graphics.lineStyle(1, 0x000000);
			graphics.beginGradientFill(GradientType.LINEAR, [0x7F7F7F, 0xDEDEDE],
					[0.5, 0.5], [0x00, 0xFF], m);
			tipArrow.distanceA = uw - 4 * TIP_WIDTH >> 1;
			tipArrow.distanceB = uw - 2 * TIP_WIDTH >> 1;
			tipArrow.distanceC = uw >> 1;
			TipArrowUtil.drawTipRoundRectComplex(graphics, 0, 0, uw, uh, [tipArrow], 
					CORNER_RADIUS, CORNER_RADIUS, CORNER_RADIUS, CORNER_RADIUS, false);
			graphics.endFill();
		}
		
	}
}