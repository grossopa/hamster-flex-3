package org.hamster.mapleCard.main.components.actionStack
{
	import flash.events.Event;
	
	import mx.effects.Tween;
	
	import org.hamster.mapleCard.assets.style.ActionStackStyle;
	import org.hamster.mapleCard.base.components.containers.SimpleContainer;
	
	public class ActionStackContainer extends SimpleContainer
	{
		public function ActionStackContainer()
		{
			super();
			
			this._measuredWidth = ActionStackStyle.WIDTH;
			this._measuredHeight = ActionStackStyle.HEIGHT;
		}
		
		override protected function addedHandler(evt:Event):void
		{
			super.addedHandler(evt);
			
			
		}
	}
}