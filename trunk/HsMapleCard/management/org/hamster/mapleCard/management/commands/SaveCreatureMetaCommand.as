package org.hamster.mapleCard.management.commands
{
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	import org.hamster.mapleCard.base.model.card.CreatureCard;
	import org.hamster.mapleCard.management.delegates.CreatureMetaDelegate;
	import org.hamster.mapleCard.management.facade.ManagementFacade;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SaveCreatureMetaCommand extends SimpleCommand implements ICommand, IResponder
	{
		private var meta:CreatureCard;
		
		public function SaveCreatureMetaCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			meta = notification.getBody() as CreatureCard;
			var delegate:CreatureMetaDelegate = new CreatureMetaDelegate(this);
			delegate.saveCreatureMeta(meta);
		}
		
		public function result(data:Object):void
		{
			this.sendNotification(ManagementFacade.LOAD_CREATURE_DONE, meta);
		}
		
		public function fault(info:Object):void
		{
			Alert.show(info.toString());
		}
	}
}