package org.hamster.gamesaver.utils
{
	import mx.core.Application;
	import mx.managers.PopUpManager;
	import mx.resources.ResourceManager;
	
	import org.hamster.gamesaver.controls.base.BaseAlert;
	import org.hamster.gamesaver.controls.popup.LoadingMask;
	
	public class GlobalUtil
	{
		public static var loadingMask:LoadingMask;
		
		public static function get app():HsGameSaver
		{
			return HsGameSaver(Application.application);
		}
		
		public static function popupLoadingMask(text:String):void
		{
			loadingMask = LoadingMask(PopUpManager.createPopUp(
					app, LoadingMask, true));
			PopUpManager.centerPopUp(loadingMask);
			loadingMask.label = text;
		}
		
		public static function setProgress(value:Number):void
		{
			loadingMask.setProgress(value, 1);
		}
		
		public static function removeLoadingMask():void
		{
			PopUpManager.removePopUp(loadingMask);
		}
		
		public static function alert(message:String, title:String = "", 
				status:String = "success",
				width:Number = 450, height:Number = 100):void
		{
			var alertTarget:BaseAlert;
			alertTarget = PopUpManager.createPopUp(app, BaseAlert, true) as BaseAlert;
			alertTarget.message = message;
			alertTarget.title = title;
			alertTarget.status = status;
			alertTarget.width = width;
			alertTarget.height = height;			
			PopUpManager.centerPopUp(alertTarget);
		}
		
		public static function showHelperPanel():void {
			var helper:BaseAlert = PopUpManager.createPopUp(app, BaseAlert, true) as BaseAlert;
			helper.width = 300;
			helper.height = 300;
			helper.message = ResourceManager.getInstance().getString('main','helpMessage');
			helper.title = ResourceManager.getInstance().getString('main','helpTitle');
			PopUpManager.centerPopUp(helper);
		}
		
	}
}