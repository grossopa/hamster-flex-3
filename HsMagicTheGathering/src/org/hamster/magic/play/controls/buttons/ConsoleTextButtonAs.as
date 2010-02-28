// ActionScript file
[Embed(source="/org/hamster/magic/play/assets/buttons/btn_console_background.png")]
private static var _NORMAL:Class;
		
[Embed(source="/org/hamster/magic/play/assets/buttons/btn_console_background_down.png")]
private static var _DOWN:Class;

[Bindable]
public var text:String;

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
}