package org.hamster.frameworks.services
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 */
	 
	public class EventService extends EventDispatcher
	{
		private static const _instance:EventService = new EventService();
		
		public static function getInstance():EventService
		{
			return _instance;
		}
	}
}