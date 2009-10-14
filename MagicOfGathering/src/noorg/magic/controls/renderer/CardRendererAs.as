// ActionScript file
import flash.events.MouseEvent;

import noorg.magic.models.Card;

private var _card:Card;

[Bindable]
private var _imgPath:String;

override public function set data(value:Object):void
{
	_card = Card(value);
	
	_imgPath = _card.imgPath;
	this.toolTip = _card.name + '\r\r' + _card.oracleText;
}

override public function get data():Object
{
	return _card;
}

private function completeHandler():void
{
	//this.addEventListener(MouseEvent.MOUSE_DOWN
}