package org.hamster.test.networks.command.formatter
{
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.hamster.networks.command.IDataFormatter;

	public class TestFormatter implements IDataFormatter
	{
		public function TestFormatter()
		{
			super();
		}
		
		private static var instance:TestFormatter = new TestFormatter();
		
		public static function getInstance():IDataFormatter
		{
			return instance;
		}
		
		public function formatFault(fault:FaultEvent):*
		{
			var str:String = String(fault.fault);
			return str.length;			
		}
		
		public function formatResult(result:ResultEvent):*
		{
			var str:String = String(result.result);
			return str.length;
		}
		
	}
}