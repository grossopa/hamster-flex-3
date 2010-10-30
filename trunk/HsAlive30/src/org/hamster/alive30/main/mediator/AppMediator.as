package org.hamster.alive30.main.mediator
{
	import org.hamster.alive30.common.facade.AppFacade;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class AppMediator extends Mediator
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
				AppFacade.INIT
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
		}
	}
}