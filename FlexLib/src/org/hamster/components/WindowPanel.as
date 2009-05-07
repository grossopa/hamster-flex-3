package org.hamster.components
{
	import flash.events.MouseEvent;
	
	import mx.containers.Canvas;
	import mx.containers.Panel;
	import mx.controls.Image;
	import mx.events.FlexEvent;

	public class WindowPanel extends Panel
	{
		private var closeButton:Image = new Image();
		private var minButton:Image = new Image();
		private var maxButton:Image = new Image();
		
		public function WindowPanel()
		{
			super();
			
			var canvas:Canvas = new Canvas();
			canvas.addEventListener(MouseEvent.CLICK,
					clickHandler);
		}
		
		private function clickHandler(evt:FlexEvent):void
		{
			trace("canvas is clicked!");
		}
		
	}
}