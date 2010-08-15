package org.hamster.mapleBattle.main
{
	import flash.events.Event;
	
	import org.hamster.mapleCard.base.components.containers.SimpleContainer;
	import org.hamster.mapleCard.base.model.IBattleFieldItemData;
	import org.hamster.mapleCard.base.model.battleField.CreatureBattleFieldItemData;
	import org.hamster.mapleCard.base.model.player.Player;
	import org.hamster.mapleCard.base.services.GameService;
	import org.hamster.mapleCard.main.components.battleField.BattleFieldItem;
	
	public class BattleFloorContainer extends SimpleContainer
	{
		private static const GS:GameService = GameService.instance;
		
		private static const REFRESH_FRAME_GAP:int = 6;
		private var _refreshCount:int;
		
		// utility
//		private var _leftSideItemList:Array = [];
//		private var _rightSideItemList:Array = [];
		
		public function BattleFloorContainer()
		{
			super();
			this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		public function addBattleFieldItem(item:BattleFieldItem, x:Number):void
		{
			item.x = x;
			item.y = this.height - item.measuredHeight;
//			if (item.battleFieldData.direction == "left") {
//				
//			}
			this.addChild(item);
		}
		
		public function addItemListener(item:BattleFieldItem):void
		{
			
		}
		
		public function removeItemListener(item:BattleFieldItem):void
		{
			
		}
		
		public function onEnterFrameHandler(evt:Event):void
		{
			if (this._refreshCount != REFRESH_FRAME_GAP) {
				this._refreshCount++;
			} else {
				this._refreshCount = 0;
				// main action here
				
			}
		}
		
		private function refreshItemStatus():void
		{
			var player1:Player = GS.player1;
			var player2:Player = GS.player2;
			
			var n:int = this.numChildren;
			for (var i:int = 0; i < n; i++) {
				var item:BattleFieldItem = BattleFieldItem(this.getChildAt(i));
				for (var j:int = 0; j < n; j++) {
					var item2:BattleFieldItem = BattleFieldItem(this.getChildAt(i));
					if (item.battleFieldData.direction != item2.battleFieldData.direction) {
						// they are opposite
						
					}
				}
			}
		}
		
		
	}
}