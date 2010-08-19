package org.hamster.mapleBattle.main
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.hamster.mapleCard.base.components.containers.SimpleContainer;
	import org.hamster.mapleCard.base.constants.ActionStatus;
	import org.hamster.mapleCard.base.model.IActionStackItemData;
	import org.hamster.mapleCard.base.model.IBattleFieldItemData;
	import org.hamster.mapleCard.base.model.battleField.CreatureBattleFieldItemData;
	import org.hamster.mapleCard.base.model.player.Player;
	import org.hamster.mapleCard.base.services.GameService;
	import org.hamster.mapleCard.main.components.battleField.BattleFieldItem;
	
	public class BattleFloorContainer extends SimpleContainer
	{
		private static const GS:GameService = GameService.instance;
		
		private static const REFRESH_FRAME_GAP:int = 6;
		
		private static const DISTANCE_RADIX:int = 10;
		
		private static const ACTION_STACK_GAP:int = 1;
		
		private static const MOVE_GAP:int = 1;
		
		private var _refreshCount:int;
		
		private var _attackerList:ArrayCollection = new ArrayCollection();
		private var _defenderList:ArrayCollection = new ArrayCollection();
		
		public function BattleFloorContainer()
		{
			super();
			this._measuredWidth = 600;
			this._measuredHeight = 100;
			this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		public function addBattleFieldItem(item:BattleFieldItem, x:Number):void
		{
			item.x = x;
			item.y = this._measuredHeight - item.measuredHeight;
			item.battleFieldData.actionStatus = ActionStatus.MOVING;
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
			//if (this._refreshCount != REFRESH_FRAME_GAP) {
			//	this._refreshCount++;
			//} else {
			//	this._refreshCount = 0;
				// main action here
				this.refreshItemStatus();
				this.blockingForNextAction();
			//}
		}
		
		private function refreshItemStatus():void
		{
			var player1:Player = GS.player1;
			var player2:Player = GS.player2;
			
			var n:int = this.numChildren;
			for (var i:int = 0; i < n; i++) {
				var item1:BattleFieldItem = BattleFieldItem(this.getChildAt(i));
				if (_attackerList.contains(item1) || item1.battleFieldData.actionStatus != ActionStatus.MOVING) {
					continue;
				}
				for (var j:int = 0; j < n; j++) {
					var item2:BattleFieldItem = BattleFieldItem(this.getChildAt(j));
					if (item1.battleFieldData.parentPlayer != item2.battleFieldData.parentPlayer) {
						// they are in different side
						if (item1.battleFieldData is CreatureBattleFieldItemData) {
							var cData1:CreatureBattleFieldItemData = CreatureBattleFieldItemData(item1.battleFieldData);
							if (item2.x - item1.x <= DISTANCE_RADIX * cData1.maxDistance && item2.x - item1.x > 0) {
								// they are so close to raise a attack
								item1.battleFieldData.actionStatus = ActionStatus.ATTACKING;
								_attackerList.addItem(item1.battleFieldData);
								_defenderList.addItem(item2.battleFieldData);
							}
						}
					}
				}
			}
		}
		
		
		private function blockingForNextAction():void
		{
			var n:int = this.numChildren;
			for (var i:int = 0; i < n; i++) {
				var item:BattleFieldItem = BattleFieldItem(this.getChildAt(i));
				if (item.battleFieldData is IBattleFieldItemData) {
					var bfiData:IBattleFieldItemData = IBattleFieldItemData(item.battleFieldData);
					if (bfiData.actionProgress <= 0) {
						// take action
						if (bfiData.actionStatus == ActionStatus.ATTACKING) {
							bfiData.actionStatus = ActionStatus.HIT;
							bfiData.actionProgress = 15;
						} else if (bfiData.actionStatus == ActionStatus.HIT) {
							GS.performAttack(
								CreatureBattleFieldItemData(item.battleFieldData), 
								CreatureBattleFieldItemData(
									this._defenderList[this._attackerList.getItemIndex(item.battleFieldData)]));
							bfiData.actionStatus = ActionStatus.ATTACKING;
							bfiData.actionProgress = 15;
						} else if (bfiData.actionStatus == ActionStatus.MOVING) {
							// move
							if (bfiData.direction == "left") {
								item.x -= bfiData.moveSpeed * MOVE_GAP;
							} else {
								item.x += bfiData.moveSpeed * MOVE_GAP;
							}
							bfiData.actionProgress = 1;
						}
					} else {
						bfiData.actionProgress -= ACTION_STACK_GAP;
					}
				}
			}
		}
		
		private function takeAction(item:BattleFieldItem):void
		{
			if (item.battleFieldData is IActionStackItemData) {
				IActionStackItemData(item.battleFieldData).actionProgress += 10; // should be action cost
			}
		}
		
		
		
	}
}