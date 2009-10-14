package noorg.magic.services
{
	import mx.collections.ArrayCollection;
	
	import noorg.magic.models.Card;
	
	public class DataService
	{
		private static var _instance:DataService;
		
		public static function getInstance():DataService
		{
			if (_instance == null) {
				_instance = new DataService();
			}
			return _instance;
		}
		
		[Bindable]
		public var cardCollections:ArrayCollection = new ArrayCollection();
		
		[Bindable]
		public var selectedCards:ArrayCollection = new ArrayCollection();
		
		[Bindable]
		public var selectedNum:int;
		
		public function selectedNumChanged():void
		{
			var result:int = 0;
			for each (var card:Card in selectedCards) {
				if (card.isSelected) {
					result += card.count;
				}
			}
			selectedNum = result;
		}
	}
}