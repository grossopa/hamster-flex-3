// ActionScript file
import mx.collections.ArrayCollection;
import mx.events.DragEvent;
import mx.events.ListEvent;
import mx.managers.DragManager;

import noorg.magic.controls.play.unit.PlayCardUnit;
import noorg.magic.models.PlayCard;
import noorg.magic.services.EventService;
import noorg.magic.utils.Constants;Constants;

private const ES:EventService = EventService.getInstance();

public var locationType:int;

private var _cardColl:ArrayCollection;

public function set cardColl(value:ArrayCollection):void
{
	_cardColl = value;
}

[Bindable]
public function get cardColl():ArrayCollection
{
	return _cardColl;
}

private function listDragEnterHandler(evt:DragEvent):void
{
	DragManager.acceptDragDrop(mainContainer);
	// var playCard:PlayCard = PlayCard(PlayCardUnit(evt).card);
}

private function moveLeftHandler():void
{
	
}

private function moveRightHandler():void
{
	
}

private function itemClickHandler(evt:ListEvent):void
{
	var playCardUnit:PlayCardUnit = PlayCardUnit(evt.itemRenderer);
	ES.dragPlayCard(PlayCard(playCardUnit.card));
	
}