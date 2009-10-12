package noorg.magic.services
{
	import mx.collections.ArrayCollection;
	
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
	}
}