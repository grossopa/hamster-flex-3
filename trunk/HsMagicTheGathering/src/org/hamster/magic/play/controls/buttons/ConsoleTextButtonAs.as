// ActionScript file
import mx.controls.Alert;

[Embed(source="/org/hamster/magic/play/assets/buttons/btn_console_background.png")]
private static var _NORMAL:Class;
		
[Embed(source="/org/hamster/magic/play/assets/buttons/btn_console_background_down.png")]
private static var _DOWN:Class;

private var _text:String;

public function set text(value:String):void
{
	this._text = value;
	if (this.initialized) {
		this.mainLabel.text = value;
	}
}

public function get text():String
{
	return this._text;
}

private function mouseUpHandler():void
{
	this.setStyle("backgroundImage", _NORMAL);	
}

private function mouseDownHandler():void
{
	this.setStyle("backgroundImage", _DOWN);
}

private function completeHandler():void
{
	this.setStyle("backgroundImage", _NORMAL);
	this.mainLabel.text = this.text;
}