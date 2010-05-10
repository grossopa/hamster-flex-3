import flash.events.MouseEvent;
import flash.geom.Point;

import mx.effects.Move;
import mx.events.EffectEvent;

import org.hamster.effects.utils.HsEffectUtil;
import org.hamster.magic.common.controls.items.MagicCircleItem;
import org.hamster.magic.common.events.MagicEvent;
import org.hamster.magic.common.events.PopupEvent;
import org.hamster.magic.common.models.Magic;
import org.hamster.magic.common.utils.Constants;

private var _colorless:int;
private var _magic:Magic;
private var _selectedMagic:Magic;

private var _move:Move;

private function get colorless():int
{
	return this._colorless;
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
public function setNeededData(colorless:int, magic:Magic):void
{
	this._colorless = colorless;
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
	this.colorlessContainer.removeAllChildren();
	this.magicContainer.removeAllChildren();
	
	var i:int = 0;
	
	for (i = 0; i < this.colorless; i++) {
		var colorlessCircle:MagicCircleItem = new MagicCircleItem();
		colorlessCircle.x = i * 36;
		colorlessCircle.width = 34;
		colorlessCircle.height = 34;
		colorlessCircle.enabled = false;
		this.colorlessContainer.addChild(colorlessCircle);
	}
	
	var createMagicFunc:Function = 
	function createMagicFunc_(x_:int, y_:int, color:Number):void
	{
		var newCircleItem:MagicCircleItem = new MagicCircleItem();
		newCircleItem.width = 34;
		newCircleItem.height = 34;
		newCircleItem.x = x_;
		newCircleItem.y = y_;
		newCircleItem.color = Constants.WHITE_COLOR;
		newCircleItem.addEventListener(MouseEvent.CLICK, magicCircleClickHandler);
		magicContainer.addChild(newCircleItem);
	};
	
	for (i = 0; i < this.magic.white; i++) {
		createMagicFunc(i * 36, 0, Constants.WHITE_COLOR);
	}
	
	for (i = 0; i < this.magic.blue; i++) {
		createMagicFunc(i * 36, 36, Constants.BLUE_COLOR);
	}
	
	for (i = 0; i < this.magic.black; i++) {
		createMagicFunc(i * 36, 72, Constants.BLACK_COLOR);
	}
	
	for (i = 0; i < this.magic.red; i++) {
		createMagicFunc(i * 36, 108, Constants.RED_COLOR);
	}
	
	for (i = 0; i < this.magic.green; i++) {
		createMagicFunc(i * 36, 144, Constants.GREEN_COLOR);
	}
	
	for (i = 0; i < this.magic.colorless; i++) {
		createMagicFunc(i * 36, 180, Constants.COLORLESS_COLOR);
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
	
	if (curCircle.parent == this.magicContainer) {
		if (curCircle.color == Constants.BLACK_COLOR) {
			this.selectedMagic.black++;
		} else if (curCircle.color == Constants.BLUE_COLOR) {
			this.selectedMagic.blue++;
		} else if (curCircle.color == Constants.COLORLESS_COLOR) {
			this.selectedMagic.colorless++;
		} else if (curCircle.color == Constants.GREEN_COLOR) {
			this.selectedMagic.green++;
		} else if (curCircle.color == Constants.RED_COLOR) {
			this.selectedMagic.red++;
		} else if (curCircle.color == Constants.WHITE_COLOR) {
			this.selectedMagic.white++;
		}
		
		var targetItem:MagicCircleItem 
				= MagicCircleItem(this.magicContainer.getChildAt(
					this.selectedMagic.allCount));
		targetX = targetItem.x + this.colorlessContainer.x;
		targetY = targetItem.y + this.colorlessContainer.y;
		fromX = curCircle.x
			+ this.magicContainer.x;
		fromY = curCircle.y
			+ this.magicContainer.y;
		_move.xBy = targetX - fromX;
		_move.yBy = targetY - fromY;
		_move.duration = 750;
		HsEffectUtil.playBetweenContainers([curCircle], _move, colorlessContainer, frontMask);
	} else if (curCircle.parent == this.colorlessContainer) {
		targetX = this.magicContainer.x;
		targetY = this.magicContainer.y;
		if (curCircle.color == Constants.WHITE_COLOR) {
			this.selectedMagic.white--;
			targetX += 36 * (this.magic.white - this.selectedMagic.white - 1);
			// targetY += 0;
		} else if (curCircle.color == Constants.BLUE_COLOR) {
			this.selectedMagic.blue--;
			targetX += 36 * (this.magic.blue - this.selectedMagic.blue - 1);
			targetY += 36;
		} else if (curCircle.color == Constants.BLACK_COLOR) {
			this.selectedMagic.black--;
			targetX += 36 * (this.magic.black - this.selectedMagic.black - 1);
			targetY += 72;
		} else if (curCircle.color == Constants.RED_COLOR) {
			this.selectedMagic.red--;
			targetX += 36 * (this.magic.red - this.selectedMagic.red - 1);
			targetY += 108;
		} else if (curCircle.color == Constants.GREEN_COLOR) {
			this.selectedMagic.green--;
			targetX += 36 * (this.magic.green - this.selectedMagic.green - 1);
			targetY += 144;
		} else if (curCircle.color == Constants.COLORLESS_COLOR) {
			this.selectedMagic.colorless--;
			targetX += 36 * (this.magic.colorless - this.selectedMagic.colorless - 1);
			targetY += 180;
		}
		
		fromX = curCircle.x
			+ this.magicContainer.x;
		fromY = curCircle.y
			+ this.magicContainer.y;
		_move.xBy = targetX - fromX;
		_move.yBy = targetY - fromY;
		_move.duration = 750;
		HsEffectUtil.playBetweenContainers([curCircle], _move, magicContainer, frontMask);
	}
}

private function moveEffEndHandler(evt:EffectEvent):void
{
	if (this.selectedMagic.allCount == this.colorless) {
		this.dispatchEvent(new PopupEvent(PopupEvent.APPLY_CLOSE));
	}
}