// ActionScript file
import flash.events.Event;
import flash.text.TextField;

import mx.core.mx_internal;

import org.hamster.gamesaver.events.ChildComponentEvent;
import org.hamster.gamesaver.events.TextInputEvent;

use namespace mx_internal;

public static const INCLUDE:String = "include";
public static const EXCLUDE:String = "exclude";

private var _type:String;
private var _editable:Boolean;

public function set type(value:String):void
{
	this._type = value;
	this.setStyle("backgroundAlpha", 0.3);
	if (type == INCLUDE) {
		this.setStyle("backgroundColor", 0x00FF00);
	} else if (type == EXCLUDE) {
		this.setStyle("backgroundColor", 0xFF0000);
	}
}

public function get type():String
{
	return this._type;
}

public function set editable(value:Boolean):void
{
	this._editable = value;
}

[Bindable]
public function get editable():Boolean
{
	return this._editable;
}

private var _filterText:String;

public function set filterText(value:String):void
{
	_filterText = value;
	
	if (this.initialized) {
		this.filterTextInput.text = value;
		inputFocusOutHandler();
	}
}

public function get filterText():String
{
	return this._filterText;
}

private function completeHandler():void
{
	this.filterTextInput.text = this.filterText;
	if (this.type == null || this.type.length == 0) {
		this.type = INCLUDE;
	}
}

private function mouseWheelHandler():void
{
	if (!this.editable) {
		return;
	}
	this.type = this.type == INCLUDE ? EXCLUDE : INCLUDE;
}

private function inputChangeHandler():void
{
	_filterText = filterTextInput.text;
	filterTextInput.width = TextField(filterTextInput.mx_internal::getTextField()).textWidth + 22;
	this.width = TextField(filterTextInput.mx_internal::getTextField()).textWidth + 47;
	this.dispatchEvent(new Event(Event.CHANGE));
}

private function applyChangeHandler(evt:TextInputEvent):void
{
	this.dispatchEvent(evt);
}

private function inputFocusInHandler():void
{
	filterTextInput.width = TextField(filterTextInput.mx_internal::getTextField()).textWidth + 22;
	this.width = TextField(filterTextInput.mx_internal::getTextField()).textWidth + 47;	
}

private function inputFocusOutHandler():void
{
	filterTextInput.width = TextField(filterTextInput.mx_internal::getTextField()).textWidth + 4;
	this.width = TextField(filterTextInput.mx_internal::getTextField()).textWidth + 29;
	applyChangeHandler(new TextInputEvent(TextInputEvent.APPLY_CHANGE));
}

private function deleteSelf():void
{
	var disEvt:ChildComponentEvent = 
			new ChildComponentEvent(ChildComponentEvent.DELETE);
	this.dispatchEvent(disEvt);
}

private function deleteBtnClickHandler():void
{
	deleteSelf();
}