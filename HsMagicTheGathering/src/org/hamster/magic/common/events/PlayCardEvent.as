package org.hamster.magic.common.events
{
	import flash.events.Event;
	
	import org.hamster.magic.common.models.PlayCard;

	public class PlayCardEvent extends Event
	{
		public static const DRAW_CARD:String = "PlayCardEventDrawCard";
		
		public static const SHOW_DETAIL:String = "PlayCardEventShowDetail";
		
		public static const LOCATION_CHANGED:String = "PlayCardEventLocationChanged";
		public static const STATUS_CHANGED:String = "PlayCardEventStatusChanged";
		public static const ENHANCE_CHANGE:String = "PlayCardEventEnhanceChange";
		public static const POOL_ENOUGH_STATUS_CHANGE:String = "PlayCardEventPoolEnoughStatusChange";
		
		public var card:PlayCard;
		
		public var oldLocation:int = -1;
		public var newLocation:int = -1;
		
		public var index:int;
		
		public var oldStatus:int = -1;
		public var newStatus:int = -1;
		
		public var isPoolEnough:Boolean;
		
		public function PlayCardEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:PlayCardEvent = new PlayCardEvent(this.type, this.bubbles, this.cancelable);
			result.oldLocation = this.oldLocation;
			result.newLocation = this.newLocation;
			result.index = this.index;
			result.oldStatus = this.oldStatus;
			result.newStatus = this.newStatus;
			return result;
		}
		
	}
}