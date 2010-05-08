// ActionScript file
import flash.events.MouseEvent;

import org.hamster.magic.common.events.MagicEvent;
import org.hamster.magic.common.models.Magic;
import org.hamster.magic.common.controls.items.MagicCircleItem;

private var _magic:Magic = new Magic();

private var _editable:Boolean;

public function set editable(value:Boolean):void
{
	this._editable = value;
}

public function get editable():Boolean
{
	return this._editable;
}

public function set magic(value:Magic):void
{
	if (this.magic != null) {
		this.removeListener(this._magic);
	}
	this._magic = value;
	this.registerListener(this._magic);
	if (this.initialized) {
		magicChangeHandler(null);
	}
}

public function get magic():Magic
{
	return this._magic;
}

private function completeHandler():void
{
	magicChangeHandler(null);
}

private function magicChangeHandler(evt:MagicEvent):void
{
	this.magicRedImage.magicValue = this.magic.red;
	this.magicBlueImage.magicValue = this.magic.blue;
	this.magicGreenImage.magicValue = this.magic.green;
	this.magicBlackImage.magicValue = this.magic.black;
	this.magicWhiteImage.magicValue = this.magic.white;
	this.magicColorlessImage.magicValue = this.magic.colorless;
}

private function registerListener(magic:Magic):void
{
	magic.addEventListener(MagicEvent.CHANGE, magicChangeHandler);
}

private function removeListener(magic:Magic):void
{
	magic.removeEventListener(MagicEvent.CHANGE, magicChangeHandler);
}

private function itemClickHandler(evt:MouseEvent):void
{
	if (this.editable) {	
		var item:MagicCircleItem = MagicCircleItem(evt.currentTarget);
		item.magicValue += 1;
		if (item.magicValue >= 99) {
			item.magicValue = 99;
		}
	}
}

private function itemRightClickHandler(evt:MouseEvent):void
{
	if (this.editable) {
		var item:MagicCircleItem = MagicCircleItem(evt.currentTarget);
		item.magicValue -= 1;
		if (item.magicValue <= -99) {
			item.magicValue = -99;
		}
	}
}

public function applyChanges():Magic
{
	this.magic.setNumber(
		this.magicRedImage.magicValue,
		this.magicBlueImage.magicValue,
		this.magicGreenImage.magicValue,
		this.magicBlackImage.magicValue,
		this.magicWhiteImage.magicValue,
		this.magicColorlessImage.magicValue);
	return this.magic.clone();
}

override protected function updateDisplayList(uw:Number, uh:Number):void
{
	super.updateDisplayList(uw, uh);
}