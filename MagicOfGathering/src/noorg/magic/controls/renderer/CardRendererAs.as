// ActionScript file
import noorg.magic.models.Card;
import noorg.magic.services.EventService;

private var _card:Card;

[Bindable]
private var _imgPath:String;

private const ES:EventService = EventService.getInstance();

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

private function rollOverHandler():void
{
	this.addCardIcon.visible = true;
}

private function rollOutHandler():void
{
	this.addCardIcon.visible = false;
}

private function addCardHandler():void
{
	ES.addCard(_card);
}