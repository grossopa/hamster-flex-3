package noorg.magic.controls.common.buttons.menu
{
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	import mx.controls.Button;

	public class CommonMenuButton extends Button
	{
		[Embed(source='/noorg/magic/assets/common/buttons/menu/disabled.jpg')]
		private var DISABLED_JPG:Class;
		[Embed(source='/noorg/magic/assets/common/buttons/menu/down.jpg')]
		private var DOWN_JPG:Class;
		[Embed(source='/noorg/magic/assets/common/buttons/menu/normal.jpg')]
		private var NORMAL_JPG:Class;
		[Embed(source='/noorg/magic/assets/common/buttons/menu/over.jpg')]
		private var OVER_JPG:Class;
		
		private var _textGlowFilter:GlowFilter = new GlowFilter(0xFFFFFF, 1, 15, 15, 2, 3);
		
		public function CommonMenuButton()
		{
			super();
			this.focusEnabled = false;
			this.setStyle("disabledSkin", DISABLED_JPG);
			this.setStyle("downSkin", DOWN_JPG);
			this.setStyle("skin", NORMAL_JPG);
			this.setStyle("overSkin", OVER_JPG);
			this.setStyle("fontSize", 20);
			this.setStyle("fontWeight", "bold");
			this.setStyle("color", 0xFFFFFF);
			this.setStyle("textRollOverColor", 0xFFFFFF);
			this.setStyle("textSelectedColor", 0xFFFFFF);
			
		}
		
		override protected function rollOverHandler(evt:MouseEvent):void
		{
			super.rollOverHandler(evt);
			
			this.textField.filters = [_textGlowFilter];
		}
		
		override protected function rollOutHandler(evt:MouseEvent):void
		{
			super.rollOutHandler(evt);
			
			this.textField.filters = [];
		}
		
	}
}