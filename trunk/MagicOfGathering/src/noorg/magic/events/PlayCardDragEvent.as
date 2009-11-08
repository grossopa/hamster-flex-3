package noorg.magic.events
{
	import flash.events.Event;
	
	import noorg.magic.models.PlayCard;

	public class PlayCardDragEvent extends Event
	{
		public static const DRAG_ENTER:String = "PlayCardEventDragEnter";
		public static const DRAG_DROP:String = "PlaycardEventDragDrop";
		
		public var enterLeftSide:Boolean;
		public var playCard:PlayCard;
		
		public function PlayCardDragEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var result:PlayCardDragEvent = new PlayCardDragEvent(type, bubbles, cancelable);
			result.enterLeftSide = this.enterLeftSide;
			return result;
		}
		
	}
}