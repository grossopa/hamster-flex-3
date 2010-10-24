package org.hamster.alive30.common.manager
{
	import flash.utils.Dictionary;
	
	import mx.logging.ILogger;
	import mx.logging.Log;

	public class CacheManager
	{
		private static var _instance:CacheManager;
		private static const logger:ILogger = Log.getLogger("hs.cacheManager");
		public static function get instance():CacheManager
		{
			if (!_instance) {
				_instance = new CacheManager();
			}
			return _instance;
		}
		
		public function CacheManager()
		{
		}
		
		private const _cache:Dictionary = new Dictionary();
		
		public function putItem(key:String, value:*, prefix:String = "Common"):void
		{
			_cache[prefix + "_" + key] = value;
		}
		
		public function getItem(key:String, prefix:String = "Common"):*
		{
			var keyValue:String = prefix + "_" + key;
			if (!contains(key, prefix)) {
				logger.warn('The key "' + keyValue + '" does not exist in Cache!');
				return null;
			} else {
				return _cache[keyValue];
			}
		}
		
		public function removeItem(key:String, prefix:String = "Common"):void
		{
			if (contains(key, prefix)) {
				delete _cache[prefix + "_" + key];
			}
		}
		
		public function contains(key:String, prefix:String = "Common"):Boolean
		{
			return _cache.hasOwnProperty(prefix + "_" + key);
		}
	}
}