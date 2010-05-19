import flash.events.MouseEvent;
import flash.geom.Point;

import mx.collections.ArrayCollection;
import mx.effects.Move;
import mx.effects.Parallel;
import mx.events.EffectEvent;

import org.hamcrest.mxml.collection.InArray;
import org.hamster.effects.utils.HsEffectUtil;
import org.hamster.magic.common.controls.items.MagicCircleItem;
import org.hamster.magic.common.events.MagicEvent;
import org.hamster.magic.common.events.PopupEvent;
import org.hamster.magic.common.models.Magic;
import org.hamster.magic.common.utils.Constants;

private static const COLORLESS_X:int = 10;
private static const COLORLESS_Y:int = 39;
private static const MAGIC_X:int = 10;
private static const MAGIC_Y:int = 76;

private var _cardMagic:Magic;
private var _magic:Magic;
private var _selectedMagic:Magic;

// animation support
private var _colorlessSelectedArray:ArrayCollection;
private var _blackArray:Array;
private var _blueArray:Array;
private var _whiteArray:Array;
private var _greenArray:Array;
private var _redArray:Array;
private var _colorlessArray:Array;

private var _move:Move;

private function get cardMagic():Magic
{
	return this._cardMagic;
}

private function get magic():Magic
{
	return this._magic;
}

public function get selectedMagic():Magic
{
	return this._selectedMagic;
}

/**
 *
 * set colorless value needed and magic payer.
 *  
 * @param colorless
 * @param magic
 */
public function setNeededData(cardMagic:Magic, magic:Magic):void
{
	this._cardMagic = cardMagic;
	this._magic = magic;
	
	
	if (this.initialized) {
		this.initProperties();
	}
}

private function completeHandler():void
{
	this._selectedMagic = new Magic();
	
	_move = new Move();
	_move.addEventListener(EffectEvent.EFFECT_END, moveEffEndHandler);
	
	if (this.magic != null) {
		this.initProperties();
	}
}

/**
 * initialize properties to controller layer 
 */
private function initProperties():void
{
	this._blackArray = new Array();
	this._blueArray = new Array();
	this._colorlessArray = new Array();
	this._greenArray = new Array();
	this._redArray = new Array();
	this._whiteArray = new Array();
	this._colorlessSelectedArray = new ArrayCollection();
	
	this.mainContainer.removeAllChildren();
	
	var i:int = 0;
	
	for (i = 0; i < this.cardMagic.colorless; i++) {
		var colorlessCircle:MagicCircleItem = new MagicCircleItem();
		colorlessCircle.x = i * 36 + COLORLESS_X;
		colorlessCircle.y = COLORLESS_Y;
		colorlessCircle.width = 34;
		colorlessCircle.height = 34;
		colorlessCircle.enabled = false;
		colorlessCircle.isShowLabel = false;
		this.mainContainer.addChild(colorlessCircle);
	}
	
	var createMagicFunc:Function = 
	function createMagicFunc_(x_:int, y_:int, color_:Number, targetArray_:Array):void
	{
		var newCircleItem:MagicCircleItem = new MagicCircleItem();
		newCircleItem.width = 34;
		newCircleItem.height = 34;
		newCircleItem.x = x_ + MAGIC_X;
		newCircleItem.y = y_ + MAGIC_Y;
		newCircleItem.color = color_;
		newCircleItem.isShowLabel = false;
		newCircleItem.addEventListener(MouseEvent.CLICK, magicCircleClickHandler);
		mainContainer.addChild(newCircleItem);
		targetArray_.push(newCircleItem);
	};
	
	for (i = 0; i < this.magic.white - this.cardMagic.white; i++) {
		createMagicFunc(i * 36, 0, Constants.WHITE_COLOR, _whiteArray);
	}
	
	for (i = 0; i < this.magic.blue - this.cardMagic.blue; i++) {
		createMagicFunc(i * 36, 36, Constants.BLUE_COLOR, _blueArray);
	}
	
	for (i = 0; i < this.magic.black - this.cardMagic.black; i++) {
		createMagicFunc(i * 36, 72, Constants.BLACK_COLOR, _blackArray);
	}
	
	for (i = 0; i < this.magic.red - this.cardMagic.red; i++) {
		createMagicFunc(i * 36, 108, Constants.RED_COLOR, _redArray);
	}
	
	for (i = 0; i < this.magic.green - this.cardMagic.green; i++) {
		createMagicFunc(i * 36, 144, Constants.GREEN_COLOR, _greenArray);
	}
	
	for (i = 0; i < this.magic.colorless; i++) {
		createMagicFunc(i * 36, 180, Constants.COLORLESS_COLOR, _colorlessArray);
	}
}

/**
 * handler function when a magic circle is clicked, 
 * if the circle is in magicContainer then add to selected magic.
 * else remove from selected magic. 
 *  
 * @param evt
 * 
 */
private function magicCircleClickHandler(evt:MouseEvent):void
{
	if (_move.isPlaying) {
		return;
	}
	
	var curCircle:MagicCircleItem = MagicCircleItem(evt.currentTarget);
	var targetX:Number;
	var targetY:Number;
	var fromX:Number;
	var fromY:Number;
	
	if (curCircle.y >= MAGIC_Y) {
		var targetCircle:MagicCircleItem;
		if (curCircle.color == Constants.BLACK_COLOR) {
			this.selectedMagic.black++;
			targetCircle = MagicCircleItem(this._blackArray.pop());
		} else if (curCircle.color == Constants.BLUE_COLOR) {
			this.selectedMagic.blue++;
			targetCircle = MagicCircleItem(this._blueArray.pop());
		} else if (curCircle.color == Constants.COLORLESS_COLOR) {
			this.selectedMagic.colorless++;
			targetCircle = MagicCircleItem(this._colorlessArray.pop());
		} else if (curCircle.color == Constants.GREEN_COLOR) {
			this.selectedMagic.green++;
			targetCircle = MagicCircleItem(this._greenArray.pop());
		} else if (curCircle.color == Constants.RED_COLOR) {
			this.selectedMagic.red++;
			targetCircle = MagicCircleItem(this._redArray.pop());
		} else if (curCircle.color == Constants.WHITE_COLOR) {
			this.selectedMagic.white++;
			targetCircle = MagicCircleItem(this._whiteArray.pop());
		}
		_colorlessSelectedArray.addItem(targetCircle);
		
		var colorlessBackItem:MagicCircleItem = MagicCircleItem(
			this.mainContainer.getChildAt(this.selectedMagic.allCount - 1));
		
		_move.xTo = colorlessBackItem.x;
		_move.yTo = colorlessBackItem.y;
		_move.duration = 500;
		_move.play([targetCircle]);
	} else if (curCircle.y == COLORLESS_Y) {
		targetX = MAGIC_X;
		targetY = MAGIC_Y;
		if (curCircle.color == Constants.WHITE_COLOR) {
			this.selectedMagic.white--;
			targetX += 36 * (this.magic.white - this.cardMagic.white - this.selectedMagic.white - 1);
			this._whiteArray.push(curCircle);
			// targetY += 0;
		} else if (curCircle.color == Constants.BLUE_COLOR) {
			this.selectedMagic.blue--;
			targetX += 36 * (this.magic.blue - this.cardMagic.blue - this.selectedMagic.blue - 1);
			targetY += 36;
			this._blueArray.push(curCircle);
		} else if (curCircle.color == Constants.BLACK_COLOR) {
			this.selectedMagic.black--;
			targetX += 36 * (this.magic.black - this.cardMagic.black - this.selectedMagic.black - 1);
			targetY += 72;
			this._blackArray.push(curCircle);
		} else if (curCircle.color == Constants.RED_COLOR) {
			this.selectedMagic.red--;
			targetX += 36 * (this.magic.red - this.cardMagic.red - this.selectedMagic.red - 1);
			targetY += 108;
			this._redArray.push(curCircle);
		} else if (curCircle.color == Constants.GREEN_COLOR) {
			this.selectedMagic.green--;
			targetX += 36 * (this.magic.green - this.cardMagic.green - this.selectedMagic.green - 1);
			targetY += 144;
			this._greenArray.push(curCircle);
		} else if (curCircle.color == Constants.COLORLESS_COLOR) {
			this.selectedMagic.colorless--;
			targetX += 36 * (this.magic.colorless - this.selectedMagic.colorless - 1);
			targetY += 180;
			this._colorlessArray.push(curCircle);
		}
		var idx:int = _colorlessSelectedArray.getItemIndex(curCircle);
		_colorlessSelectedArray.removeItemAt(idx);
		
		var para:Parallel = new Parallel();
		for (var i:int = idx; i < _colorlessSelectedArray.length; i++) {
			var otherMove:Move = new Move(_colorlessSelectedArray[i]);
			otherMove.xBy = -36;
			para.addChild(otherMove);
		}
		para.addChild(_move);
		para.duration = 500;
		_move.xTo = targetX;
		_move.yTo = targetY;
		_move.target = curCircle;
		para.play();
	}
}

private function moveEffEndHandler(evt:EffectEvent):void
{
	if (this.selectedMagic.allCount == this.cardMagic.colorless) {
		this.selectedMagic.addNumber(this.cardMagic.red, this.cardMagic.blue
			,this.cardMagic.green, this.cardMagic.black, 
			this.cardMagic.white, 0);
		this.dispatchEvent(new PopupEvent(PopupEvent.APPLY_CLOSE));
	}
}