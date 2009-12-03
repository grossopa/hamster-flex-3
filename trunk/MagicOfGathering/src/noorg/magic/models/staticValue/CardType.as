package noorg.magic.models.staticValue
{
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import noorg.magic.models.types.TypeCreature;
	import noorg.magic.models.utils.DataProviderItem;
	import noorg.magic.utils.MapCollector;
	
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
		
		public static function getDefaultLocation(type:int):int
		{
			if ((CREATURE & type) != 0) {
				return CardLocation.CREATURE;
			} else if ((ENCHANTMENT & type) != 0 || (INSTANT & type) != 0 || (SORCERY & type) != 0) {
				return CardLocation.MAGIC;
			} else if ((ARTIFACT & type) != 0) {
				return CardLocation.ARTIFACT;
			} else if ((LAND & type) != 0) {
				return CardLocation.LAND;
			}
			return CardLocation.GRAVEYARD;
		}
		
		public static function getIndexOfValue(value:Object):int
		{
			for (var i:int = 0; i < dataProviderList.length; i++) {
				var dpi:DataProviderItem = DataProviderItem(dataProviderList[i]);
				if (dpi.value == value) {
					return i;
				}
			}
			
			return -1;
		}
		
		public static var typeMap:MapCollector;
		
		public static function getType(cardType:int):Class
		{
			if (typeMap == null) {
				typeMap = new MapCollector();
				typeMap.put(CardType.CREATURE, TypeCreature);
			}
			
			return Class(typeMap.getValue(cardType));
		}
				
	}
}