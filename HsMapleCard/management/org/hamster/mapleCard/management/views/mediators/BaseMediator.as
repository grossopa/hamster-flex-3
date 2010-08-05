package org.hamster.mapleCard.management.views.mediators
{
	import mx.controls.ProgressBar;
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class BaseMediator extends Mediator implements IMediator
	{
		private static var _app:UIComponent;
		public static function set app(value:UIComponent):void { _app = value; }
		public static function get app():UIComponent { return _app; }
		
		private static var _globalProgressBar:ProgressBar;
		
		public function BaseMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
		}
		
		protected function popupGlobalProgressBar(text:String):void
		{
			if (_globalProgressBar) {
				_globalProgressBar.label = text;
			} else {
				_globalProgressBar = PopUpManager.createPopUp(app, ProgressBar, true) as ProgressBar;
				_globalProgressBar.label = text;
				_globalProgressBar.width = 300;
				PopUpManager.centerPopUp(_globalProgressBar);	
			}
		}
		
		protected function removeGlobalProgressBar():void
		{
			if (_globalProgressBar) {
				PopUpManager.removePopUp(_globalProgressBar);
				_globalProgressBar = null;
			}
		}
	}
}