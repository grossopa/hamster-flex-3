package org.hamster.showcase.common.facade
{
	import org.hamster.showcase.common.service.MainHTTPService;
	import org.hamster.showcase.imageCropper.command.LoadCropImageListCommand;
	import org.hamster.showcase.imageRuler.command.LoadImageRulerCommand;
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
		public static const SELECT_CASELIST:String = NAME + "Select_CaseList";
		
		// IMAGE CROPPER MODULE
		public static const LOAD_CROPIMAGE:String = NAME + "Load_CropImage";
		public static const UPDATE_CROPIMAGE:String = NAME + "Update_CropImage";
		
		// IMAGE RULER MODULE
		public static const LOAD_RULERIMAGE:String = NAME + "Load_RulerImage";
		public static const UPDATE_RULERIMAGE:String = NAME + "Update_RulerImage";
		
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
			registerCommand(LOAD_CASELIST, LoadCaseListCommand);
			registerCommand(LOAD_CROPIMAGE, LoadCropImageListCommand);
			registerCommand(LOAD_RULERIMAGE, LoadImageRulerCommand);
			
			this.sendNotification(LOAD_CASELIST);
		}
	}
}