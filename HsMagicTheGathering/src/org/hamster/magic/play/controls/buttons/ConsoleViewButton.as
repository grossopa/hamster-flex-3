package org.hamster.magic.play.controls.buttons
{
	public class ConsoleViewButton extends ConsoleButton
	{
		
		[Embed(source="/org/hamster/magic/play/assets/buttons/btn_console_text_view.png")]
		private static var _TEXT:Class;
		
		public function ConsoleViewButton()
		{
			super();
			
			this.textClass = _TEXT;
		}
		
	}
}