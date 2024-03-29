package org.hamster.mapleCard.main.components.battleField
{
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.hamster.mapleCard.base.components.containers.SimpleContainer;
	import org.hamster.mapleCard.base.components.images.CreatureImage;

	public class BattleFieldContainer extends SimpleContainer
	{
		public static const ROW_COUNT:int = 5;
		public static const COL_COUNT:int = 7;
		
		private var _itemContainer:BattleFieldItemContainer;
		private var _maskContainer:BattleFieldMaskContainer;
		
		public function BattleFieldContainer()
		{
			this._measuredWidth = 525;
			this._measuredHeight = 500;
		}
		
		override protected function addedToStageHandler(evt:Event):void
		{
			super.addedToStageHandler(evt);
			
			if (this.numChildren == 0) {
				var allCount:int = ROW_COUNT * COL_COUNT;
				for (var i:int = 0; i < allCount; i++) {
					var unit:BattleFieldUnit = new BattleFieldUnit();
					unit.x = (i % COL_COUNT) * 75;
					unit.y = Math.floor(i / COL_COUNT) * 100;
					this.addChild(unit);
				}
				
				_itemContainer = new BattleFieldItemContainer();
				this.addChild(_itemContainer);
				
				_maskContainer = new BattleFieldMaskContainer();
				this.addChild(_maskContainer);
				
//				if (!this.mask) {
//					this.mask = new Sprite();
//				}
			}
		}
		
		
		
	}
}