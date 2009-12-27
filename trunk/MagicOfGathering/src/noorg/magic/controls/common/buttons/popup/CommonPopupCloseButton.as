package noorg.magic.controls.common.buttons.popup
{
	import noorg.magic.controls.common.buttons.base.BaseSimpleButton;

	public class CommonPopupCloseButton extends BaseSimpleButton
	{
		[Embed(source='/noorg/magic/assets/common/buttons/popup/close_disabled.png')]
		private var DISABLED_PNG:Class;
		[Embed(source='/noorg/magic/assets/common/buttons/popup/close_down.png')]
		private var DOWN_PNG:Class;
		[Embed(source='/noorg/magic/assets/common/buttons/popup/close_normal.png')]
		private var NORMAL_PNG:Class;
		[Embed(source='/noorg/magic/assets/common/buttons/popup/close_over.png')]
		private var OVER_PNG:Class;
		
		public function CommonPopupCloseButton()
		{
			super();
			
			this.width = 35;
			this.height = 35;
			
			this.overImage 		= OVER_PNG;
			this.disabledImage 	= DISABLED_PNG;
			this.downImage 		= DOWN_PNG;
			this.normalImage 	= NORMAL_PNG;
		}
		
	}
}