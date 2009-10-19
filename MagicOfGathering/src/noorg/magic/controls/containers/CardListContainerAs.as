// ActionScript file
import noorg.magic.commands.CommandWrapper;
import noorg.magic.events.CardEvent;
import noorg.magic.models.Card;
import noorg.magic.services.DataService;
import noorg.magic.services.EventService;
import noorg.magic.utils.Properties;

private const DS:DataService = DataService.getInstance();
private const ES:EventService = EventService.getInstance();

private function completeHandler():void
{
	Properties;
	ES.addEventListener(CardEvent.SELECT_CHANGED, cardSelectionChangedHandler);
	ES.addEventListener(CardEvent.ADD, addCardHandler);
}

private function selectChangedHandler():void
{
	ES.cardChanged(Card(dataGrid.selectedItem));
}

private function cardSelectionChangedHandler(evt:CardEvent):void
{
	var card:Card = evt.card;
	this.dataGrid.selectedItem = card;
}

private function addCardHandler(evt:CardEvent):void
{
	var card:Card = evt.card;
	if (!DS.selectedCards.contains(card)) {
		DS.selectedCards.addItem(card);
		card.isSelected = true;
	}
}

private function saveCollection():void
{
	CommandWrapper.saveCollection("abc");
}