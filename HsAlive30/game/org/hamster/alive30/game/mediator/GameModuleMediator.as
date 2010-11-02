package org.hamster.alive30.game.mediator
{
	import org.hamster.alive30.common.facade.AppFacade;
	import org.hamster.alive30.game.GameModule;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class GameModuleMediator extends Mediator
	{
		public static const NAME:String = "GameModuleMediator";
		
		public function GameModuleMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				AppFacade.LOAD_BULLET_LIST_DONE
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var name:String = notification.getName();
			switch (name) {
				case AppFacade.LOAD_BULLET_LIST_DONE:
					handleLoadBulletListDone(notification);
					break;
			}
		}
		
		private function handleLoadBulletListDone(notification:INotification):void
		{
			var bulletListArray:Array = notification.getBody() as Array;
			var gameModule:GameModule = GameModule(getViewComponent());
			//gameModule.bulletListArray = bulletListArray;
		}
	}
}