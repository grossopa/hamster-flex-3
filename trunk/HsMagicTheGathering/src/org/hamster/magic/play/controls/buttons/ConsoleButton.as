package org.hamster.magic.play.controls.buttons
{
	import flash.display.Bitmap;
	
	import org.hamster.magic.common.controls.base.BaseIconButton;

	public class ConsoleButton extends BaseIconButton
	{
		[Embed(source="/org/hamster/magic/play/assets/buttons/btn_console_background.png")]
		private static var _NORMAL:Class;
		
		[Embed(source="/org/hamster/magic/play/assets/buttons/btn_console_background_down.png")]
		private static var _DOWN:Class;
		
		protected var textClass:Class;
				
		public function ConsoleButton()
		{
			super();
			
			this.normalIcon = _NORMAL;
			this.downIcon = _DOWN;
			this.width = 100;
			this.height = 25;
		}
		
		override protected function updateDisplayList(uw:Number, uh:Number):void
		{
			super.updateDisplayList(uw, uh);
			
			var bitmap:Bitmap = new textClass();
			this.graphics.beginBitmapFill(bitmap.bitmapData, null, true, true);
			this.graphics.drawRect(0, 0, uw, uh);
			this.graphics.endFill();
		}
		
	}
}