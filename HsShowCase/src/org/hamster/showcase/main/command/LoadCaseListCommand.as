package org.hamster.showcase.main.command
{
	import org.hamster.showcase.main.vo.proxy.CaseVOProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadCaseListCommand extends SimpleCommand
	{
		public function LoadCaseListCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var proxy:CaseVOProxy = CaseVOProxy(facade.retrieveProxy(CaseVOProxy.NAME));
			proxy.loadCaseList();
		}
	}
}