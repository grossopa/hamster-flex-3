package org.hamster.mapleCard.management.commands
{
	import org.hamster.mapleCard.management.facade.ManagementFacade;
	import org.hamster.mapleCard.management.models.CreatureCardProxy;
	import org.hamster.mapleCard.management.views.mediators.CreatureEditorMediator;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class InitManagementCommand extends SimpleCommand implements ICommand
	{
		public function InitManagementCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			facade.registerProxy( new CreatureCardProxy() );
			
			var app:MapleCardManagement = notification.getBody() as MapleCardManagement;
			
			facade.registerMediator( new CreatureEditorMediator(app.creatureEditor));
			//facade.registerMediator( new BookFormMediator( app.bookForm ) );
			//...
			
			//sendNotification(ApplicationFacade.GET_BOOKS);
		}
	}
}