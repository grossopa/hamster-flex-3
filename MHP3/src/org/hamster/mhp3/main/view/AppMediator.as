package org.hamster.mhp3.main.view
{
	import mx.collections.XMLListCollection;
	
	import org.hamster.mhp3.common.facade.AppFacade;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class AppMediator extends Mediator
	{
		public static const NAME:String = "org.hamster.mhp3.main.view.AppMediator";
		
		public function AppMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				// AppFacade.WEAPON_LIST_RESPONSE
			]
		}
		
		override public function handleNotification(notification:INotification):void
		{
		}
		
		public function get app():MHP3
		{
			return MHP3(viewComponent);
		}
	}
}