package noorg.magic.services
{
	public class UserService
	{
		private static var _instance:UserService;
		
		public static function getInstance():UserService
		{
			if (_instance == null) {
				_instance = new UserService();
			}
			return _instance;
		}
		
		public function saveCollection():void
		{
			
		}

	}
}