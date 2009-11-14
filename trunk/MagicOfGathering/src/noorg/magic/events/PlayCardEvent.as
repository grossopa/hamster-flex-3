package noorg.magic.events
{
	import flash.events.Event;
	
	import noorg.magic.models.PlayCard;

	public class PlayCardEvent extends Event
	{
		public static const DRAW_CARD:String = "PlayCardEventDrawCard";
		
		public static const SHOW_DETAIL:String = "PlayCardEventShowDetail";
		
		public static const LOCATION_CHANGED:String = "PlayCardEventLocationChanged";
		public static const STATUS_CHANGED:String = "PlayCardEventStatusChanged";
		public static const ENHANCE_CHANGE:String = "PlayCardEventEnhanceChange";
		
		public var card:PlayCard;
		
		public var originLocation:int = -1;
		public var newLocation:int = -1;
		
		public var originStatus:int = -1;
		public var newStatus:int = -1;
		
		public function PlayCardEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:PlayCardEvent = new PlayCardEvent(this.type, this.bubbles, this.cancelable);
			result.originLocation = this.originLocation;
			result.newLocation = this.newLocation;
			result.originStatus = this.originStatus;
			result.newStatus = this.newStatus;
			return result;
		}
		
	}
}