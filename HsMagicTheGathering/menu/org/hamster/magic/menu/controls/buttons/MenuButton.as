package org.hamster.magic.menu.controls.buttons
{
	import flash.display.Bitmap;
	
	import org.hamster.magic.common.controls.base.BaseIconButton;

	public class MenuButton extends BaseIconButton
	{
		[Embed(source="/org/hamster/magic/menu/assets/buttons/btn_menu.png")]
		private var _normalBackground:Class;
		
		[Embed(source="/org/hamster/magic/menu/assets/buttons/btn_menu_down.png")]
		private var _downBackground:Class;
		
		
		private var _textIcon:Class;
		
		public function set textIcon(value:Class):void
		{
			this._textIcon = value;
			this.invalidateDisplayList();
		}
		
		public function get textIcon():Class
		{
			return this._textIcon;
		}
		
		public function MenuButton()
		{
			super();
			
			this.width = 250;
			this.height = 45;
			
			this.normalIcon = _normalBackground;
			this.downIcon = _downBackground;
		}
		
		override protected function updateDisplayList(uw:Number, uh:Number):void
		{
			super.updateDisplayList(uw, uh);
			
			if (this.textIcon != null) {
				var bm:Bitmap = new textIcon();
				this.graphics.beginBitmapFill(bm.bitmapData);
				this.graphics.drawRect(0, 0, uw, uh);
				this.graphics.endFill();
				
			}
		}
		
	}
}