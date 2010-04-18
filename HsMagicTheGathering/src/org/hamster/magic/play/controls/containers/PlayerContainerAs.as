// ActionScript file
import flash.events.MouseEvent;

import org.hamster.magic.common.events.CardUnitEvent;
import org.hamster.magic.common.models.Player;
import org.hamster.magic.common.models.utils.CardLocation;
import org.hamster.magic.common.services.EventService;
import org.hamster.magic.play.controls.buttons.ConsoleNavButton;

private var ES:EventService = EventService.getInstance();

private var _player:Player;

public function set player(value:Player):void
{
	this._player = value;
}

public function get player():Player
{
	return this._player;
}

private function completeHandler():void
{
	this.playCardPileContainer.player = this.player;
	this.lifeMagicContainer.player = this.player;
	ES.addEventListener(CardUnitEvent.SHOW_DETAIL, showDetailHandler);
	ES.addEventListener(CardUnitEvent.HIDE_DETAIL, hideDetailHandler);
	ES.addEventListener(CardUnitEvent.SELECT_CARD, selectCardHandler);
	ES.addEventListener(CardUnitEvent.UNSELECT_CARD, unselectCardHandler);
}

private function completeHandler2():void
{
	creatureContainer.cardArray = this.player.playerCards.getLocationArray(CardLocation.CREATURE);
	artifactContainer.cardArray = this.player.playerCards.getLocationArray(CardLocation.ARTIFACT);
	landContainer.cardArray = this.player.playerCards.getLocationArray(CardLocation.LAND);
	handContainer.cardArray = this.player.playerCards.getLocationArray(CardLocation.HAND);
}

private function showDetailHandler(evt:CardUnitEvent):void
{
	previewCardUnit.card = evt.card;
}

private function hideDetailHandler(evt:CardUnitEvent):void
{
	previewCardUnit.card = null;
}

private function selectCardHandler(evt:CardUnitEvent):void
{
	previewCardUnit.card = evt.card;
	this.consoleViewStack.selectedIndex = 1;
}

private function unselectCardHandler(evt:CardUnitEvent):void
{
	
}

private function navBtnCardPileClickHandler(event:MouseEvent):void
{
	consoleViewStack.selectedIndex = 0;
	for each (var btn:ConsoleNavButton in navBtnContainer.getChildren()) {
		btn.selected = btn == ConsoleNavButton(event.currentTarget);
	}
}

private function navBtnCardCtrlClickHandler(event:MouseEvent):void
{
	consoleViewStack.selectedIndex = 1;
	for each (var btn:ConsoleNavButton in navBtnContainer.getChildren()) {
		btn.selected = btn == ConsoleNavButton(event.currentTarget);
	}
}