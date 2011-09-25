package org.hamster.enterprise.controls
{
	import flash.events.TextEvent;

	public class HsMailTextInput extends HsTextInput
	{
		public static const CHAR1:Array = [
			'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 
			'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
			'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 
			'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
			'1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '_'
		];
		
		public static const CHAR2:Array = [
			'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 
			'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
			'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 
			'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
			'1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '_', '.', '-'
		]
		
		public function HsMailTextInput()
		{
			super();
		}
		
		override protected function textInputHandler(evt:TextEvent):void
		{
			if (this.selectionBeginIndex == 0 && CHAR1.indexOf(evt.text) == -1) {
				evt.preventDefault();
				return;
			}
			
			if (this.text.indexOf('@') != -1 && CHAR2.indexOf(evt.text) == -1) {
				evt.preventDefault();
				return;
			} else if (this.text.indexOf('@') == -1 
				&& CHAR2.indexOf(evt.text) == -1
				&& '@' != evt.text) {
				evt.preventDefault();
				return;
			}
			
			
		}
	}
}