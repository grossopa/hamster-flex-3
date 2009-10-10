package noorg.magic.services.i18n
{
	import mx.resources.ResourceManager;
	
	import noorg.magic.utils.Properties;
	
	public class ResourceService
	{
		private static var _instance:ResourceService;
		
		public static function getInstance():ResourceService
		{
			if (_instance == null) {
				_instance = new ResourceService();
			}
			return _instance;
		}
		
		public function ResourceService()
		{
		}
		
		public function set localeChain(value:String):void
		{
			ResourceManager.getInstance().localeChain = [value];
		}
		
		public function get localeChain():String
		{
			return ResourceManager.getInstance().localeChain[0] as String;
		}
		
	}
}