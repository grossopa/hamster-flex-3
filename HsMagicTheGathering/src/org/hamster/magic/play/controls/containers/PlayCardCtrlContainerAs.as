// ActionScript file
import org.hamster.magic.common.events.CardUnitEvent;
import org.hamster.magic.common.models.PlayCard;
import org.hamster.magic.common.models.utils.CardStatus;
import org.hamster.magic.common.services.EventService;

private static const ES:EventService = EventService.getInstance();

private var _playCard:PlayCard;

public function set playCard(value:PlayCard):void
{
	this._playCard = value;
}

public function get playCard():PlayCard
{
	return this._playCard;
}

private function completeHandler():void
{
	ES.addEventListener(CardUnitEvent.SELECT_CARD, selectCardHandler);
	ES.addEventListener(CardUnitEvent.UNSELECT_CARD, unselectCardHandler);
}

private function selectCardHandler(evt:CardUnitEvent):void
{
	this.playCard = PlayCard(evt.card);
}

private function unselectCardHandler(evt:CardUnitEvent):void
{
	this.playCard = null;
}

private function tapCardHandler():void
{
	this.playCard = PlayCard(ES.curSelectedCardUnit.card);
	if (this.playCard != null) {
		this.playCard.status = CardStatus.PLAY_TAPPED;
	}
}