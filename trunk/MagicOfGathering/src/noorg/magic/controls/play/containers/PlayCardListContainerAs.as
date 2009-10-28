// ActionScript file
import mx.collections.ArrayCollection;
import mx.events.CollectionEvent;
import mx.events.CollectionEventKind;

import noorg.magic.controls.play.unit.PlayCardUnit;
import noorg.magic.models.PlayCard;

public var locationType:int;
public const curCards:ArrayCollection = new ArrayCollection();
private var _cardColl:ArrayCollection;

public function set cardColl(value:ArrayCollection):void
{
	if (_cardColl != null) {
		_cardColl.removeEventListener(CollectionEvent.COLLECTION_CHANGE, cardCollectionChangedHandler);
	}
	_cardColl = value;
	_cardColl.addEventListener(CollectionEvent.COLLECTION_CHANGE, cardCollectionChangedHandler);
}

public function get cardColl():ArrayCollection
{
	return _cardColl;
}

public function refreshItemList():void
{
	curCards.removeAll();
	for each (var playCard:PlayCard in _cardColl) {
		if (playCard.location == locationType) {
			this.curCards.addItem(playCard);
			var playCardUnit:PlayCardUnit = new PlayCardUnit();
			this.mainHBox.addChild(playCardUnit);
		}
	}
}

private function cardCollectionChangedHandler(evt:CollectionEvent):void
{
	if (evt.kind == CollectionEventKind.ADD) {
		for each (var card:PlayCard in this.curCards) {
			for each (var child:PlayCardUnit in this.mainHBox.getChildren()) {
			
			}
		}
	} else if (evt.kind == CollectionEventKind.REMOVE) {
		
	}
}


private function registCardListener(card:PlayCard):void
{
	
}

private function unregistCardListener(card:PlayCard):void
{
	
}

private function moveLeftHandler():void
{
	
}

private function moveRightHandler():void
{
	
}