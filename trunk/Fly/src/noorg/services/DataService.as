package noorg.services
{
	import mx.collections.ArrayCollection;
	
	import noorg.errors.ServiceError;
	import noorg.models.album.PageStyle;
	
	public class DataService
	{
		///////////////
		// singleton //
		///////////////
		private static var _instance:DataService;
		
		public static function getInstance():DataService
		{
			if (_instance == null) {
				_instance = new DataService();
			}
			return _instance;
		}
		
		public function DataService()
		{
			if (_instance != null) {
				throw new ServiceError(ServiceError.SINGLETON_ERROR_MSG);
			}
		}
		
		///////////////////////
		// global properties //
		///////////////////////
		public var ratio:Number = 1.3333333;
		
		
		/////////////////////
		// selected images //
		/////////////////////
		public const imageDatas:ArrayCollection = new ArrayCollection();
		public const pageStyles:ArrayCollection = new ArrayCollection();
		public const bgImgs:ArrayCollection = new ArrayCollection();
		
		public function get defaultPageStyle():PageStyle
		{
			if (this.pageStyles != null && this.pageStyles.length != 0) {
				return PageStyle(this.pageStyles[0]);
			}
			return null;
		}
		
		

	}
}