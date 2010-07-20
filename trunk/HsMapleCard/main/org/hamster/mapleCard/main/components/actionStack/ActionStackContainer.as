package org.hamster.mapleCard.main.components.actionStack
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.effects.AnimateProperty;
	import mx.effects.Parallel;
	import mx.effects.Tween;
	
	import org.hamster.mapleCard.assets.style.ActionStackStyle;
	import org.hamster.mapleCard.base.components.containers.SimpleContainer;
	import org.hamster.mapleCard.base.event.GameEvent;
	import org.hamster.mapleCard.base.model.IActionStackItemData;
	import org.hamster.mapleCard.base.services.EventService;
	import org.hamster.mapleCard.main.components.battleField.BattleFieldItem;
	
	public class ActionStackContainer extends SimpleContainer
	{
		public static const ES:EventService = EventService.instance;
		
		private const actionStackList:ArrayCollection = new ArrayCollection();
		private const actionStackItemList:ArrayCollection = new ArrayCollection();
		
		public function ActionStackContainer()
		{
			super();
			
			this._measuredWidth = ActionStackStyle.WIDTH;
			this._measuredHeight = ActionStackStyle.HEIGHT;
		}
		
		override protected function addedHandler(evt:Event):void
		{
			super.addedHandler(evt);
			
			ES.addEventListener(GameEvent.ADD_BATTLEFIELDITEMDATA, 
				addBattleFieldItemDataHandler);
			ES.addEventListener(GameEvent.REMOVE_BATTLEFIELDITEMDATA, 
				removeBattleFieldItemDataHandler);
		}
		
		private function addBattleFieldItemDataHandler(evt:GameEvent):void
		{
			actionStackList.addItem(evt.battleFieldItemData);
			var item:ActionStackItem = new ActionStackItem();
			item.actionStackItem = evt.battleFieldItemData;
			this.addChild(item);
			this.actionStackItemList.addItem(item);
			sortList();
			
			playAddEffect(item);
		}
		
		private function removeBattleFieldItemDataHandler(evt:GameEvent):void
		{
			actionStackList.removeItemAt(actionStackList.getItemIndex(evt.battleFieldItemData));
			// this.actionStackItemList.removeItemAt(this.actionStackItemList.getItemIndex(
			sortList();
		}
		
		private function sortList():void
		{
			var sort:Sort = new Sort();
			var sortField:SortField = new SortField("actionProgress", false, false, true);
			sort.fields = [sortField];
			actionStackList.sort = sort;
			actionStackList.refresh();
		}
		
		private function playAddEffect(newItem:ActionStackItem):void
		{
			var rightLocationArray:Array = [];
			
			for each (var item:ActionStackItem in this.actionStackItemList) {
				if (item != newItem) {
					if (item.actionStackItem.actionProgress >=
						newItem.actionStackItem.actionProgress) {
						rightLocationArray.push(item);
					}
				}
			}
			
			var parallel:Parallel = new Parallel();
			for each (item in rightLocationArray) {
				var ani:AnimateProperty = new AnimateProperty(item);
				ani.property = "x";
				ani.fromValue = item.x;
				ani.toValue = item.x + 50;
				parallel.addChild(ani);
			}
			
			var mov:AnimateProperty = new AnimateProperty(newItem);
			mov.property = "y";
			mov.fromValue = ActionStackStyle.HEIGHT;
			mov.toValue = 0;
			
			var fade:AnimateProperty = new AnimateProperty(newItem);
			fade.property = "alpha";
			fade.fromValue = 0;
			fade.toValue = 1;
			parallel.addChild(fade);
			parallel.addChild(mov);
			
			parallel.duration = ActionStackStyle.ADD_EFF_DURATION;
			parallel.play();
		}
	}
}