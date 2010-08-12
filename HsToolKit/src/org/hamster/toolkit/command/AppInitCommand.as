package org.hamster.toolkit.command
{
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
		//	facade.registerProxy( new CreatureCardProxy() );
			
		//	var app:MapleCardManagement = notification.getBody() as MapleCardManagement;
			
		//	facade.registerMediator( new CreatureEditorMediator(app.creatureEditor));
			//facade.registerMediator( new BookFormMediator( app.bookForm ) );
			//...
			
			//sendNotification(ApplicationFacade.GET_BOOKS);
		//	this.sendNotification(ManagementFacade.APP_INIT_DONE, app);
		}
	}
}