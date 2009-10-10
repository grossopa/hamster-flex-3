package noorg.services
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import noorg.errors.ServiceError;

	public class EventService extends EventDispatcher
	{
		private static var _instance:EventService;
		
		public static function getInstance():EventService
		{
			if (_instance == null) {
				_instance = new EventService();
			}
			return _instance;
		}
		
		public function EventService(target:IEventDispatcher = null)
		{
			super(target);
			
			if (_instance != null) {
				throw new ServiceError(ServiceError.SINGLETON_ERROR_MSG);
			}
		}
		
	}
}