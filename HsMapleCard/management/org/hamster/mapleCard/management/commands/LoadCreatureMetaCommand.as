package org.hamster.mapleCard.management.commands
{
	import flash.filesystem.FileStream;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import org.hamster.mapleCard.base.commands.CreatureCardLoaderCmd;
	import org.hamster.mapleCard.base.model.card.CreatureCard;
	import org.hamster.mapleCard.management.delegates.CreatureMetaDelegate;
	import org.hamster.mapleCard.management.facade.ManagementFacade;
	import org.hamster.mapleCard.management.models.CreatureCardProxy;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadCreatureMetaCommand extends SimpleCommand implements ICommand, IResponder
	{
		public function LoadCreatureMetaCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var id:String = notification.getBody() as String;
			var delegate:CreatureMetaDelegate = new CreatureMetaDelegate(this);
			delegate.getCreatureMeta(id);
		}
		
		public function result(data:Object):void
		{
			var str:String = data as String;
			var creatureCard:CreatureCard = new CreatureCard();
			creatureCard.decode(new XML(str));
			var creatureCardProxy:CreatureCardProxy = facade.retrieveProxy(CreatureCardProxy.NAME) as CreatureCardProxy;
			creatureCardProxy.addCreatureCard(creatureCard);
			this.sendNotification(ManagementFacade.LOAD_CREATURE_DONE, creatureCard);
		}
		
		public function fault(info:Object):void
		{
			Alert.show(info.toString());
		}
	}
}