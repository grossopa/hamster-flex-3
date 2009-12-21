// ActionScript file
import mx.collections.ArrayCollection;

import noorg.magic.events.PlayCardEvent;
import noorg.magic.models.PlayCard;
import noorg.magic.utils.GlobalUtil;

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

private function completeHandler():void
{
	this.addEventListener(PlayCardEvent.ENHANCE_CHANGE, enhanceChangeHandler);
}

private function enhanceChangeHandler(evt:PlayCardEvent):void
{
	var enhanceCard:PlayCard = evt.card;
	this.playCard.enhancementCards.removeItemAt(
			this.playCard.enhancementCards.getItemIndex(enhanceCard));
}

private function closeHandler():void
{
	GlobalUtil.removePopup(this);
}

