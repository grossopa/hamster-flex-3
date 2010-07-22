package org.hamster.mapleCard.main.components.actionStack
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.effects.AnimateProperty;
	import mx.effects.Parallel;
	import mx.effects.Tween;
	import mx.events.EffectEvent;
	
	import org.hamster.mapleCard.assets.style.ActionStackItemStyle;
	import org.hamster.mapleCard.assets.style.ActionStackStyle;
	import org.hamster.mapleCard.base.components.containers.SimpleContainer;
	import org.hamster.mapleCard.base.event.GameEvent;
	import org.hamster.mapleCard.base.model.IActionStackItemData;
	import org.hamster.mapleCard.base.services.EventService;
	import org.hamster.mapleCard.base.services.GameService;
	import org.hamster.mapleCard.main.components.battleField.BattleFieldItem;
	
	public class ActionStackContainer extends SimpleContainer
	{
		public static const ES:EventService = EventService.instance;
		
		private const actionStackPendingItemList:ArrayCollection = new ArrayCollection();
		
		private var _lastActionItem:ActionStackItem;
		private var _currentActionItem:ActionStackItem;
		private var _actionBg:DisplayObject;
		
		public function get currentActionItemData():IActionStackItemData
		{
			return _currentActionItem == null ? null : _currentActionItem.actionStackItemData;
		}
		
		public function ActionStackContainer()
		{
			super();
			
			this._measuredWidth = ActionStackStyle.WIDTH;
			this._measuredHeight = ActionStackStyle.HEIGHT;
			
		}
		
		override protected function addedToStageHandler(evt:Event):void
		{
			super.addedToStageHandler(evt);
			
			ES.addEventListener(GameEvent.ADD_BATTLEFIELDITEMDATA, 
				addBattleFieldItemDataHandler);
			ES.addEventListener(GameEvent.REMOVE_BATTLEFIELDITEMDATA, 
				removeBattleFieldItemDataHandler);
			
			//this.graphics.lineStyle(3, 0xff0000, 1);
			//this.graphics.drawRect(0, 0, 39, 37);
			_actionBg = new ActionStackStyle.actionBg();
			this.addChild(_actionBg);
			
		}
		
		public function pickUpNextActionItem():IActionStackItemData
		{
			var parallel:Parallel = new Parallel();
			
			if (_currentActionItem != null) {
				var aniFade:AnimateProperty = new AnimateProperty();
				aniFade.fromValue = 1;
				aniFade.toValue = 0;
				aniFade.property = "alpha";
				aniFade.target = _currentActionItem;
				_lastActionItem = _currentActionItem;
				parallel.addChild(aniFade);
			}
			
			var leftItem:ActionStackItem = null;
			for (var i:int = 0; i < this.actionStackPendingItemList.length; i++) {
				var item:ActionStackItem = this.actionStackPendingItemList[i];
				if (leftItem == null) {
					leftItem = item;
				} else {
					leftItem = leftItem.x < item.x ? leftItem : item;
				}
				
				var aniX:AnimateProperty = new AnimateProperty();
				aniX.fromValue = item.x;
				aniX.toValue = item.x - ActionStackItemStyle.WIDTH - ActionStackItemStyle.ITEM_GAP;
				aniX.target = item;
				aniX.property = "x";
				parallel.addChild(aniX);
			}
			
			actionStackPendingItemList.removeItemAt(actionStackPendingItemList.getItemIndex(leftItem));
			for each (var otherItem:ActionStackItem in this.actionStackPendingItemList) {
				otherItem.actionStackItemData.actionProgress -= leftItem.actionStackItemData.actionProgress;
			}
			this._currentActionItem = leftItem;
			
			parallel.duration = ActionStackStyle.NEXT_EFF_DURATION;
			parallel.addEventListener(EffectEvent.EFFECT_END, pickUpNextItemEffEndHandler);
			parallel.play();
			
			return this._currentActionItem.actionStackItemData;
		}
		
		private function pickUpNextItemEffEndHandler(evt:EffectEvent):void
		{
			if (_lastActionItem != null) {
				actionStackPendingItemList.addItem(_lastActionItem);
				playSwitchEffect(_lastActionItem);
			}
		}
		
		private function addBattleFieldItemDataHandler(evt:GameEvent):void
		{
			var item:ActionStackItem = new ActionStackItem();
			item.actionStackItemData = evt.battleFieldItemData;
			
			var targetIndex:int = 0;
			
			for (var i:int = 0; i < this.actionStackPendingItemList.length; i++) {
				var existItem:ActionStackItem = this.actionStackPendingItemList[i];
				if (existItem.actionStackItemData.actionProgress >
					item.actionStackItemData.actionProgress) {
					targetIndex++;
				}
			}
			this.addChildAt(item, targetIndex);
			this.actionStackPendingItemList.addItemAt(item, targetIndex);
			sortList();
			
			this.setChildIndex(_actionBg, this.numChildren - 1);
			
			playAddEffect(item);
		}
		
		private function removeBattleFieldItemDataHandler(evt:GameEvent):void
		{
			sortList();
		}
		
		private function sortList():void
		{
			var sort:Sort = new Sort();
			var sortField:SortField = new SortField("actionProgress", false, false, true);
			sort.fields = [sortField];
		//	actionStackList.sort = sort;
		//	actionStackList.refresh();
		}
		
		private function playAddEffect(newItem:ActionStackItem):void
		{
			var rightLocationArray:Array = [];
			
			for each (var item:ActionStackItem in this.actionStackPendingItemList) {
				if (item != newItem) {
					if (item.actionStackItemData.actionProgress >
						newItem.actionStackItemData.actionProgress) {
						rightLocationArray.push(item);
					}
				}
			}
			
			var insertIdx:int = this.actionStackPendingItemList.length - rightLocationArray.length;
			newItem.x = insertIdx * (ActionStackItemStyle.WIDTH + ActionStackItemStyle.ITEM_GAP) + 6;
			
			var parallel:Parallel = new Parallel();
			for each (item in rightLocationArray) {
				var ani:AnimateProperty = new AnimateProperty(item);
				ani.property = "x";
				ani.fromValue = item.x;
				ani.toValue = item.x + ActionStackItemStyle.WIDTH + ActionStackItemStyle.ITEM_GAP;
				parallel.addChild(ani);
			}
			
			var movY:AnimateProperty = new AnimateProperty(newItem);
			movY.property = "y";
			movY.fromValue = ActionStackStyle.HEIGHT;
			movY.toValue = 6;
			
			var fade:AnimateProperty = new AnimateProperty(newItem);
			fade.property = "alpha";
			fade.fromValue = 0;
			fade.toValue = 1;
			parallel.addChild(fade);
			parallel.addChild(movY);
			
			parallel.duration = ActionStackStyle.ADD_EFF_DURATION;
			parallel.play();
		}
		
		private function playSwitchEffect(newItem:ActionStackItem):void
		{
			this.playAddEffect(newItem);
		}
	}
}