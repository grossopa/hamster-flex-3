package org.hamster.mapleCard.main.components.actionStack
{
	import flash.events.Event;
	
	import org.hamster.mapleCard.assets.style.ActionStackItemStyle;
	import org.hamster.mapleCard.assets.style.ActionStackStyle;
	import org.hamster.mapleCard.base.components.images.BaseImage;
	import org.hamster.mapleCard.base.event.ActionStackItemDataEvent;
	import org.hamster.mapleCard.base.event.BattleFieldItemDataEvent;
	import org.hamster.mapleCard.base.model.IActionStackItemData;
	
	public class ActionStackItem extends BaseImage
	{
		private var _actionStackItem:IActionStackItemData;
		
		public function set actionStackItem(value:IActionStackItemData):void
		{
			if (_actionStackItem != null) {
				removeItemListener(_actionStackItem);
			}
			_actionStackItem = value;
			addItemListener(_actionStackItem);
			//this.initializeFromImgArray([_actionStackItem.actionStackIcon]);
		}
		
		public function get actionStackItem():IActionStackItemData
		{
			return _actionStackItem;
		}
		
		public function ActionStackItem()
		{
			super();
			this._measuredHeight = ActionStackItemStyle.HEIGHT;
			this._measuredWidth = ActionStackItemStyle.WIDTH;
			
		}
		
		override protected function updateDisplayContent():void
		{
			super.updateDisplayContent();
			
			this.graphics.lineStyle(3);
			this.graphics.drawRect(0, 0, _measuredWidth, _measuredHeight);
		}
		
		private function actionProgressChanged(evt:ActionStackItemDataEvent):void
		{
			
		}
		
		private function addItemListener(obj:IActionStackItemData):void
		{
			obj.addEventListener(ActionStackItemDataEvent.ACTIONPROGRESS_CHANGED, actionProgressChanged);
		}
		
		private function removeItemListener(obj:IActionStackItemData):void
		{
			obj.removeEventListener(ActionStackItemDataEvent.ACTIONPROGRESS_CHANGED, actionProgressChanged);
		}
	}
}