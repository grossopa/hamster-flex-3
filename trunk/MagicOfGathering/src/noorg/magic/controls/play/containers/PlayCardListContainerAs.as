// ActionScript file
import flash.display.Bitmap;
import flash.display.Graphics;
import flash.events.MouseEvent;
import flash.geom.Matrix;

import mx.collections.ArrayCollection;
import mx.effects.AnimateProperty;
import mx.effects.Fade;
import mx.effects.easing.Linear;
import mx.events.CollectionEvent;
import mx.events.CollectionEventKind;
import mx.events.DragEvent;
import mx.managers.DragManager;

import noorg.magic.controls.play.unit.PlayCardUnit;
import noorg.magic.events.PlayCardDragEvent;
import noorg.magic.models.PlayCard;
import noorg.magic.services.AssetService;
import noorg.magic.services.DataService;
import noorg.magic.services.EventService;
import noorg.magic.utils.Constants;
import noorg.magic.utils.GlobalUtil;Constants;

private const AS:AssetService = AssetService.getInstance();
private const DS:DataService = DataService.getInstance();
private const ES:EventService = EventService.getInstance();

public static const SCROLL_DURATION:Number = 100;
public static const BTN_DURATION:Number = 250;

private var _fadeLeft:Fade = new Fade();
private var _fadeRight:Fade = new Fade();

private var _isListHide:Boolean;

private var _cardColl:ArrayCollection;

private var _scrollBarAni:AnimateProperty = new AnimateProperty();

public function set mainContainerHScrollBarPos(value:Number):void
{
	this.mainContainer.horizontalScrollPosition = value;
}

public function get mainContainerHScrollBarPos():Number
{
	return this.mainContainer.horizontalScrollPosition;
}

public function set cardColl(value:ArrayCollection):void
{
	if (_cardColl != null) {
		_cardColl.removeEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangedHandler);
	}
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
				unit.addEventListener(MouseEvent.ROLL_OUT, unitRollOutHandler);
				unit.addEventListener(MouseEvent.ROLL_OVER, unitRollOverHandler);
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
				playCardUnit.removeEventListener(MouseEvent.ROLL_OUT, unitRollOutHandler);
				playCardUnit.removeEventListener(MouseEvent.ROLL_OVER, unitRollOverHandler);
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
	
	this.listVisibleBtn.source = AS.BtnListHide;
	
	_fadeLeft.target = this.moveLeftBtn;
	_fadeRight.target = this.moveRightBtn;
	
	_scrollBarAni.target = this;
	_scrollBarAni.property = "mainContainerHScrollBarPos";
	_scrollBarAni.easingFunction = Linear.easeNone;
	
	drawMoveButton();
}

private function drawMoveButton():void
{
	var bmRight:Bitmap = new AS.BtnScrollRight();
	var bmLeft:Bitmap = new AS.BtnScrollLeft();
	var m:Matrix = new Matrix();
	m.createBox(1, 1, 0);
	m.translate(this.moveLeftBtn.width - bmRight.width >> 1, 
			this.moveLeftBtn.height - bmRight.height >> 1);
	
	var gr:Graphics = this.moveRightBtn.graphics;
	gr.beginFill(0xFFFFFF, 0.8);
	gr.drawRect(0, 0, this.moveRightBtn.width, this.moveRightBtn.height);
	gr.endFill(); 
	gr.beginBitmapFill(bmRight.bitmapData, m);
//	gr.drawRect(0, 0, this.moveRightBtn.width, this.moveRightBtn.height);
	gr.drawRect(this.moveRightBtn.width - bmRight.width >> 1, 
			this.moveRightBtn.height - bmRight.height >> 1,
			bmRight.width, bmRight.height);
	gr.endFill();
	
//	m.translate(this.moveLeftBtn.width - bm.width >> 1, this.moveLeftBtn.height - bm.height >> 1);
	var gl:Graphics = this.moveLeftBtn.graphics;
	gl.beginFill(0xFFFFFF, 0.8);
	gl.drawRect(0, 0, this.moveLeftBtn.width, this.moveLeftBtn.height);
	gl.endFill();
	gl.beginBitmapFill(bmLeft.bitmapData, m, true);
	gl.drawRect(this.moveLeftBtn.width - bmLeft.width >> 1, this.moveLeftBtn.height - bmLeft.height >> 1,
			bmLeft.width, bmLeft.height);
	gl.endFill();
	
	
}

private function listVisibleBtnClickHandler():void
{
	if (_isListHide) {
		_isListHide = false;
		this.listVisibleBtn.source = AS.BtnListHide;
		this.height = Constants.PLAY_CARD_HEIGHT + 1;
		mainContainer.visible = true;
		moveLeftBtn.visible = true;
		moveRightBtn.visible = true;
	} else {
		_isListHide = true;
		this.listVisibleBtn.source = AS.BtnListExpand;
		this.height = 20;
		mainContainer.visible = false;
		moveLeftBtn.visible = false;
		moveRightBtn.visible = false;
	}
}

private function itemDragEnterHandler(evt:PlayCardDragEvent):void
{
	var index:int;
	if (evt.target is PlayCardUnit) {
		var unit:PlayCardUnit = PlayCardUnit(evt.target);
		index = this.cardColl.getItemIndex(unit.card);
	}
	
	if (evt.enterLeftSide) {
	} else {
		index += 1; 
	}
	
}

private function itemDragDropHandler(evt:PlayCardDragEvent):void
{
	evt.playCard.setLocation(locationType);
}

private function listDragEnterHandler(evt:DragEvent):void
{
	DragManager.acceptDragDrop(this.mainContainer);
}

private function listDragDropHandler(evt:DragEvent):void
{
	if (evt.dragInitiator is PlayCardUnit) {
		var unit:PlayCardUnit = PlayCardUnit(evt.dragInitiator);
		PlayCard(unit.card).setLocation(this.locationType);
	}
}

private function moveLeftHandler():void
{
	if (mainContainer.horizontalScrollPosition <= 0) {
		mainContainer.horizontalScrollPosition = 0;
	} else if (!_scrollBarAni.isPlaying) {
		_scrollBarAni.fromValue = this.mainContainerHScrollBarPos;
		var toValue:Number = mainContainer.horizontalScrollPosition 
				- Constants.DEFAULT_GAP - Constants.PLAY_CARD_WIDTH;
		_scrollBarAni.toValue = Math.max(toValue, 0);
		_scrollBarAni.duration = SCROLL_DURATION / Constants.PLAY_CARD_WIDTH 
				* (_scrollBarAni.fromValue - _scrollBarAni.toValue);
		_scrollBarAni.play();
	}
}

private function moveRightHandler():void
{
	if (mainContainer.horizontalScrollPosition >= mainContainer.maxHorizontalScrollPosition) {
		mainContainer.horizontalScrollPosition = mainContainer.maxHorizontalScrollPosition;
	} else if (!_scrollBarAni.isPlaying) {
		_scrollBarAni.fromValue = this.mainContainerHScrollBarPos;
		var toValue:Number = mainContainer.horizontalScrollPosition 
				+ Constants.DEFAULT_GAP + Constants.PLAY_CARD_WIDTH;
		_scrollBarAni.toValue = Math.min(toValue, this.mainContainer.maxHorizontalScrollPosition);
		_scrollBarAni.duration = SCROLL_DURATION / Constants.PLAY_CARD_WIDTH 
				* (_scrollBarAni.toValue - _scrollBarAni.fromValue);
		_scrollBarAni.play();
	}
}

private function btnLeftRollOverHandler(evt:MouseEvent):void
{
	if (mainContainer.horizontalScrollPosition <= 0) {
		mainContainer.horizontalScrollPosition = 0;
	} else {
		_fadeLeft.stop();
		_fadeLeft.alphaFrom = this.moveLeftBtn.alpha;
		_fadeLeft.alphaTo = 1;
		_fadeLeft.duration = (1 - this.moveLeftBtn.alpha) * BTN_DURATION;
		_fadeLeft.play();
	}
}

private function btnLeftRollOutHandler(evt:MouseEvent):void
{
	_fadeLeft.stop();
	_fadeLeft.alphaFrom = this.moveLeftBtn.alpha;
	_fadeLeft.alphaTo = 0.01;
	_fadeLeft.duration = this.moveLeftBtn.alpha * BTN_DURATION;
	_fadeLeft.play();
}

private function btnRightRollOverHandler(evt:MouseEvent):void
{
	if (mainContainer.horizontalScrollPosition >= mainContainer.maxHorizontalScrollPosition) {
		mainContainer.horizontalScrollPosition = mainContainer.maxHorizontalScrollPosition;
	} else {
		_fadeRight.stop();
		_fadeRight.alphaFrom = this.moveLeftBtn.alpha;
		_fadeRight.alphaTo = 1;
		_fadeRight.duration = (1 - this.moveLeftBtn.alpha) * BTN_DURATION;
		_fadeRight.play();
	}
}

private function btnRightRollOutHandler(evt:MouseEvent):void
{
	_fadeRight.stop();
	_fadeRight.alphaFrom = this.moveLeftBtn.alpha;
	_fadeRight.alphaTo = 0.01;
	_fadeRight.duration = this.moveLeftBtn.alpha * BTN_DURATION;
	_fadeRight.play();	
}

private function btnVisibleCtrl():void
{
	this.moveLeftBtn.visible = mainContainer.horizontalScrollPosition > 0;
	this.moveRightBtn.visible = mainContainer.maxHorizontalScrollPosition > 0 
			&& mainContainer.horizontalScrollPosition < mainContainer.maxHorizontalScrollPosition;
}

private function unitRollOutHandler(evt:MouseEvent):void
{
	var unit:PlayCardUnit = PlayCardUnit(evt.currentTarget);
	if (DS.isAutoShowCardDetail) {
		GlobalUtil.hideCardDetailTip();
	}
}

private function unitRollOverHandler(evt:MouseEvent):void
{
	var unit:PlayCardUnit = PlayCardUnit(evt.currentTarget);
	if (DS.isAutoShowCardDetail) {
		GlobalUtil.showCardDetailTip(unit);
	}
}

override protected function updateDisplayList(uw:Number, uh:Number):void
{
	super.updateDisplayList(uw, uh);
	graphics.clear();
	graphics.moveTo(0, uh - 1);
	graphics.lineStyle(1, 0x7f7f7f, 0.5);
	graphics.lineTo(uw, uh - 1);
	
}