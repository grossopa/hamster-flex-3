package org.hamster.gamesaver.controls.base
{
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mx.controls.TextInput;
	
	import org.hamster.gamesaver.events.TextInputEvent;
	import org.hamster.gamesaver.utils.FileUtil;
	
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
			this.setStyle("color", 0xFFFFFF);
			_focusOutHandler(null);
		}
		
		override public function set editable(value:Boolean):void
		{
			super.editable = value;
			if (value) {
				this.setStyle("backgroundAlpha", 0.2);
			} else {
				this.setStyle("backgroundAlpha", 0);
			}
		}
		
		private function _focusInHandler(evt:FocusEvent):void
		{
			this.setStyle("backgroundAlpha", 0.4);
		}
		
		private function _focusOutHandler(evt:FocusEvent):void
		{
			if (this.editable) {
				this.setStyle("backgroundAlpha", 0.2);
			} else {
				this.setStyle("backgroundAlpha", 0);
			}
			this.dispatchEvent(new TextInputEvent(TextInputEvent.APPLY_CHANGE));
		}
		
		private function _keyUpHandler(evt:KeyboardEvent):void
		{
			if (evt.keyCode == Keyboard.ENTER) {
				this.stage.focus = null;
			}
		}
		
		public function checkFilePath():Boolean
		{
			var result:Boolean = FileUtil.checkPath(this.text);
			if (result) {
				this.setStyle("color", 0xFFFFFF);
			} else {
				this.setStyle("color", 0xFF4F4F);
			}
			return result;
		}
		
		
	}
}