// ActionScript file
import flash.events.MouseEvent;

[Embed(source="noorg/magic/assets/common/common_btn.png")]
private var btn_normal:Class;
[Embed(source="noorg/magic/assets/common/common_btn_down.png")]
private var btn_down:Class;

private var _text:String;

private function completeHandler():void
{
	mainLabel.text = text;
	
	this.buttonMode = true;
	this.mouseChildren = false;
	
	this.setStyle("backgroundImage", this.btn_normal);
	
	this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
	this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
}

private function rollOverHandler(evt:MouseEvent):void
{
	this.setStyle("backgroundImage", this.btn_down);
}

private function rollOutHandler(evt:MouseEvent):void
{
	this.setStyle("backgroundImage", this.btn_normal);
}