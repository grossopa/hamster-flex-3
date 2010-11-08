package org.hamster.alive30.common.facade
{
	import org.hamster.alive30.common.command.LoadBulletListCommand;
	import org.hamster.alive30.common.vo.proxy.PageProxy;
	import org.hamster.alive30.game.model.vo.proxy.BulletListVOProxy;
	import org.hamster.alive30.main.command.AppInitCommand;
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class AppFacade extends Facade
	{
		public static const NAME:String = "AppFacade";
		
		public static const INIT:String 					= NAME + "Init";
		
		public static const LOAD_BULLET_LIST:String 		= NAME + "LoadBulletList";
		public static const LOAD_BULLET_LIST_DONE:String 	= NAME + LOAD_BULLET_LIST + "Done";
		
//		public static const PAGE_MAIN_MENU:String 		= NAME + "pageMainMenu";
//		public static const PAGE_LEVEL_SELECTION:String = NAME + "pageLevelSelection";
//		public static const PAGE_GAME:String 			= NAME + "pageGame";
		public static const PAGE_CHANGE:String		= NAME + "PageChange";
		
		public static const GAME_START:String 	= NAME + "GameStart";
		public static const GAME_PLAYING:String = NAME + "GamePlaying";
		public static const GAME_OVER:String 	= NAME + "GameOver";
		
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
			
			registerProxy(new BulletListVOProxy());
			registerProxy(new PageProxy());
			
			registerCommand(INIT, AppInitCommand);
			registerCommand(LOAD_BULLET_LIST, LoadBulletListCommand);
			
//			registerCommand(LOAD_CROPIMAGE, LoadCropImageListCommand);
//			registerCommand(LOAD_RULERIMAGE, LoadImageRulerCommand);
			
//			this.sendNotification(LOAD_CASELIST);
			this.sendNotification(LOAD_BULLET_LIST);
		}
		
	}
}