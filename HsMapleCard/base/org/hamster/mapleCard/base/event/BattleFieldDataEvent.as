package org.hamster.mapleCard.base.event
{
	import flash.events.Event;
	
	public class BattleFieldDataEvent extends Event
	{
		public static const HP_CHANGED:String = "BattleFieldDataEvent_hpChanged";
		public static const STATUS_CHANGED:String = "BattleFieldDataEvent_statusChanged";
		public static const ACTIONPROGRESS_CHANGED:String = "BattleFieldDataEvent_actionProgressChanged";
		
		public var oldValue:*;
		public var newValue:*;
		
		public function BattleFieldDataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:BattleFieldDataEvent = new BattleFieldDataEvent(type, bubbles, cancelable);
			result.oldValue = this.oldValue;
			result.newValue = this.newValue;
			return result;
		}
	}
}