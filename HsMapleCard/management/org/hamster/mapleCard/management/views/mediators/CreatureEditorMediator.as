package org.hamster.mapleCard.management.views.mediators
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.hamster.mapleCard.management.facade.ManagementFacade;
	import org.hamster.mapleCard.management.views.components.CreatureEditor;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class CreatureEditorMediator extends Mediator implements IMediator
	{
		public static const NAME:String = 'CreatureEditorMediator';
		
		public function CreatureEditorMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			this.creatureEditor.addEventListener("saveCreatureCard", onSaveCreatureCardHandler);
			this.creatureEditor.addEventListener("loadCreatureCard", onLoadCreatureCardHandler);
			this.creatureEditor.addEventListener("loadAllCreatureCards", onLoadAllCreatureCardsHandler);
			
		}
		
		protected function onSaveCreatureCardHandler(evt:Event):void
		{
			this.sendNotification(ManagementFacade.SAVE_CREATURE, this.creatureEditor.currentCard);
		}
		
		protected function onLoadCreatureCardHandler(evt:Event):void
		{
			this.sendNotification(ManagementFacade.LOAD_CREATURE, "0100100");
		}
		
		protected function onLoadAllCreatureCardsHandler(evt:Event):void
		{
			this.sendNotification(ManagementFacade.LOAD_ALL_CREATURES);
		}
		
		public function get creatureEditor():CreatureEditor
		{
			return viewComponent as CreatureEditor;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ManagementFacade.LOAD_ALL_CREATURES_DONE,
				ManagementFacade.LOAD_CREATURE_DONE,
				ManagementFacade.SAVE_CREATURE_DONE,
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName()) {
				case ManagementFacade.LOAD_CREATURE_DONE:
					break;
				case ManagementFacade.SAVE_CREATURE_DONE:
					break;
				case ManagementFacade.LOAD_ALL_CREATURES_DONE:
					this.creatureEditor.allCards = notification.getBody() as ArrayCollection;
					break;
			}
		}
	}
}