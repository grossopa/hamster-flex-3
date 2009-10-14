// ActionScript file
import noorg.magic.models.Card;
import noorg.magic.services.DataService;

public var card:Card;

private const DS:DataService = DataService.getInstance();

override public function set data(value:Object):void
{
	card = Card(value);
	
	if (this.initialized) {
		stepper.value = card.count;
	}
}

override public function get data():Object
{
	return card;
}

private function completeHandler():void
{
	if (card != null) {
		stepper.value = card.count;
	}
}

private function stepperChangedHandler():void
{
	card.count = stepper.value;
	DS.selectedNumChanged();
}