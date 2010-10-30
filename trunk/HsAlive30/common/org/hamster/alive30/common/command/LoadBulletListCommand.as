package org.hamster.alive30.common.command
{
	import org.hamster.alive30.game.model.vo.proxy.BulletListVOProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadBulletListCommand extends SimpleCommand
	{
		public function LoadBulletListCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var proxy:BulletListVOProxy = BulletListVOProxy(facade.retrieveProxy(BulletListVOProxy.NAME));
			proxy.loadBulletList();
		}
	}
}