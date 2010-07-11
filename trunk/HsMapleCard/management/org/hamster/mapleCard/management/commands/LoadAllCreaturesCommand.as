package org.hamster.mapleCard.management.commands
{
	import flash.filesystem.File;
	
	import mx.rpc.IResponder;
	
	import org.hamster.mapleCard.base.model.card.CreatureCard;
	import org.hamster.mapleCard.base.utils.FileUtil;
	import org.hamster.mapleCard.management.facade.ManagementFacade;
	import org.hamster.mapleCard.management.models.CreatureCardProxy;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadAllCreaturesCommand extends SimpleCommand implements ICommand, IResponder
	{
		private var listIds:Array = new Array();
		
		public function LoadAllCreaturesCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var creatureFolder:File = FileUtil.creatureDir;
			var subList:Array = creatureFolder.getDirectoryListing();
			for each (var file:File in subList) {
				if (file.isDirectory) {
					listIds.push(file.name);
				}
			}
			
			if (subList.length == 0) {
				this.sendNotification(ManagementFacade.LOAD_ALL_CREATURES_DONE, []);
			} else {
				var creatureCardProxy:CreatureCardProxy = facade.retrieveProxy(CreatureCardProxy.NAME) as CreatureCardProxy;
				for each (var id:String in listIds) {
					var creatureCard:CreatureCard = new CreatureCard();
					creatureCard.id = id;
					creatureCardProxy.addCreatureCard(creatureCard);
					this.sendNotification(ManagementFacade.LOAD_CREATURE, id);
				}
				this.sendNotification(ManagementFacade.LOAD_ALL_CREATURES_DONE, creatureCardProxy.allCards);
			}
		}
		
		public function result(data:Object):void
		{
		}
		
		public function fault(info:Object):void
		{
		}
	}
}