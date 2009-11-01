package noorg.magic.models
{
	import mx.collections.ArrayCollection;
	
	import noorg.magic.events.PlayCardEvent;
	import noorg.magic.models.base.AbstractModelSupport;
	import noorg.magic.models.staticValue.CardLocation;
	import noorg.magic.models.staticValue.CardStatus;
	import noorg.magic.utils.CommonArrayUtil;
	
	public class PlayerCardColl extends AbstractModelSupport
	{
		public function PlayerCardColl(cardColl:ArrayCollection)
		{
			this.cardColl = cardColl;
			
			for (var i:int = 0; i < CardLocation.TYPE_COUNT; i++) {
				locationArrays.addItem(new ArrayCollection());
			}
			
			for (i = 0; i < CardStatus.TYPE_COUNT; i++) {
				statusArrays.addItem(new ArrayCollection());
			}
			
			for each (var card:PlayCard in this.cardColl) {
				registCardListener(card);
				this.getLocationArray(card.location).addItem(card);
				this.getStatusArray(card.status).addItem(card);
			}
		}
		
		[ReadOnly]
		public var cardColl:ArrayCollection;
		
		[Bindable]
		public var cardStack:ArrayCollection = new ArrayCollection();
		
		public const locationArrays:ArrayCollection = new ArrayCollection();
		public const statusArrays:ArrayCollection = new ArrayCollection();
		
		public function getLocationArray(type:int):ArrayCollection
		{
			return ArrayCollection(this.locationArrays[type]);
		}
		
		public function getStatusArray(type:int):ArrayCollection
		{
			return ArrayCollection(this.statusArrays[type]);
		}
		
		public function shuffleCard(isNewCardStack:Boolean = false):void
		{
			if (isNewCardStack) {
				cardStack.removeAll();
				for each (var card:PlayCard in cardColl) {
					cardStack.addItem(card);
				}
			}
			var length:int = cardStack.length;
			for(var i:int = 0; i < length; i++) {  
				var j:int = int(Math.random() * length);
				CommonArrayUtil.swapArray(cardStack, i, j);
			}
		}
		
		public function dragCard():PlayCard
		{
			if (this.cardStack.length == 0) {
				return null;
			} else {
				var disEvt:PlayCardEvent = new PlayCardEvent(PlayCardEvent.DRAW_CARD);
				var card:PlayCard = PlayCard(this.cardStack.removeItemAt(this.cardStack.length - 1));
				disEvt.card = card;
				this.dispatchEvent(disEvt);
				this.getLocationArray(CardLocation.HAND).addItem(card);
				return card;
			}
		}
		
		private function cardLocationChangedHandler(evt:PlayCardEvent):void
		{
			var originArr:ArrayCollection = this.getLocationArray(evt.originLocation);
			var newArr:ArrayCollection = this.getLocationArray(evt.newLocation);
			newArr.addItem(originArr.removeItemAt(originArr.getItemIndex(evt.currentTarget)));
		}
		
		private function cardStatusChangedHandler(evt:PlayCardEvent):void
		{
			var originArr:ArrayCollection = this.getStatusArray(evt.originStatus);
			var newArr:ArrayCollection = this.getStatusArray(evt.newStatus);
			newArr.addItem(originArr.removeItemAt(originArr.getItemIndex(evt.currentTarget)));			
		}
		
		private function registCardListener(card:PlayCard):void
		{
			card.addEventListener(PlayCardEvent.LOCATION_CHANGED, cardLocationChangedHandler);
			card.addEventListener(PlayCardEvent.STATUS_CHANGED, cardStatusChangedHandler);
		}
		
		private function unregistCardListener(card:PlayCard):void
		{
			card.removeEventListener(PlayCardEvent.LOCATION_CHANGED, cardLocationChangedHandler);
			card.removeEventListener(PlayCardEvent.STATUS_CHANGED, cardStatusChangedHandler);
		}
		
	}
}