package org.hamster.mapleCard.main.components.battleField
{
	import mx.effects.Effect;
	import mx.effects.Move;
	
	import org.hamster.mapleCard.assets.style.BattleFieldItemStyle;
	import org.hamster.mapleCard.assets.style.BattleFieldStyle;
	import org.hamster.mapleCard.base.components.containers.SimpleContainer;
	import org.hamster.mapleCard.base.event.BattleFieldDataEvent;
	
	public class BattleFieldItemContainer extends SimpleContainer
	{
		public function BattleFieldItemContainer()
		{
			super();
			this._measuredWidth = BattleFieldStyle.WIDTH;
			this._measuredHeight = BattleFieldStyle.HEIGHT;
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
		
		protected function itemIndexChangedHandler(evt:BattleFieldDataEvent):void
		{
			var item:BattleFieldItem = BattleFieldItem(evt.currentTarget);
			moveItemTo(item, evt.newXIndex, evt.newYIndex);
		}
		
		public function moveItemTo(item:BattleFieldItem, xIdx:int, yIdx:int):void
		{
			var xValue:Number = xIdx * BattleFieldItemStyle.WIDTH;
			var yValue:Number = yIdx * BattleFieldItemStyle.HEIGHT;
			
			item.x = xValue;
			item.y = yValue;
		}
		
		protected function addItemListener(item:BattleFieldItem):void
		{
			item.addEventListener(BattleFieldDataEvent.INDEX_CHANGED, itemIndexChangedHandler);
		}
		
		protected function removeItemListener(item:BattleFieldItem):void
		{
			item.removeEventListener(BattleFieldDataEvent.INDEX_CHANGED, itemIndexChangedHandler);
		}
		
		
		
		
	}
}