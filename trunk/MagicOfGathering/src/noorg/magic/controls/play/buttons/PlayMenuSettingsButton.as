package noorg.magic.controls.play.buttons
{
	import noorg.magic.controls.common.buttons.base.BaseSimpleButton;

	public class PlayMenuSettingsButton extends BaseSimpleButton
	{
		[Embed(source='/noorg/magic/assets/icons/playMenu/settings_disabled.png')]
		private var DISABLED_PNG:Class;
		[Embed(source='/noorg/magic/assets/icons/playMenu/settings_down.png')]
		private var DOWN_PNG:Class;
		[Embed(source='/noorg/magic/assets/icons/playMenu/settings_normal.png')]
		private var NORMAL_PNG:Class;
		[Embed(source='/noorg/magic/assets/icons/playMenu/settings_over.png')]
		private var OVER_PNG:Class;
				
		public function PlayMenuSettingsButton()
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