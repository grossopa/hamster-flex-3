package org.hamster.gamesaver.controls.buttons
{
	import org.hamster.gamesaver.controls.base.BaseIconButton;

	public class AddButton extends BaseIconButton
	{
		[Embed(source="/org/hamster/gamesaver/assets/icons/add.png")]
		private static var _NORMAL:Class;
		
		[Embed(source="/org/hamster/gamesaver/assets/icons/add_down.png")]
		private static var _DOWN:Class;
		
		[Embed(source="/org/hamster/gamesaver/assets/icons/add_over.png")]
		private static var _OVER:Class;
		
		[Embed(source="/org/hamster/gamesaver/assets/icons/add_disabled.png")]
		private static var _DISABLED:Class;
		
		public function AddButton()
		{
			super();
			
			this.normalIcon = _NORMAL;
			this.downIcon = _DOWN;
			this.overIcon = _OVER;
			this.disabledIcon = _DISABLED;
		}
		
	}
}