// ActionScript file
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import mx.core.Application;
import mx.managers.PopUpManager;

public static const SUCCESS:String = "success";
public static const FAILED:String = "failed";

[Bindable]
public var title:String;

[Bindable]
public var message:String;

[Bindable]
public var stringColor:Number = 0xFFFFFF;

public function set status(value:String):void
{
	if (value == SUCCESS) {
		stringColor = 0xFFFFFF;
	} else if (value == FAILED) {
		stringColor = 0xFF4F4F;
	}
}

private function completeHandler():void
{
	this.stage.addEventListener(KeyboardEvent.KEY_DOWN, 
			_keyDownHandler, false, 0, true);
}

private function closeHandler():void
{
	this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, 
			_keyDownHandler);
	PopUpManager.removePopUp(this);
}

private function _keyDownHandler(evt:KeyboardEvent):void
{
	if (evt.keyCode == Keyboard.ESCAPE 
			|| evt.keyCode == Keyboard.ENTER 
			|| evt.keyCode == Keyboard.SPACE) {
		this.closeHandler();			
	}
}