package org.hamster.alive30.menu.mediator
{
	import mx.core.UIComponent;
	
	import org.hamster.alive30.common.config.AppConfig;
	import org.hamster.alive30.common.event.PageEvent;
	import org.hamster.alive30.common.facade.AppFacade;
	import org.hamster.alive30.common.mediator.IPageMediator;
	import org.hamster.alive30.menu.view.MainMenuPage;
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
		
		public function pageChangeHandler(evt:PageEvent):void
		{
			this.sendNotification(AppFacade.PAGE_CHANGE, evt);
		}
		
		
		
		public function showPage(container:UIComponent=null, data:Object = null):void
		{
		}
		
		public function hidePage(container:UIComponent=null, data:Object = null):void
		{
		}
	}
}