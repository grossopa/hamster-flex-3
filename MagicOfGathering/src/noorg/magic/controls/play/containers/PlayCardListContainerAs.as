// ActionScript file
import flash.display.Graphics;

import mx.collections.ArrayCollection;
import mx.events.CollectionEvent;
import mx.events.CollectionEventKind;
import mx.events.DragEvent;
import mx.managers.DragManager;

import noorg.magic.controls.play.unit.PlayCardUnit;
import noorg.magic.events.PlayCardDragEvent;
import noorg.magic.models.PlayCard;
import noorg.magic.services.DataService;
import noorg.magic.services.EventService;
import noorg.magic.utils.Constants;Constants;

private const DS:DataService = DataService.getInstance();
private const ES:EventService = EventService.getInstance();

private var _cardColl:ArrayCollection;

public function set cardColl(value:ArrayCollection):void
{
	_cardColl = value;
	_cardColl.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangedHandler);
}

[Bindable]
public function get cardColl():ArrayCollection
{
	return _cardColl;
}

private function collectionChangedHandler(evt:CollectionEvent):void
{
	var hasIt:Boolean = false;
	var playCard:PlayCard;
	var playCardUnit:PlayCardUnit;
	
	if (evt.kind == CollectionEventKind.ADD) {
		for each (playCard in this.cardColl) {
			hasIt = false;
			for each (playCardUnit in this.mainContainer.getChildren()) {
				if (playCardUnit.card == playCard) {
					hasIt = true;
				}
			}
			if (!hasIt) {
				var unit:PlayCardUnit = DS.getPlayCardUnitByCard(playCard);
				this.mainContainer.addChild(unit);
			}
		}
	}
	
	if (evt.kind == CollectionEventKind.REMOVE) {
		for each (playCardUnit in this.mainContainer.getChildren()) {
			hasIt = false;
			for each (playCard in this.cardColl) {
				if (playCardUnit.card == playCard) {
					hasIt = true;
				}
			}
			if (!hasIt) {
				this.mainContainer.removeChild(playCardUnit);
			}
		}		
	}
	
	for each (playCard in this.cardColl) {
		for each (playCardUnit in this.mainContainer.getChildren()) {
			if (playCardUnit.card == playCard) {
				this.mainContainer.setChildIndex(playCardUnit, cardColl.getItemIndex(playCard));
			}
		}
	}
}

private function completeHandler():void
{
	mainContainer.addEventListener(PlayCardDragEvent.DRAG_ENTER, itemDragEnterHandler);
	mainContainer.addEventListener(PlayCardDragEvent.DRAG_DROP, itemDragDropHandler);
}

private function itemDragEnterHandler(evt:PlayCardDragEvent):void
{
	var index:int;
	if (evt.target is PlayCardUnit) {
		var unit:PlayCardUnit = PlayCardUnit(evt.target);
		index = this.cardColl.getItemIndex(unit.card);
	}
	insertLine.visible = true;
	
	if (evt.enterLeftSide) {
	} else {
		index += 1; 
	}
	
	this.insertLine.x = index * Constants.PLAY_CARD_WIDTH;
}

private function itemDragDropHandler(evt:PlayCardDragEvent):void
{
	trace (this.cardColl.length);
	
	evt.playCard.location = locationType;
	
	trace (this.cardColl.length);
}

private function listDragEnterHandler(evt:DragEvent):void
{
	DragManager.acceptDragDrop(this.mainContainer);
}

private function listDragDropHandler(evt:DragEvent):void
{
	if (evt.dragInitiator is PlayCardUnit) {
		var unit:PlayCardUnit = PlayCardUnit(evt.dragInitiator);
		PlayCard(unit.card).location = this.locationType;
	}
}

private function moveLeftHandler():void
{
	
}

private function moveRightHandler():void
{
	
}

override protected function updateDisplayList(uw:Number, uh:Number):void
{
	super.updateDisplayList(uw, uh);
	
	var g:Graphics = this.insertLine.graphics;
	g.clear();
	g.beginFill(0x192476);
	g.drawRect(0, 0, insertLine.width, insertLine.height);
	g.endFill();
}