package org.hamster.mapleCard.base.components.containers
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class SimpleContainer extends Sprite
	{
		protected var _measuredWidth:Number;
		protected var _measuredHeight:Number;
		
		public function get measuredWidth():Number { return _measuredWidth; }
		public function get measuredHeight():Number { return _measuredHeight; }
		
		public function SimpleContainer()
		{
			super();
			this.addEventListener(Event.ADDED, addedHandler);
		}
		
		protected function addedHandler(evt:Event):void
		{
			this.width = this._measuredWidth;
			this.height = this._measuredHeight;
		}
	}
}