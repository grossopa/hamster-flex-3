package org.hamster.alive30.main.command
{
	import org.hamster.alive30.common.facade.AppFacade;
	import org.hamster.alive30.main.mediator.AppMediator;
	import org.hamster.alive30.menu.view.LevelSelectorPage;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class AppInitCommand extends SimpleCommand
	{
		public static const NAME:String = "AppInitCommand";
		
		public function AppInitCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var app:HsAlive = HsAlive(notification.getBody());
			
			facade.registerMediator(new AppMediator(app));
			//facade.registerMediator( new BookFormMediator( app.bookForm ) );
			//...
			
			//sendNotification(ApplicationFacade.GET_BOOKS);
			//	this.sendNotification(ManagementFacade.APP_INIT_DONE, app);
			this.sendNotification(AppFacade.LOAD_BULLET_LIST);
		}
	}
}