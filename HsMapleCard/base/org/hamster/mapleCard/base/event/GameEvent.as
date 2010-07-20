package org.hamster.mapleCard.base.event
{
	import flash.events.Event;
	
	import org.hamster.mapleCard.base.model.IBattleFieldItemData;
	
	
	public class GameEvent extends Event
	{
		public static const ADD_BATTLEFIELDITEMDATA:String = "GameEvent_addBattleFiledItemData";
		public static const REMOVE_BATTLEFIELDITEMDATA:String = "GameEvent_removeBattleFiledItemData";
		
		public var battleFieldItemData:IBattleFieldItemData;
		
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}