package noorg.magic.services.play
{
	import noorg.magic.models.Player;
	
	public class PlayDataService
	{
		private static var _instance:PlayDataService;
		
		public static function getInstance():PlayDataService
		{
			if (_instance == null) {
				_instance = new PlayDataService();
			}
			return _instance;
		}
		
		public var playerRed:Player;
		public var playerBlue:Player;
		
		
		

	}
}