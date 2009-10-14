// ActionScript file
import noorg.magic.events.CardEvent;
import noorg.magic.models.Card;
import noorg.magic.services.DataService;
import noorg.magic.services.EventService;

private const DS:DataService = DataService.getInstance();
private const ES:EventService = EventService.getInstance();

private function completeHandler():void
{
	ES.addEventListener(CardEvent.SELECT_CHANGED, cardSelectionChangedHandler);
}

private function selectChangedHandler():void
{
	ES.cardChanged(Card(dataGrid.selectedItem));
}

private function cardSelectionChangedHandler(evt:CardEvent):void
{
	var card:Card = evt.card;
	
	if (!DS.selectedCards.contains(card)) {
		DS.selectedCards.addItem(card);
	}
	
	this.dataGrid.selectedItem = card;
}