package org.hamster.gamesaver.controls.popup
{
	import mx.containers.Canvas;
	
	public class BasePopup extends Canvas
	{
		public function BasePopup()
		{
			super();
			this.setStyle('backgroundColor', 0x000000);
			this.setStyle('borderColor', 0xFFFFFF);
			this.setStyle('borderStyle', 'solid');
			this.setStyle('borderThickness', 2);
			this.setStyle('verticalScrollPolicy', 'off');
			this.setStyle('horizontalScrollPolicy', 'off');
		}
	}
}