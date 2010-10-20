package org.hamster.alive30.common.component
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class SimpleContainer extends Sprite
	{
		protected var _measuredWidth:Number;
		protected var _measuredHeight:Number;
		
		public function set measuredWidth(value:Number):void { this._measuredWidth = value }
		public function set measuredHeight(value:Number):void { this._measuredHeight = value }
		public function get measuredWidth():Number { return _measuredWidth; }
		public function get measuredHeight():Number { return _measuredHeight; }
		
		public function SimpleContainer()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		protected function addedToStageHandler(evt:Event):void
		{
			this.graphics.lineStyle(0, 0, 0);
			this.graphics.drawRect(0, 0, this._measuredWidth, this.measuredHeight);
		}
	}
}