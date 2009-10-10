package noorg.services
{
	import mx.collections.ArrayCollection;
	
	import noorg.errors.ServiceError;
	
	/**
	 * stores all items (which means UIComponents or Sprites) which will
	 * have only one instance with one data.
	 */
	public class ItemService
	{
		private static var _instance:ItemService;
		
		public static function getInstance():ItemService
		{
			if (_instance == null) {
				_instance = new ItemService();
			}
			return _instance;
		}
		
		public function ItemService()
		{
			if (_instance != null) {
				throw new ServiceError(ServiceError.SINGLETON_ERROR_MSG);
			}
		}
		
		public var pageUnits:ArrayCollection = new ArrayCollection();

	}
}