package org.hamster.mapleCard.base.services
{
	import flash.events.EventDispatcher;
	
	import org.hamster.mapleCard.base.model.IBattleFieldItemData;
	
	[Event(name="addBattlefielditem", type="org.hamster.mapleCard.base.event.GameEvent")]
	[Event(name="removeBattlefielditem", type="org.hamster.mapleCard.base.event.GameEvent")]

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