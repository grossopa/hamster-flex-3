package org.hamster.gamesaver.utils
{
	import mx.core.Application;
	import mx.managers.PopUpManager;
	
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
		
		private static var alertTarget:BaseAlert;
		
		public static function alert(message:String, title:String = "", 
				status:String = "success",
				width:Number = 450, height:Number = 100):void
		{
			if (alertTarget == null) {
				alertTarget = PopUpManager.createPopUp(app, BaseAlert, true) as BaseAlert;
				alertTarget.message = message;
				alertTarget.title = title;
			} else {
				alertTarget.message += '\n' + message;
				alertTarget.title += " & " + title;
			}
			alertTarget.status = status;
			alertTarget.width = width;
			alertTarget.height = height;			
			PopUpManager.centerPopUp(alertTarget);
		}
		
		public static function removeAlert():void
		{
			PopUpManager.removePopUp(alertTarget);
			alertTarget = null;
		}

	}
}