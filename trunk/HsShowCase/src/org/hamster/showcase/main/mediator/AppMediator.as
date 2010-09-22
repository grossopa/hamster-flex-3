package org.hamster.showcase.main.mediator
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.hamster.showcase.common.facade.AppFacade;
	import org.hamster.showcase.main.vo.CaseVO;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class AppMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "AppMediator";
		
		public function AppMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			var app:Main = Main(viewComponent);
			app.addEventListener("caseList_Change", caseListChangeHandler);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				AppFacade.INIT,
				AppFacade.UPDATE_CASELIST,
				AppFacade.SELECT_CASELIST
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
				case AppFacade.SELECT_CASELIST:
					handleSelectCaseList(notification);
					break;
			}
		}
		
		private function handleAppInit(notification:INotification):void
		{
			// do logical here
		}
		
		private function handleUpdateCaseList(notification:INotification):void
		{
			var app:Main = Main(this.getViewComponent());
			app.caseVOList = new ArrayCollection(notification.getBody() as Array);
		}
		
		private function handleSelectCaseList(notification:INotification):void
		{
			var app:Main = Main(this.getViewComponent());
			var caseVO:CaseVO = CaseVO(notification.getBody());
			app.addNewModule(caseVO.moduleLocation);
		}
		
		// handle view events
		private function caseListChangeHandler(evt:Event):void
		{
			var app:Main = Main(this.getViewComponent());
			this.sendNotification(AppFacade.SELECT_CASELIST, CaseVO(app.caseList.selectedItem));
		}
		
	}
}