package org.hamster.closableTab
{
	import mx.controls.Button;
	
	public class HsCloseButton extends Button
	{
		[Embed(source='/org/hamster/closableTab/assets/CloseButton_normal.png')]
		private var __normalSkin:Class;
		[Embed(source='/org/hamster/closableTab/assets/CloseButton_down.png')]
		private var __downSkin:Class;
		[Embed(source='/org/hamster/closableTab/assets/CloseButton_disabled.png')]
		private var __disabledSkin:Class;
		[Embed(source='/org/hamster/closableTab/assets/CloseButton_over.png')]
		private var __overSkin:Class;
		
		public function HsCloseButton() 
		{
			super();
			this.setStyle("upSkin", __normalSkin);
			this.setStyle("overSkin", __overSkin);
			this.setStyle("downSkin", __downSkin);
			this.setStyle("disabledSkin", __disabledSkin);
			this.setStyle("selectedUpSkin", __normalSkin);
			this.setStyle("selectedOverSkin", __overSkin);
			this.setStyle("selectedDownSkin", __downSkin);
			this.setStyle("selectedDisabledSkin", __disabledSkin);
		}
		
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			this.alpha = value ? 1 : 0.5;
		}
		
	}
}