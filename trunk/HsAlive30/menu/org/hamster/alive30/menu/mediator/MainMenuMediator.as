package org.hamster.alive30.menu.mediator
{
	import flash.display.DisplayObjectContainer;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	
	import org.hamster.alive30.common.config.AppConfig;
	import org.hamster.alive30.common.event.PageEvent;
	import org.hamster.alive30.common.facade.AppFacade;
	import org.hamster.alive30.common.mediator.IPageMediator;
	import org.hamster.alive30.game.model.vo.proxy.BulletListVOProxy;
	import org.hamster.alive30.menu.view.MainMenuPage;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class MainMenuMediator extends Mediator implements IPageMediator
	{
		public static const NAME:String = "MainMenuMediator";
		
		public function MainMenuMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			var app:MainMenuPage = MainMenuPage(viewComponent);
			app.addEventListener(PageEvent.PAGE_CHANGE, pageChangeHandler);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				AppFacade.LOAD_BULLET_LIST_DONE
			];
		}
		
		public function pageChangeHandler(evt:PageEvent):void
		{
			this.sendNotification(AppFacade.PAGE_CHANGE, evt);
			this.sendNotification(AppFacade.GAME_START, evt.data);
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var app:MainMenuPage = MainMenuPage(viewComponent);
			var bulletListProxy:BulletListVOProxy = facade.retrieveProxy(BulletListVOProxy.NAME) as BulletListVOProxy;
			switch (notification.getName()) {
				case AppFacade.LOAD_BULLET_LIST_DONE:
					app.levelSelectorPage.levelVOList = bulletListProxy.levelVOArray;
					break;
			}
		}
		
		
		
		public function showPage(container:DisplayObjectContainer=null, data:Object = null):void
		{
		}
		
		public function hidePage(container:DisplayObjectContainer=null, data:Object = null):void
		{
			var app:MainMenuPage = MainMenuPage(viewComponent);
			app.parent.removeChild(app);
		}
	}
}