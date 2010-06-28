package org.hamster.mapleCard.base.managers
{
	public class ImageAssetManager extends BaseAssetManager
	{
		private static var _instance:ImageAssetManager;
		public static function get instance():ImageAssetManager
		{
			if (_instance == null) {
				_instance = new ImageAssetManager();
			}
			return _instance;
		}
		
		public function ImageAssetManager()
		{
			super();
		}
	}
}