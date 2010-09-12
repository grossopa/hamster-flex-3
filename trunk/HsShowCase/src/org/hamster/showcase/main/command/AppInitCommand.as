package org.hamster.showcase.main.command
{
	import org.hamster.showcase.common.facade.AppFacade;
	import org.hamster.showcase.main.mediator.AppMediator;
	import org.hamster.showcase.main.vo.proxy.CaseVOProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class AppInitCommand extends SimpleCommand
	{
		public function AppInitCommand()
		{
			super();
		}
		
		
		override public function execute(notification:INotification):void
		{
			facade.registerProxy(new CaseVOProxy());
			
			var app:Main = notification.getBody() as Main;
			
			facade.registerMediator(new AppMediator(app));
		//facade.registerMediator( new BookFormMediator( app.bookForm ) );
			//...
			
			//sendNotification(ApplicationFacade.GET_BOOKS);
		//	this.sendNotification(ManagementFacade.APP_INIT_DONE, app);
			this.sendNotification(AppFacade.LOAD_CASELIST);
		}
	}
}