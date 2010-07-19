package org.hamster.mapleCard.main.components.actionStack
{
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
		}
		
		public function get actionStackItem():IActionStackItemData
		{
			return _actionStackItem;
		}
		
		public function ActionStackItem()
		{
			super();
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