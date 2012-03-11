package org.hamster.dropboxTool.facade
{
	import org.hamster.framework.puremvc.HsFacade;
	
	public class AppFacade extends HsFacade
	{
		private static var _instance:AppFacade;
		public static function get instance():AppFacade
		{
			if (!_instance) {
				_instance = new AppFacade();
			}
			return _instance;
		}
		
		public function AppFacade()
		{
			super();
		}
		
	}
}