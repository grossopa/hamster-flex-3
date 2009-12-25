package noorg.magic.services
{
	import mx.modules.IModuleInfo;
	import mx.modules.ModuleManager;
	
	public class ModuleService
	{
		private static var _instance:ModuleService;
		
		public static function getInstance():ModuleService
		{
			if (_instance == null) {
				_instance = new ModuleService();
			}
			return _instance;
		}
		
		public function ModuleService()
		{
		}
		
		public var moduleInfo:IModuleInfo;
		
		public function load(url:String):void
		{
			if (moduleInfo != null) {
				moduleInfo.unload();
			}
			moduleInfo = ModuleManager.getModule(url);
			moduleInfo.load();
		}

	}
}