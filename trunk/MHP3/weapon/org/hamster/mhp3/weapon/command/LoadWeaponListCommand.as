package org.hamster.mhp3.weapon.command
{
	import org.hamster.mhp3.weapon.vo.proxy.WeaponListVOProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadWeaponListCommand extends SimpleCommand
	{
		public function LoadWeaponListCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var weaponListVOProxy:WeaponListVOProxy = WeaponListVOProxy(facade.retrieveProxy(WeaponListVOProxy.NAME));
			weaponListVOProxy.loadWeaponList();
		}
	}
}