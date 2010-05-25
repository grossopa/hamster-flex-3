package org.hamster.gamesaver.controls.buttons
{
	import org.hamster.gamesaver.controls.base.BaseIconButton;
	
	public class ExpandButton extends BaseIconButton
	{
		[Embed(source="/org/hamster/gamesaver/assets/icons/expand.png")]
		private static var _NORMAL:Class;
		
		[Embed(source="/org/hamster/gamesaver/assets/icons/expand_down.png")]
		private static var _DOWN:Class;
		
		[Embed(source="/org/hamster/gamesaver/assets/icons/expand_over.png")]
		private static var _OVER:Class;
		
		[Embed(source="/org/hamster/gamesaver/assets/icons/expand_disabled.png")]
		private static var _DISABLED:Class;
		
		public function ExpandButton()
		{
			super();
			
			this.normalIcon = _NORMAL;
			this.downIcon = _DOWN;
			this.overIcon = _OVER;
			this.disabledIcon = _DISABLED;
		}
	}
}