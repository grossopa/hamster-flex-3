package org.hamster.showcase.effects.mediator
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class EffectsModuleMediator extends Mediator
	{
		public static const NAME:String = "EffectsModuleMediator";
		
		public function EffectsModuleMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
		}
	}
}