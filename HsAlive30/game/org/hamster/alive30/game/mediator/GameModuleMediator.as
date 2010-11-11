package org.hamster.alive30.game.mediator
{
	import flash.events.Event;
	
	import org.hamster.alive30.common.facade.AppFacade;
	import org.hamster.alive30.common.vo.LevelVO;
	import org.hamster.alive30.game.GameModule;
	import org.hamster.alive30.game.event.GameEvent;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class GameModuleMediator extends Mediator
	{
		public static const NAME:String = "GameModuleMediator";
		
		public function GameModuleMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			var gameModule:GameModule = GameModule(viewComponent);
			gameModule.addEventListener("gameStart", gameStartHandler);
		}
		
		private function gameStartHandler(evt:GameEvent):void
		{
			sendNotification(AppFacade.GAME_START, evt.data);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				AppFacade.LOAD_BULLET_LIST_DONE,
				AppFacade.GAME_START
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var name:String = notification.getName();
			switch (name) {
				case AppFacade.GAME_START:
					handleGameStart(notification);
					break;
				case AppFacade.LOAD_BULLET_LIST_DONE:
					handleLoadBulletListDone(notification);
					break;
			}
		}
		
		private function handleGameStart(notification:INotification):void
		{
			var levelVO:LevelVO = LevelVO(notification.getBody());
			var gameModule:GameModule = GameModule(getViewComponent());
			gameModule.start(levelVO);
			// 
		}
		
		private function handleLoadBulletListDone(notification:INotification):void
		{
			var levelVO:LevelVO = notification.getBody() as LevelVO;
			var gameModule:GameModule = GameModule(getViewComponent());
			// gameModule.start(levelVO);
			//gameModule.bulletListArray = bulletListArray;
		}
	}
}