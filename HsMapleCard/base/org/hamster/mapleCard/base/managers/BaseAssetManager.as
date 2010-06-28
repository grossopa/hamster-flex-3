package org.hamster.mapleCard.base.managers
{
	/**
	 * Manager class of all assets include swf, png, etc.
	 * 
	 * This class can be either singleton or create a new instance of using it.
	 *  
	 * @author yinzeshuo
	 * 
	 */
	public class BaseAssetManager
	{
		private static var _instance:BaseAssetManager;
		public static function get instance():BaseAssetManager
		{
			if (_instance == null) {
				_instance = new BaseAssetManager();
			}
			return _instance;
		}
		
		protected var _dict:Dictionary = new Dictionary();
		
		public function BaseAssetManager()
		{
		}
		
		public function get(key:String):Object
		{
			if (key == null || key.length == 0) {
				throw new Error("The key cannot be null or empty.");
			} else if (!this.exists(key)) {
				return null;
			}
			return _dict[key];
		}
		
		public function put(key:String, value:Object):void
		{
			if (key == null || key.length == 0) {
				throw new Error("The key cannot be null or empty.");
			} 
			_dict[key] = value;
		}
		
		public function remove(key:String):void
		{
			delete _dict[key];
		}
		
		public function exists(key:String):Boolean
		{
			return _dict.hasOwnProperty(key) && (_dict[key] != null);
		}
	}
}