package org.hamster.mapleCard.base.components.containers
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class SimpleContainer extends Sprite
	{
		protected var _measuredWidth:Number;
		protected var _measuredHeight:Number;
		
		public function SimpleContainer()
		{
			super();
			this.addEventListener(Event.ENTER_FRAME, onEnterFramwHandler);
		}
		
		protected function onEnterFramwHandler(evt:Event):void
		{
			this.width = this._measuredWidth;
			this.height = this._measuredHeight;
		}
	}
}