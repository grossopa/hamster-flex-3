// ActionScript file
import flash.display.GradientType;
import flash.display.Graphics;
import flash.events.MouseEvent;
import flash.geom.Matrix;

import mx.collections.ArrayCollection;
import mx.events.ChildExistenceChangedEvent;
import mx.events.CollectionEvent;
import mx.events.CollectionEventKind;

import org.hamster.magic.common.models.PlayCard;
import org.hamster.magic.common.services.DataService;
import org.hamster.magic.common.services.EventService;
import org.hamster.magic.play.controls.units.PlayCardUnit;

private static const DS:DataService = DataService.getInstance();
private static const ES:EventService = EventService.getInstance();

private var _cardArray:ArrayCollection;

public function set cardArray(value:ArrayCollection):void
{
	if (_cardArray != null) {
		_cardArray.removeEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangedHandler);
	}
	_cardArray = value;
	_cardArray.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangedHandler);
}

[Bindable]
public function get cardArray():ArrayCollection
{
	return _cardArray;
}

protected function completeHandler():void
{
	this.mainContainer.addEventListener(ChildExistenceChangedEvent.CHILD_ADD, childAddHandler);
	this.mainContainer.addEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, childRemoveHandler);
}

private function childAddHandler(evt:ChildExistenceChangedEvent):void
{
	var unit:PlayCardUnit = PlayCardUnit(evt.relatedObject);
	unit.addEventListener(MouseEvent.ROLL_OVER, playCardRollOverHandler);
	unit.addEventListener(MouseEvent.ROLL_OUT, playCardRollOutHandler);
}

private function childRemoveHandler(evt:ChildExistenceChangedEvent):void
{
	var unit:PlayCardUnit = PlayCardUnit(evt.relatedObject);
	unit.removeEventListener(MouseEvent.ROLL_OVER, playCardRollOverHandler);
	unit.removeEventListener(MouseEvent.ROLL_OUT, playCardRollOutHandler);	
}

private function playCardRollOverHandler(evt:MouseEvent):void
{
	ES.showDetail(PlayCardUnit(evt.currentTarget).card);
}

private function playCardRollOutHandler(evt:MouseEvent):void
{
	ES.hideDetail();
}

private function collectionChangedHandler(evt:CollectionEvent):void
{
	var hasIt:Boolean = false;
	var playCard:PlayCard;
	var playCardUnit:PlayCardUnit;
	
	if (evt.kind == CollectionEventKind.ADD) {
		for each (playCard in this.cardArray) {
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
			for each (playCard in this.cardArray) {
				if (playCardUnit.card == playCard) {
					hasIt = true;
				}
			}
			if (!hasIt) {
				this.mainContainer.removeChild(playCardUnit);
			}
		}		
	}
	
	for each (playCard in this.cardArray) {
		for each (playCardUnit in this.mainContainer.getChildren()) {
			if (playCardUnit.card == playCard) {
				this.mainContainer.setChildIndex(playCardUnit, cardArray.getItemIndex(playCard));
			}
		}
	}
}

override protected function updateDisplayList(uw:Number, uh:Number):void
{
	super.updateDisplayList(uw, uh);
	
	var bgGraphics:Graphics = backgroundUIComponent.graphics;
	bgGraphics.clear();
	var m:Matrix = new Matrix();
	m.createGradientBox(uw, uh, Math.PI / 2);
	bgGraphics.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xFFFFFF, 0xFFFFFF], [0, 0.7, 0], [0x00, 0x7F, 0xFF], m);
	bgGraphics.drawRect(0, 0, uw, uh);
	bgGraphics.endFill();
}