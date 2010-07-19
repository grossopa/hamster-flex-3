package org.hamster.mapleCard.base.services
{
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
		
		// contains IActionStackItem
		public var actionStack:Array;
	}
}