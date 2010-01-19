// ActionScript file
import noorg.magic.models.Card;
import noorg.magic.services.DataService;
import noorg.magic.services.EventService;

private const DS:DataService = DataService.getInstance();
private const ES:EventService = EventService.getInstance();

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
	DS.selectedNumChanged();
}

private function removeCardHandler():void
{
	ES.removeSelectedCard(card);
}

