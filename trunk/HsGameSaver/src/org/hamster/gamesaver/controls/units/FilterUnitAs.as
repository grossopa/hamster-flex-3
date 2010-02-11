// ActionScript file
import flash.text.TextField;

import mx.core.mx_internal;

use namespace mx_internal;

public static const INCLUDE:String = "include";
public static const EXCLUDE:String = "exclude";

private var _type:String;

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

private function completeHandler():void
{
	if (this.type == null || this.type.length == 0) {
		this.type = INCLUDE;
	}
}

private function typeChangeHandler():void
{
	filterTextInput.width = TextField(filterTextInput.mx_internal::getTextField()).textWidth + 22;
	this.width = TextField(filterTextInput.mx_internal::getTextField()).textWidth + 47;
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
}