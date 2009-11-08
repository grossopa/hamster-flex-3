package noorg.magic.services
{
	public class AssetService
	{
		private static var _instance:AssetService;
		
		public static function getInstance():AssetService
		{
			if (_instance == null) {
				_instance = new AssetService();
			}
			return _instance;
		}
		
		[Embed(source='noorg/magic/assets/icons/icon_bg.png')]
		public const IconBackground:Class;
		
		[Embed(source='noorg/magic/assets/icons/icon_detail.png')]
		public const IconDetail:Class;
		
		[Embed(source='noorg/magic/assets/icons/icon_tag.png')]
		public const IconTag:Class;

	}
}