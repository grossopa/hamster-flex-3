package noorg.magic.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import noorg.magic.models.PlayCard;

	public class PlayCardAttackEvent extends Event
	{
		public static const ADD_ATTACKER:String = "PlayCardAttackEventAddAttacker";
		public static const REMOVE_ATTACKER:String = "PlayCardAttackEventRemoveAttacker";
		public static const ADD_DEFENDER:String = "PlayCardAttackEventAddDefender";
		public static const REMOVE_DEFENDER:String = "PlayCardAttackEventRemoveDefender";
		
		public var playCard:PlayCard;
		public var relatedCards:ArrayCollection;
		
		public function PlayCardAttackEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}