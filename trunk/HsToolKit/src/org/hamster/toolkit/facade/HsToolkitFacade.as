package org.hamster.toolkit.facade
{
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class HsToolkitFacade extends Facade
	{
		public function HsToolkitFacade()
		{
			super();
		}
		
		public static function getInstance():HsToolkitFacade
		{
			if (instance == null) {
				instance = new HsToolkitFacade();
			}
			return HsToolkitFacade(instance);
		}
		
		public static const APP_INIT:String = "HsToolkitFacadeAppInit";
		public static const APP_INIT_DONE:String = "HsToolkitFacadeAppInitDone";
//		public static const LOAD_CREATURE:String = "LoadCreature";
//		public static const SAVE_CREATURE:String = "SaveCreature";
//		public static const LOAD_ALL_CREATURES:String = "LoadAllCreatures";
//		public static const LOAD_ALL_CREATURES_DONE:String = "LoadAllCreaturesDone";
//		public static const LOAD_CREATURE_DONE:String = "LoadCreatureDone";
//		public static const SAVE_CREATURE_DONE:String = "SaveCreatureDone";
		
		override protected function initializeController():void
		{
			super.initializeController();
			
//			this.registerCommand(APP_INIT, InitManagementCommand);
//			this.registerCommand(LOAD_CREATURE, LoadCreatureMetaCommand);
//			this.registerCommand(SAVE_CREATURE, SaveCreatureMetaCommand);
//			this.registerCommand(LOAD_ALL_CREATURES, LoadAllCreaturesCommand);
		}
	}
}