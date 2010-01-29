package org.hamster.gamesaver.services
{
	public class ProgressService
	{
		private static var instance:ProgressService;
		
		public static function getInstance():ProgressService
		{
			if (instance == null) {
				instance = new ProgressService();
			}
			return instance;
		}
		
		public function ProgressService()
		{
		}

	}
}