package org.hamster.mapleCard.base.services
{
	import flash.events.EventDispatcher;
	
	import org.hamster.mapleCard.base.model.IBattleFieldItemData;
	
	[Event(name="addBattlefielditemdata", type="org.hamster.mapleCard.base.event.GameEvent")]
	[Event(name="removeBattlefielditemdata", type="org.hamster.mapleCard.base.event.GameEvent")]
	
	[Event(name="pickUpNextActionItem", type="org.hamster.mapleCard.base.event.ActionStackItemDataEvent")]
	
	public class EventService extends EventDispatcher
	{
		private static var _instance:EventService;
		
		public static function get instance():EventService
		{
			if (_instance == null) {
				_instance = new EventService();
			}
			return _instance;
		}
		
	}
}