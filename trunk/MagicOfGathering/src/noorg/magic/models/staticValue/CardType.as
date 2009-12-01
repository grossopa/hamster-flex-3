package noorg.magic.models.staticValue
{
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import noorg.magic.models.utils.DataProviderItem;
	
	public class CardType
	{
		private static const _resourceManager:IResourceManager = ResourceManager.getInstance();
		
		private static var _previousLocale:String;
		private static var _list:Array;
		
		public static const CREATURE:uint 		= 0x00000001;
		public static const ENCHANTMENT:uint 	= 0x00000010;
		public static const INSTANT:uint		= 0x00000100;
		public static const ARTIFACT:uint		= 0x00001000;
		public static const LAND:uint			= 0x00010000;
		public static const SORCERY:uint		= 0x00100000;
		
		public static function get dataProviderList():Array
		{
			if (_list == null || _previousLocale != _resourceManager.localeChain[0]) {
				_previousLocale = _resourceManager.localeChain[0];
				_list = [
					new DataProviderItem(_resourceManager.getString('main', 'type.creature'), 		CREATURE),
					new DataProviderItem(_resourceManager.getString('main', 'type.enchantment'), 	ENCHANTMENT),
					new DataProviderItem(_resourceManager.getString('main', 'type.instant'), 		INSTANT),
					new DataProviderItem(_resourceManager.getString('main', 'type.artifact'), 		ARTIFACT),
					new DataProviderItem(_resourceManager.getString('main', 'type.land'), 			LAND),
					new DataProviderItem(_resourceManager.getString('main', 'type.sorcery'), 		SORCERY)
				];
			}
			
			return _list;
		}

	}
}