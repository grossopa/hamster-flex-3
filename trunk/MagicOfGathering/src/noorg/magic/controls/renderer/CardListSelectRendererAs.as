// ActionScript file
import noorg.magic.models.Card;

public var card:Card;
[Bindable]
private var _selected:Boolean;

override public function set data(value:Object):void
{
	card = Card(value);
	_selected = card.isSelected;
}

override public function get data():Object
{
	return card;
}

private function selectChangedHandler():void
{
	card.isSelected = mainCheckBox.selected;
	_selected = card.isSelected;
}

