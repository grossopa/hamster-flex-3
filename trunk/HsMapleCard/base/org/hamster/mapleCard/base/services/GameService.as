package org.hamster.mapleCard.base.services
{
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	import org.hamster.mapleCard.base.event.GameEvent;
	import org.hamster.mapleCard.base.model.IBattleFieldItemData;
	import org.hamster.mapleCard.base.model.card.IBaseCard;

	public class GameService
	{
		private static var _instance:GameService;
		public static function get instance():GameService
		{
			if (_instance == null) {
				_instance = new GameService();
			}
			return _instance;
		}
		
		public static const ES:EventService = EventService.instance;
		
		
		private var _battleFiledItemDataList:ArrayCollection = new ArrayCollection();
		
		public function addBattleFieldItemData(itemData:IBattleFieldItemData):void
		{
			if (_battleFiledItemDataList.getItemIndex(itemData) >= 0) {
				throw new Error("the battleFieldItem is already exists!");
			}
			_battleFiledItemDataList.addItem(itemData);
			
			var disEvt:GameEvent = new GameEvent(GameEvent.ADD_BATTLEFIELDITEMDATA);
			disEvt.battleFieldItemData = itemData;
			ES.dispatchEvent(disEvt);
		}
		
		public function removeBattleFIeldItemData(itemData:IBattleFieldItemData):void
		{
			if (_battleFiledItemDataList.getItemIndex(itemData) < 0) {
				throw new Error("the battleFieldItem doesn't exist!");
			}
			
			_battleFiledItemDataList.removeItemAt(_battleFiledItemDataList.getItemIndex(itemData));
			
			var disEvt:GameEvent = new GameEvent(GameEvent.ADD_BATTLEFIELDITEMDATA);
			disEvt.battleFieldItemData = itemData;
			ES.dispatchEvent(disEvt);		
		}
	}
}