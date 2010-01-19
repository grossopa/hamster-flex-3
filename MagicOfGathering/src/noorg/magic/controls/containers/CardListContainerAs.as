// ActionScript file
import mx.controls.Alert;

import noorg.magic.commands.CommandWrapper;
import noorg.magic.commands.impl.SaveUserCardCollCmd;
import noorg.magic.controls.popups.LoadCardCollPopup;
import noorg.magic.events.CardEvent;
import noorg.magic.models.Card;
import noorg.magic.services.DataService;
import noorg.magic.services.EventService;
import noorg.magic.utils.GlobalUtil;
import noorg.magic.utils.Properties;

import org.hamster.commands.events.CommandEvent;

private const DS:DataService = DataService.getInstance();
private const ES:EventService = EventService.getInstance();

private function completeHandler():void
{
	Properties;
	ES.addEventListener(CardEvent.SELECT_CHANGED, cardSelectionChangedHandler, false, 0, true);
	ES.addEventListener(CardEvent.ADD, addCardHandler, false, 0, true);
	ES.addEventListener(CardEvent.REMOVE, removeCardHandler, false, 0, true);
}

private function selectChangedHandler():void
{
	ES.cardChanged(Card(dataGrid.selectedItem));
}

private function cardSelectionChangedHandler(evt:CardEvent):void
{
	var card:Card = evt.card;
	if (DS.selectedCards.contains(card)) {
		this.dataGrid.selectedItem = card;
	}
}

//private function ownCollSelectedHandler():void
//{
//	GlobalUtil.popUpMask(resourceManager.getString("main", "buildContainer.saving"), this);
//	var cmd:LoadUserCollCmd = CommandWrapper.loadUserColl(
//			ownCollComboBox.selectedItem as String);
//	cmd.addEventListener(CommandEvent.COMMAND_RESULT, loadUserCollCompleteHandler);
//}
//
//private function loadUserCollCompleteHandler(evt:CommandEvent):void
//{
//	
//}

private function addCardHandler(evt:CardEvent):void
{
	var card:Card = evt.card;
	if (!DS.selectedCards.contains(card)) {
		DS.selectedCards.addItem(card);
		card.isSelected = true;
		card.count = 1;
	}
}

private function removeCardHandler(evt:CardEvent):void
{
	var card:Card = evt.card;
	if (DS.selectedCards.contains(card)) {
		DS.selectedCards.removeItemAt(DS.selectedCards.getItemIndex(card));
		card.isSelected = false;
		card.count = 0;
	}
}

private function saveCollectionHandler():void
{
	if (collNameTextInput.text == null || collNameTextInput.text.length == 0) {
		return;
	}
	//GlobalUtil.popUpMask(resourceManager.getString("main", "buildContainer.saving"));
	var cmd:SaveUserCardCollCmd = CommandWrapper.saveCollection(collNameTextInput.text);
	//cmd.addEventListener(CommandEvent.COMMAND_RESULT, saveResultHandler);
	if (!DS.userCollNames.contains(collNameTextInput.text)) {
		DS.userCollNames.addItem(collNameTextInput.text)
	}
	Alert.show(this.resourceManager.getString("main", "buildContainer.saveSuccess"));
}

private function saveResultHandler(evt:CommandEvent):void
{
	var cmd:SaveUserCardCollCmd = SaveUserCardCollCmd(evt.currentTarget);
	GlobalUtil.removePopUpMask();
	//Alert.show(this.resourceManager.getString("main", "buildContainer.saveSuccess");
}

private function popupLoadHandler():void
{
	GlobalUtil.createPopup(LoadCardCollPopup);
}