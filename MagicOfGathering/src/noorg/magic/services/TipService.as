package noorg.magic.services
{
	import flash.display.DisplayObject;
	
	import mx.core.Application;
	import mx.managers.PopUpManager;
	
	import noorg.magic.controls.popups.tips.helping.OperationFaultTip;
	
	public class TipService
	{
		private static var _instance:TipService;
		
		public static function getInstance():TipService
		{
			if (_instance == null) {
				_instance = new TipService()
			}
			return _instance;
		}
		
		public function TipService()
		{
		}
		
		public function showOperationFault(text:String):void
		{
			var tip:OperationFaultTip = PopUpManager.createPopUp(
			        DisplayObject(Application.application),
			        OperationFaultTip) as OperationFaultTip;
			tip.showTip(text);
			PopUpManager.centerPopUp(tip);
		}

	}
}