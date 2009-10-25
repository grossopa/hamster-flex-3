package noorg.magic.utils
{
	import flash.display.DisplayObject;
	
	import mx.core.Application;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	
	import noorg.magic.controls.masks.ProcessMask;
	
	public class GlobalUtil
	{
		public static var curMask:ProcessMask;
		
		public static function popUpMask(text:String, target:DisplayObject = null):void
		{
			if (target == null) {
				target = app;
			}
			curMask = PopUpManager.createPopUp(target, ProcessMask, true) as ProcessMask;
			curMask.text = text;
			PopUpManager.centerPopUp(curMask);
		}
		
		public static function removePopUpMask():void
		{
			PopUpManager.removePopUp(curMask);
		}
		
		public static function get app():MagicOfGathering
		{
			return MagicOfGathering(Application.application);
		}
		
		public static function createPopup(className:Class, parent:DisplayObject = null):IFlexDisplayObject
		{
			if (parent == null) {
				parent = app;
			}
			var obj:IFlexDisplayObject = PopUpManager.createPopUp(parent, className, true);
			PopUpManager.centerPopUp(obj);
			return obj;
		}
		
		public static function removePopup(obj:IFlexDisplayObject):void
		{
			PopUpManager.removePopUp(obj);
		}

	}
}