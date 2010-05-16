// ActionScript file
import flash.display.GradientType;
import flash.display.Graphics;
import flash.events.MouseEvent;
import flash.geom.Matrix;

import mx.collections.ArrayCollection;
import mx.effects.Rotate;
import mx.events.ChildExistenceChangedEvent;
import mx.events.CollectionEvent;
import mx.events.CollectionEventKind;
import mx.events.ResizeEvent;

import org.hamster.magic.common.events.PlayCardEvent;
import org.hamster.magic.common.models.Card;
import org.hamster.magic.common.models.PlayCard;
import org.hamster.magic.common.models.Player;
import org.hamster.magic.common.models.utils.CardStatus;
import org.hamster.magic.common.services.DataService;
import org.hamster.magic.common.services.EventService;
import org.hamster.magic.common.utils.Constants;
import org.hamster.magic.play.controls.units.PlayCardUnit;

public static const HORIZONTAL_GAP:int = 2;

private static const DS:DataService = DataService.getInstance();
private static const ES:EventService = EventService.getInstance();

private var _cardArray:ArrayCollection;
private var _player:Player;

public function set player(value:Player):void
{
	this._player = value;
}

public function get player():Player
{
	return this._player;
}

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
	unit.addEventListener(ResizeEvent.RESIZE, playCardResizeHandler);
	unit.addEventListener(PlayCardEvent.STATUS_CHANGED, playCardStatusChangedHandler);
	unit.addEventListener(MouseEvent.ROLL_OVER, playCardRollOverHandler);
	unit.addEventListener(MouseEvent.ROLL_OUT, playCardRollOutHandler);
	unit.addEventListener(MouseEvent.CLICK, playCardClickHandler);
}

private function childRemoveHandler(evt:ChildExistenceChangedEvent):void
{
	var unit:PlayCardUnit = PlayCardUnit(evt.relatedObject);
	unit.removeEventListener(ResizeEvent.RESIZE, playCardResizeHandler);
	unit.removeEventListener(PlayCardEvent.STATUS_CHANGED, playCardStatusChangedHandler);
	unit.removeEventListener(MouseEvent.ROLL_OVER, playCardRollOverHandler);
	unit.removeEventListener(MouseEvent.ROLL_OUT, playCardRollOutHandler);
	unit.removeEventListener(MouseEvent.CLICK, playCardClickHandler);	
}

private function playCardResizeHandler(evt:ResizeEvent):void
{
	arrangePlayCards();
}

private function playCardStatusChangedHandler(evt:PlayCardEvent):void
{
	var rotate:Rotate;
	var unit:PlayCardUnit = PlayCardUnit(evt.currentTarget);
	var playCard:PlayCard = evt.card;
	if (playCard.status == CardStatus.PLAY_TAPPED) {
		rotate = new Rotate(unit);
		rotate.angleFrom = 0;
		rotate.angleTo = -90;
		rotate.duration = 250;
		rotate.originX = unit.width >> 1;
		rotate.originY = unit.width >> 1;
		rotate.play();
	} else if (playCard.status == CardStatus.PLAY) {
		rotate = new Rotate(unit);
		// rotate.angleFrom = 90;
		rotate.angleTo = 0;
		rotate.duration = 250;
		// rotate.originX = this.width >> 1;
		// rotate.originY = this.width >> 1;
		rotate.play();
	}	
}

private function playCardRollOverHandler(evt:MouseEvent):void
{
	ES.showDetail(PlayCardUnit(evt.currentTarget).card);
}

private function playCardRollOutHandler(evt:MouseEvent):void
{
	ES.hideDetail();
}

private function playCardClickHandler(evt:MouseEvent):void
{
	var unit:PlayCardUnit = PlayCardUnit(evt.currentTarget);
	var curCard:Card = unit.card;
	if (ES.curSelectedCardUnit != null) {
		ES.curSelectedCardUnit.selected = false;
	}	
	
	if (ES.curSelectedCardUnit == null 
			|| curCard != ES.curSelectedCardUnit.card) {
		ES.selectCard(unit);
		unit.selected = true;
	} else {
		ES.unselectCard();
	}
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
				PlayCard(unit.card).status = CardStatus.PLAY;
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
	
	arrangePlayCards();
}

protected function arrangePlayCards():void
{
	var nextX:Number = 0;
	for each (var playCardUnit:PlayCardUnit in this.mainContainer.getChildren()) {
		playCardUnit.enabled = true;
		playCardUnit.move(nextX, playCardUnit.y);
		nextX += HORIZONTAL_GAP + playCardUnit.width;
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