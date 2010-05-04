package org.hamster.magic.common.models.action
{
	public class CardPassiveAction
	{
		public var steps:Array;
		public var availableTargets:Array;
		public var availableTargetsNumber:int = 1;
		public var simpleActions:Array;
		
		public function CardPassiveAction()
		{
		}
		
		public function trigger(step:int, targets:Array):Boolean
		{
			if (steps.indexOf(step) < 0) {
				return false;
			}
		}

	}
}