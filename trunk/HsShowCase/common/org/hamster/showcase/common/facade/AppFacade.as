package org.hamster.showcase.common.facade
{
	import org.hamster.showcase.common.service.MainHTTPService;
	import org.hamster.showcase.main.command.AppInitCommand;
	import org.hamster.showcase.main.command.LoadCaseListCommand;
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class AppFacade extends Facade implements IFacade
	{
		public static const NAME:String = "AppFacade";
		
		public static const INIT:String = NAME + "Init";
		
		public static const LOAD_CASELIST:String = NAME + "Load_CaseList";
		public static const UPDATE_CASELIST:String = NAME + "Update_CaseList";
		
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
			registerCommand(LOAD_CASELIST, LoadCaseListCommand);
			//			this.registerCommand(APP_INIT, InitManagementCommand);
			//			this.registerCommand(LOAD_CREATURE, LoadCreatureMetaCommand);
			//			this.registerCommand(SAVE_CREATURE, SaveCreatureMetaCommand);
			//			this.registerCommand(LOAD_ALL_CREATURES, LoadAllCreaturesCommand);
			
			this.sendNotification(LOAD_CASELIST);
		}
	}
}