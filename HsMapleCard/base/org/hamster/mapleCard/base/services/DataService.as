package org.hamster.mapleCard.base.services
{
	import org.hamster.mapleCard.base.managers.ImageAssetManager;

	public class DataService
	{
		private static var _instance:DataService;
		public static function get instance():DataService
		{
			if (_instance == null) {
				_instance = new DataService();
			}	
			return _instance;
		}
		
		public function DataService() {
			
		}
		
		/**
		 * stores all images loaded from file system. the key is the folder contains 
		 * all images, the value is an array that contains all byteArray instance of
		 * images. 
		 */
		public const imageCacheManager:ImageAssetManager = new ImageAssetManager();
	}
}