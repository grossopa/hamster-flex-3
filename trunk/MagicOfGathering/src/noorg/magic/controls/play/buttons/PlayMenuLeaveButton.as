package noorg.magic.controls.play.buttons
{
	import noorg.magic.controls.common.buttons.base.BaseSimpleButton;

	public class PlayMenuLeaveButton extends BaseSimpleButton
	{
		[Embed(source='/noorg/magic/assets/icons/playMenu/leave_disabled.png')]
		private var DISABLED_PNG:Class;
		[Embed(source='/noorg/magic/assets/icons/playMenu/leave_down.png')]
		private var DOWN_PNG:Class;
		[Embed(source='/noorg/magic/assets/icons/playMenu/leave_normal.png')]
		private var NORMAL_PNG:Class;
		[Embed(source='/noorg/magic/assets/icons/playMenu/leave_over.png')]
		private var OVER_PNG:Class;		
		
		public function PlayMenuLeaveButton()
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