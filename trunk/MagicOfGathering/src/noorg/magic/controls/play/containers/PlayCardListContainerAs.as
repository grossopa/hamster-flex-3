// ActionScript file
import mx.collections.ArrayCollection;

import noorg.magic.controls.play.unit.PlayCardUnit;
import noorg.magic.models.CardCollection;
import noorg.magic.models.PlayCard;

public var locationType:int;
public const curCards:ArrayCollection = new ArrayCollection();
private var _cardColl:CardCollection;

public function set cardColl(value:CardCollection):void
{
	_cardColl = value;
}

public function get cardColl():CardCollection
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