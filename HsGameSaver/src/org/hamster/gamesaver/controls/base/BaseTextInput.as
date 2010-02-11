package org.hamster.gamesaver.controls.base
{
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mx.controls.TextInput;
	
	import org.hamster.gamesaver.events.TextInputEvent;
	
	[Event(name="applyChange", type="org.hamster.gamesaver.events.TextInputEvent")]

	public class BaseTextInput extends TextInput
	{
		public function BaseTextInput()
		{
			super();
			
			this.addEventListener(FocusEvent.FOCUS_IN, _focusInHandler);
			this.addEventListener(FocusEvent.FOCUS_OUT, _focusOutHandler);
			this.addEventListener(KeyboardEvent.KEY_UP, _keyUpHandler);
			
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
			this.dispatchEvent(new TextInputEvent(TextInputEvent.APPLY_CHANGE));
		}
		
		private function _keyUpHandler(evt:KeyboardEvent):void
		{
			if (evt.keyCode == Keyboard.ENTER) {
				this.stage.focus = null;
			}
		}
		
		
		
	}
}