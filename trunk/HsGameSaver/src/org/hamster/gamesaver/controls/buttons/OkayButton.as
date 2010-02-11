package org.hamster.gamesaver.controls.buttons
{
	import org.hamster.gamesaver.controls.base.BaseIconButton;

	public class OkayButton extends BaseIconButton
	{
		[Embed(source="/org/hamster/gamesaver/assets/icons/okay.png")]
		private static var _NORMAL:Class;
		
		[Embed(source="/org/hamster/gamesaver/assets/icons/okay_down.png")]
		private static var _DOWN:Class;
		
		[Embed(source="/org/hamster/gamesaver/assets/icons/okay_over.png")]
		private static var _OVER:Class;
		
		[Embed(source="/org/hamster/gamesaver/assets/icons/okay_disabled.png")]
		private static var _DISABLED:Class;
		
		public function OkayButton()
		{
			super();
			
			this.normalIcon = _NORMAL;
			this.downIcon = _DOWN;
			this.overIcon = _OVER;
			this.disabledIcon = _DISABLED;
		}
		
	}
}