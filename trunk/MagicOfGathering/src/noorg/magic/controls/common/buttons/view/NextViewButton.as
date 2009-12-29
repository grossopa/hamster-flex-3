package noorg.magic.controls.common.buttons.view
{
	import noorg.magic.controls.common.buttons.base.BaseSimpleButton;

	public class NextViewButton extends BaseSimpleButton
	{
		[Embed(source='/noorg/magic/assets/common/buttons/view/next_disabled.png')]
		private var DISABLED_PNG:Class;
		[Embed(source='/noorg/magic/assets/common/buttons/view/next_down.png')]
		private var DOWN_PNG:Class;
		[Embed(source='/noorg/magic/assets/common/buttons/view/next_normal.png')]
		private var NORMAL_PNG:Class;
		[Embed(source='/noorg/magic/assets/common/buttons/view/next_over.png')]
		private var OVER_PNG:Class;
		
		public function NextViewButton()
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