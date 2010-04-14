// ActionScript file
import flash.events.MouseEvent;

import mx.controls.Alert;

import org.hamster.magic.common.events.CardUnitEvent;
import org.hamster.magic.common.models.PlayCard;
import org.hamster.magic.common.models.action.CardAction;
import org.hamster.magic.common.models.utils.CardStatus;
import org.hamster.magic.common.services.EventService;
import org.hamster.magic.play.controls.buttons.ConsoleTextButton;

private static const ES:EventService = EventService.getInstance();

private var _playCard:PlayCard;

public function set playCard(value:PlayCard):void
{
	this._playCard = value;
	if (this.initialized) {
		this.initProperties();
	}
}

public function get playCard():PlayCard
{
	return this._playCard;
}

private function init():void
{
	ES.addEventListener(CardUnitEvent.SELECT_CARD, selectCardHandler);
	ES.addEventListener(CardUnitEvent.UNSELECT_CARD, unselectCardHandler);	
}

private function completeHandler():void
{

	if (this.playCard != null) {
		initProperties();
	}
	
}

private function initProperties():void
{
	for each (var child:ConsoleTextButton 
			in this.actionCtrlContainer.getChildren()) {
		child.removeEventListener(MouseEvent.CLICK, actionBtnClickHandler);			
	}
	actionCtrlContainer.removeAllChildren();
	for each (var cardAction:CardAction in this.playCard.actions) {
		var consoleTextBtn:ConsoleTextButton = new ConsoleTextButton();
		consoleTextBtn.data = cardAction;
		consoleTextBtn.text = cardAction.name;
		consoleTextBtn.addEventListener(MouseEvent.CLICK, actionBtnClickHandler);
		actionCtrlContainer.addChild(consoleTextBtn);
	}
}

private function actionBtnClickHandler(evt:MouseEvent):void
{
	var curBtn:ConsoleTextButton = ConsoleTextButton(evt.currentTarget);
	var cardAction:CardAction = CardAction(curBtn.data);
	if (cardAction.targets.length > 1) {
		// TODO: popup a select target panel
	}
	// cardAction.execute(GameStep.P_2_MAIN);
}

private function selectCardHandler(evt:CardUnitEvent):void
{
	this.playCard = PlayCard(evt.card);
}

private function unselectCardHandler(evt:CardUnitEvent):void
{
	this.playCard = null;
}

private function tapCardHandler():void
{
	this.playCard = PlayCard(ES.curSelectedCardUnit.card);
	if (this.playCard != null) {
		this.playCard.status = CardStatus.PLAY_TAPPED;
	}
}