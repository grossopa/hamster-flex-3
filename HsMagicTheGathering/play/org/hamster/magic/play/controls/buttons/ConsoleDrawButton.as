package org.hamster.magic.play.controls.buttons
{
	public class ConsoleDrawButton extends ConsoleButton
	{
		[Embed(source="/org/hamster/magic/play/assets/buttons/btn_console_text_draw.png")]
		private static var _TEXT:Class;
		
		public function ConsoleDrawButton()
		{
			super();
			
			this.textClass = _TEXT;
		}
		
	}
}