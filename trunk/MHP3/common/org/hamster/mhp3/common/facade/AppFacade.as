package org.hamster.mhp3.common.facade
{
	import org.hamster.mhp3.common.service.MainHTTPService;
	import org.hamster.mhp3.main.command.AppInitCommand;
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class AppFacade extends Facade implements IFacade
	{
		public static const NAME:String = "AppFacade";
		
		public static const INIT:String = NAME + "Init";
		
		// MAIN DATA
		public static const WEAPON_LIST_REQUEST:String 		= NAME + "WeaponListRequest";
		public static const WEAPON_LIST_RESPONSE:String 	= NAME + "WeaponListResponse";
		
		// LOGGER CONTAINER
		public static const ADD_LOGGER:String = NAME + "Add_Logger";
		
		public static const ERROR:String = NAME + "Error";
		
		private static var __instance:AppFacade;
		
		public static function get instance():AppFacade
		{
			if (!__instance) {
				__instance = new AppFacade();
			}
			return __instance;
		}
		
		public function AppFacade()
		{
			super();
		}
		
		override protected function initializeController():void
		{
			super.initializeController();
			
			new MainHTTPService();
			
			registerCommand(INIT, AppInitCommand);
		}
	}
}