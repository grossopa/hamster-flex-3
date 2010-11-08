package org.hamster.alive30.menu.mediator
{
	import mx.core.UIComponent;
	
	import org.hamster.alive30.common.facade.AppFacade;
	import org.hamster.alive30.common.mediator.IPageMediator;
	import org.hamster.alive30.menu.event.LevelSelectorEvent;
	import org.hamster.alive30.menu.view.LevelSelectorPage;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LevelSelectorMediator extends Mediator implements IPageMediator
	{
		public static const NAME:String = "LevelSelectorMediator";
		
		public function LevelSelectorMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			var levelSelectorPage:LevelSelectorPage = LevelSelectorPage(viewComponent);
			levelSelectorPage.addEventListener(LevelSelectorEvent.LEVEL_SELECTED, levelSelectedHandler);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				AppFacade.PAGE_CHANGE
			];
		}
		
		private function levelSelectedHandler(evt:LevelSelectorEvent):void
		{
			// this.sendNotification(AppFacade.PAGE_CHANGE, evt.levelVO);
			// this.sendNotification(AppFacade.GAME_START, evt.levelVO);
		}
		
		public function showPage(container:UIComponent=null, data:Object = null):void
		{
			if (container) {
				container.addChild(LevelSelectorPage(getViewComponent()));
			}
		}
		
		public function hidePage(container:UIComponent=null, data:Object = null):void
		{
		}
	}
}