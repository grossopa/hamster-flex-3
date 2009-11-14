// ActionScript file
import mx.collections.ArrayCollection;

import noorg.magic.models.PlayCard;

private var _playCard:PlayCard;
[Bindable]
private var _cardColl:ArrayCollection;

public function set playCard(value:PlayCard):void
{
	this._playCard = value;
	_cardColl = playCard.enhancementCards;
}

public function get playCard():PlayCard
{
	return this._playCard;
}

