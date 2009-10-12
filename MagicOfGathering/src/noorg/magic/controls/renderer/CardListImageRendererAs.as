// ActionScript file
import noorg.magic.models.Card;

public var card:Card;

override public function set data(value:Object):void
{
	card = Card(value);
	if (mainCardUnit != null) {
		mainCardUnit.card = card;
	}
}

override public function get data():Object
{
	return card;
}

private function completeHandler():void
{
	if (card != null) {
		mainCardUnit.card = card;
	}
}