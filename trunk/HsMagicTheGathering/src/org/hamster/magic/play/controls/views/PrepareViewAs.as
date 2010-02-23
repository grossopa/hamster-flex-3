// ActionScript file
import flash.events.Event;

import mx.collections.ArrayCollection;

import org.hamster.magic.common.models.CardCollection;
import org.hamster.magic.common.services.DataService;
import org.hamster.magic.play.controls.utils.PlayerFactory;

private static const DS:DataService = DataService.getInstance();
[Bindable]
private var userCollNames:ArrayCollection;

private function completeHandler():void
{
	userCollNames = DS.userCollNames;
}

private function startGameHandler():void
{
	var cardColl1:CardCollection;
	var cardColl2:CardCollection;
	
	for each (var cardCollection:CardCollection in DS.) {
		if (cardCollection.name == this.player1CardCollComboBox.selectedItem.toString()) {
			DS.player1 = PlayerFactory.createPlayer(cardCollection);
		}
		if (cardCollection.name == this.player2CardCollComboBox.selectedItem.toString()) {
			DS.player2 = PlayerFactory.createPlayer(cardCollection);
		}
	}
	
	this.dispatchEvent(new Event("startGame"));
}