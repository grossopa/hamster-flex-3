package org.hamster.mhp3.weapon.view
{
	import mx.collections.XMLListCollection;
	
	import org.hamster.mhp3.common.facade.AppFacade;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class WeaponModuleMediator extends Mediator
	{
		public static const NAME:String = "org.hamster.mhp3.weapon.view.WeaponModuleMediator";
		
		public function WeaponModuleMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				AppFacade.WEAPON_LIST_RESPONSE
			]
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName()) {
				case AppFacade.WEAPON_LIST_RESPONSE:
					handleWeaponListResponse(notification.getBody());
					break;
			}
		}
		
		private function handleWeaponListResponse(xml:Object):void
		{
			app.weaponListXML = XMLListCollection(xml);
		}
		
		public function get app():WeaponModule
		{
			return WeaponModule(viewComponent);
		}
	}
}