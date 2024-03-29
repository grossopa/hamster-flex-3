package org.hamster.mapleCard.main.components.battleField
{
	import flash.events.Event;
	
	import mx.effects.AnimateProperty;
	import mx.effects.Parallel;
	import mx.effects.easing.Linear;
	
	import org.hamster.mapleCard.assets.style.BattleFieldItemStyle;
	import org.hamster.mapleCard.assets.style.BattleFieldStyle;
	import org.hamster.mapleCard.base.components.containers.SimpleContainer;
	import org.hamster.mapleCard.base.event.BattleFieldItemDataEvent;
	import org.hamster.mapleCard.base.event.GameEvent;
	import org.hamster.mapleCard.base.services.EventService;
	
	public class BattleFieldItemContainer extends SimpleContainer
	{
		private static const ES:EventService = EventService.instance;
		
		public function BattleFieldItemContainer()
		{
			super();
			this._measuredWidth = BattleFieldStyle.WIDTH;
			this._measuredHeight = BattleFieldStyle.HEIGHT;
		}
		
		override protected function addedToStageHandler(evt:Event):void
		{
			super.addedToStageHandler(evt);
			
			ES.addEventListener(GameEvent.ADD_BATTLEFIELDITEMDATA, addBattleFieldItemHandler);
		}
		
		private function addBattleFieldItemHandler(evt:GameEvent):void
		{
			var item:BattleFieldItem = new BattleFieldItem();
			item.battleFieldData = evt.battleFieldItemData;
			this.addBattleFieldItem(item, item.battleFieldData.xIndex, item.battleFieldData.yIndex);
		}
		
		public function addBattleFieldItem(item:BattleFieldItem, xIndex:int, yIndex:int):void
		{
			var xValue:Number = xIndex * BattleFieldItemStyle.WIDTH;
			var yValue:Number = yIndex * BattleFieldItemStyle.HEIGHT;
			
			this.addChild(item);
			addItemListener(item);
			
			item.x = xValue;
			item.y = yValue;
		}
		
		public function removeBattleFieldItem(item:BattleFieldItem):void
		{
			this.removeChild(item);
			this.removeItemListener(item);
		}
		
		protected function itemIndexChangedHandler(evt:BattleFieldItemDataEvent):void
		{
			var item:BattleFieldItem = BattleFieldItem(evt.currentTarget);
			moveItemTo(item, evt.newXIndex, evt.newYIndex);
		}
		
		public function moveItemTo(item:BattleFieldItem, xIdx:int, yIdx:int):void
		{
			var xValue:Number = xIdx * BattleFieldItemStyle.WIDTH;
			var yValue:Number = yIdx * BattleFieldItemStyle.HEIGHT;
			
			var length:Number = Math.sqrt((xValue - item.x) * (xValue - item.x)
				+ (yValue - item.y) * (yValue - item.y));
			
			var duration:Number = length * 5;
			
			var aniPropertyX:AnimateProperty = new AnimateProperty(item);
			aniPropertyX.property = "x";
			aniPropertyX.fromValue = item.x;
			aniPropertyX.toValue = xValue;
			aniPropertyX.duration = duration;
			aniPropertyX.easingFunction = Linear.easeNone;
			var aniPropertyY:AnimateProperty = new AnimateProperty(item);
			aniPropertyY.property = "y";
			aniPropertyY.fromValue = item.y;
			aniPropertyY.toValue = yValue;
			aniPropertyY.duration = duration;
			aniPropertyY.easingFunction = Linear.easeNone;
			var parallel:Parallel = new Parallel();
			parallel.addChild(aniPropertyX);
			parallel.addChild(aniPropertyY);
			parallel.play();
		}
		
		protected function addItemListener(item:BattleFieldItem):void
		{
			item.addEventListener(BattleFieldItemDataEvent.INDEX_CHANGED, itemIndexChangedHandler);
		}
		
		protected function removeItemListener(item:BattleFieldItem):void
		{
			item.removeEventListener(BattleFieldItemDataEvent.INDEX_CHANGED, itemIndexChangedHandler);
		}
		
		
		
		
	}
}