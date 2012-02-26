package org.hamster.framework.puremvc
{
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class HsSimpleCommand extends SimpleCommand
	{
		private var log:ILogger = Log.getLogger("pureMVC");
		
		public function HsSimpleCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
		}
	}
}