package org.hamster.mapleCard.base.event
{
	import flash.events.Event;
	
	import org.hamster.mapleCard.base.model.IBattleFieldItemData;
	
	
	public class GameEvent extends Event
	{
		public static const ADD_BATTLEFIELDITEMDATA:String = "GameEvent_addBattleFiledItemData";
		public static const REMOVE_BATTLEFIELDITEMDATA:String = "GameEvent_removeBattleFiledItemData";
		
		public static const ACTION_BATTLEFIELDITEM:String = "GameEvent_actionBattleFieldItem";
		
		public static const ATTACK_START:String = "GameEvent_attackStart";
		
		public var battleFieldItemData:IBattleFieldItemData;
		
		public var attacker:IBattleFieldItemData;
		public var defender:IBattleFieldItemData;
		
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}