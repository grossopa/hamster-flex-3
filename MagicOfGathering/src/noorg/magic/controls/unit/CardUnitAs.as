// ActionScript file
import noorg.magic.models.Card;
import noorg.magic.utils.Constants;
new Constants;

private var _card:Card;
[Bindable]
private var _source:String;
[Bindable]
private var _name:String;

public function set card(value:Card):void
{
	this._card = value;
	this._source = card.imgPath;
	this._name = card.name;
}

public function get card():Card
{
	return this._card;
}

