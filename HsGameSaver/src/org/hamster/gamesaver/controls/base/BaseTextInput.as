package org.hamster.gamesaver.controls.base
{
	import flash.events.FocusEvent;
	
	import mx.controls.TextInput;
	import mx.skins.Border;

	public class BaseTextInput extends TextInput
	{
		public function BaseTextInput()
		{
			super();
			
			this.addEventListener(FocusEvent.FOCUS_IN, _focusInHandler);
			this.addEventListener(FocusEvent.FOCUS_OUT, _focusOutHandler);
			
			this.setStyle("borderStyle", "none");
			
			_focusOutHandler(null);
		}
		
		private function _focusInHandler(evt:FocusEvent):void
		{
			//this.setStyle("color", 0x000000);
			this.setStyle("backgroundAlpha", 0.3);
		}
		
		private function _focusOutHandler(evt:FocusEvent):void
		{
			this.setStyle("color", 0xFFFFFF);
			this.setStyle("backgroundAlpha", 0);
		}
		
		
		
	}
}