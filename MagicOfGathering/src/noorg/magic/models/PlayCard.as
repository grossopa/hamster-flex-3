package noorg.magic.models
{
	import mx.collections.ArrayCollection;
	
	import noorg.magic.actions.ActionManager;
	import noorg.magic.actions.base.ICardAction;
	import noorg.magic.events.PlayCardEvent;
	
	public class PlayCard extends Card
	{
		private var _location:int;
		private var _status:int;
		private var _player:Player;
		private var _actionManager:ActionManager;
		
		public const enhancementCards:ArrayCollection = new ArrayCollection();
		
		public function setLocation(value:int, index:int = -1):void
		{
			var locationEvt:PlayCardEvent = new PlayCardEvent(PlayCardEvent.LOCATION_CHANGED);
			locationEvt.originLocation = this._location;
			locationEvt.index = index;
			_location = value;
			locationEvt.newLocation = this._location;
			this.dispatchEvent(locationEvt);
		}
		
		public function getLocation():int
		{
			return _location;
		}
		
		public function set status(value:int):void
		{
			var statusEvt:PlayCardEvent = new PlayCardEvent(PlayCardEvent.STATUS_CHANGED);
			statusEvt.originStatus = this.status;
			_status = value;
			statusEvt.newStatus = this.status;
			this.dispatchEvent(statusEvt);
		}
		
		[Bindable]
		public function get status():int
		{
			return _status;
		}
		
		public function get player():Player
		{
			return _player;
		}
		
		public function PlayCard(player:Player)
		{
			super();
			_player = player;
			//this.enhancementCards.addEventListener(CollectionEvent.COLLECTION_CHANGE, enhancementCardChangeHandler);
		}
		
		public function getAction(type:String):ICardAction
		{
//			for each (var cardAct:ICardAction in this._actions) {
//				if (cardAct.actType == type) {
//					return cardAct;
//				}
//			}
			return null;
		}
		
		//protected function enhancementCardChangeHandler(evt:CollectionEvent):void
		//{
		//	
		//}
		

		
	}
}