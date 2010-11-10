package org.hamster.alive30.main.mediator
{
	import flash.display.DisplayObjectContainer;
	
	import org.hamster.alive30.common.event.PageEvent;
	import org.hamster.alive30.common.facade.AppFacade;
	import org.hamster.alive30.common.mediator.IPageMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class AppMediator extends Mediator implements IPageMediator
	{
		public static const NAME:String = "AppMediator";
		
		public function AppMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				AppFacade.LOAD_BULLET_LIST,
				AppFacade.LOAD_BULLET_LIST_DONE,
				AppFacade.INIT,
				AppFacade.PAGE_CHANGE
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var name:String = notification.getName();
			switch (name) {
				case AppFacade.PAGE_CHANGE:
					handlePageChange(notification);
					break;
			}
		}
		
		private function handlePageChange(notification:INotification):void
		{
			var pageEvent:PageEvent = PageEvent(notification.getBody());
			var oldMediator:IPageMediator = facade.retrieveMediator(pageEvent.oldPageMediatorName) as IPageMediator;
			var newMediator:IPageMediator = facade.retrieveMediator(pageEvent.newPageMediatorName) as IPageMediator;
			
			if (oldMediator) {
				oldMediator.hidePage(pageEvent.oldContainer, pageEvent.data);
			}
			
			if (newMediator) {
				newMediator.showPage(pageEvent.newContainer, pageEvent.data);
			}
		}
		
		public function showPage(newContainer:DisplayObjectContainer = null, data:Object = null):void
		{
			
		}
		
		public function hidePage(oldContainer:DisplayObjectContainer = null, data:Object = null):void
		{
			
		}
		
		
	}
}