package org.hamster.mapleCard.base.event
{
	import flash.events.Event;
	
	public class BattleFieldDataEvent extends Event
	{
		public static const HP_CHANGED:String = "BattleFieldDataEvent_hpChanged";
		public static const STATUS_CHANGED:String = "BattleFieldDataEvent_statusChanged";
		public static const ACTIONPROGRESS_CHANGED:String = "BattleFieldDataEvent_actionProgressChanged";
		public static const INDEX_CHANGED:String = "BattleFieldDataEvent_indexChanged";
		
		public var oldValue:*;
		public var newValue:*;
		
		public var oldXIndex:int;
		public var newXIndex:int;
		public var oldYIndex:int;
		public var newYIndex:int;
		
		public function BattleFieldDataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:BattleFieldDataEvent = new BattleFieldDataEvent(type, bubbles, cancelable);
			result.oldValue = this.oldValue;
			result.newValue = this.newValue;
			result.oldXIndex = this.oldXIndex;
			result.oldYIndex = this.oldYIndex;
			result.newXIndex = this.newXIndex;
			result.newYIndex = this.newYIndex;
			return result;
		}
	}
}