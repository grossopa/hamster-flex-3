package org.hamster.mapleCard.base.services
{
	import flash.events.EventDispatcher;

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