package org.hamster.mapleCard.base.components.containers
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
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
			this.graphics.lineStyle(0, 0, 0);
			this.graphics.drawRect(0, 0, this._measuredWidth, this.measuredHeight);
		}
	}
}