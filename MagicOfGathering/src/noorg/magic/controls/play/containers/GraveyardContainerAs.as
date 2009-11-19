// ActionScript file
import mx.collections.ArrayCollection;
import mx.core.UIComponent;
import mx.events.CollectionEvent;
import mx.events.DragEvent;
import mx.managers.DragManager;

import noorg.magic.controls.play.unit.PlayCardUnit;
import noorg.magic.models.PlayCard;
import noorg.magic.models.Player;
import noorg.magic.models.staticValue.CardLocation;
import noorg.magic.services.AssetService;
import noorg.magic.utils.Constants;
import noorg.magic.utils.GlobalUtil;Constants;

private const AS:AssetService = AssetService.getInstance();

private var _player:Player;
private var _cardColl:ArrayCollection;

public var cardLocation:int = CardLocation.GRAVEYARD;

[Bindable]
private var _source:Object;

public function set player(value:Player):void
{
	this._player = value;
	if (_cardColl != null) {
		_cardColl.removeEventListener(CollectionEvent.COLLECTION_CHANGE, cardCollChangeHandler);
	}
	_cardColl = player.playerCardColl.getLocationArray(cardLocation);
	_cardColl.addEventListener(CollectionEvent.COLLECTION_CHANGE, cardCollChangeHandler);
}

public function get player():Player
{
	return this._player;
}

private function completeHandler():void
{
	refreshTopCard();
}

public function refreshTopCard():void
{
	if (_cardColl == null || _cardColl.length == 0) {
		_source = new AS.CardBack;
	} else {
		_source = PlayCard(_cardColl[_cardColl.length - 1]).imgPath;
	}
}

private function cardCollChangeHandler(evt:CollectionEvent):void
{
	refreshTopCard();
}

private function imageDoubleClickHandler():void
{
	GlobalUtil.showGraveyardDetailPopup(this.player, this.cardLocation);
}

private function imageDragEnterHandler(evt:DragEvent):void
{
	if (evt.dragInitiator is PlayCardUnit) {
		DragManager.acceptDragDrop(UIComponent(evt.currentTarget));
	}
}

private function imageDragDropHandler(evt:DragEvent):void
{
	if (evt.dragInitiator is PlayCardUnit) {
		var unit:PlayCardUnit = PlayCardUnit(evt.dragInitiator);
		PlayCard(unit.card).setLocation(cardLocation);
	}
}

