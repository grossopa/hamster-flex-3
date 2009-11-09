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
		
		[Embed(source='noorg/magic/assets/icons/icon_tap.png')]
		public const IconTap:Class;
		
		[Embed(source='noorg/magic/assets/others/hp_damaged.png')]
		public const HPDamaged:Class;
		
		[Embed(source='noorg/magic/assets/others/hp_health.png')]
		public const HPHealth:Class;

	}
}