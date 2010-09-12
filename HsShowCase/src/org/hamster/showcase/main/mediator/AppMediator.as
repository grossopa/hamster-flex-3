package org.hamster.showcase.main.mediator
{
	import mx.collections.ArrayCollection;
	
	import org.hamster.showcase.common.facade.AppFacade;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class AppMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "AppMediator";
		
		public function AppMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				AppFacade.INIT,
				AppFacade.UPDATE_CASELIST
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var name:String = notification.getName();
			switch (name) {
				case AppFacade.INIT:
					handleAppInit(notification);
					break;
				case AppFacade.UPDATE_CASELIST:
					handleUpdateCaseList(notification);
					break;
			}
		}
		
		private function handleAppInit(notification:INotification):void
		{
			// do logical here
		}
		
		private function handleUpdateCaseList(notification:INotification):void
		{
			var app:Main = this.getViewComponent() as Main;
			app.caseVOList = new ArrayCollection(notification.getBody() as Array);
		}
	}
}