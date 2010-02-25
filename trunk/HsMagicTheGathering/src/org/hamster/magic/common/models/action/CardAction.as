package org.hamster.magic.common.models.action
{
	import org.hamster.magic.common.models.Magic;
	
	public class CardAction
	{
		public var steps:Array;
		public var cost:Magic;
		public var targets:Array;
		public var targetsNumber:int = 1;
		public var simpleActions:Array;
		
		public function CardAction()
		{
		}
		
		public function execute():void
		{
			
		}

	}
}