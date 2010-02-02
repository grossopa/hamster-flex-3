package org.hamster.gamesaver.utils
{
	import mx.core.Application;
	import mx.managers.PopUpManager;
	
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

	}
}