package org.hamster.mapleCard.management.facade
{
	import org.hamster.mapleCard.management.commands.InitManagementCommand;
	import org.hamster.mapleCard.management.commands.LoadAllCreaturesCommand;
	import org.hamster.mapleCard.management.commands.LoadCreatureMetaCommand;
	import org.hamster.mapleCard.management.commands.SaveCreatureMetaCommand;
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class ManagementFacade extends Facade
	{
		public static function getInstance():ManagementFacade
		{
			if (instance == null) {
				instance = new ManagementFacade();
			}
			return instance as ManagementFacade;
		}
		
		public static const APP_INIT:String = "AppInit";
		
		public static const LOAD_CREATURE:String = "LoadCreature";
		public static const SAVE_CREATURE:String = "SaveCreature";
		public static const LOAD_ALL_CREATURES:String = "LoadAllCreatures";
		public static const LOAD_ALL_CREATURES_DONE:String = "LoadAllCreaturesDone";
		public static const LOAD_CREATURE_DONE:String = "LoadCreatureDone";
		public static const SAVE_CREATURE_DONE:String = "SaveCreatureDone";
		
		override protected function initializeController():void
		{
			super.initializeController();
			this.registerCommand(APP_INIT, InitManagementCommand);
			this.registerCommand(LOAD_CREATURE, LoadCreatureMetaCommand);
			this.registerCommand(SAVE_CREATURE, SaveCreatureMetaCommand);
			this.registerCommand(LOAD_ALL_CREATURES, LoadAllCreaturesCommand);
		}
		
	}
}