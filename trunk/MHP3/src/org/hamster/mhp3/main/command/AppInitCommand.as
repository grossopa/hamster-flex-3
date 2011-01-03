package org.hamster.mhp3.main.command
{
	import org.hamster.mhp3.common.facade.AppFacade;
	import org.hamster.mhp3.main.view.AppMediator;
	import org.hamster.mhp3.weapon.command.LoadWeaponListCommand;
	import org.hamster.mhp3.weapon.view.WeaponModuleMediator;
	import org.hamster.mhp3.weapon.vo.proxy.WeaponListVOProxy;
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
			facade.registerProxy(new WeaponListVOProxy());
			
			facade.registerCommand(AppFacade.WEAPON_LIST_REQUEST, LoadWeaponListCommand);
			
			var app:MHP3 = notification.getBody() as MHP3;
			facade.registerMediator(new AppMediator(app));
			facade.registerMediator(new WeaponModuleMediator(app.weaponModule));
			
			this.sendNotification(AppFacade.WEAPON_LIST_REQUEST);
		}
	}
}