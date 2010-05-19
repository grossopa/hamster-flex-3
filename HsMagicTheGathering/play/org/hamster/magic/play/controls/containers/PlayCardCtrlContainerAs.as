// ActionScript file
import flash.events.MouseEvent;

import mx.controls.Alert;
import mx.core.Application;
import mx.core.Container;
import mx.core.WindowedApplication;
import mx.managers.PopUpManager;

import org.hamster.magic.common.events.CardUnitEvent;
import org.hamster.magic.common.events.PopupEvent;
import org.hamster.magic.common.models.Magic;
import org.hamster.magic.common.models.PlayCard;
import org.hamster.magic.common.models.action.CardAction;
import org.hamster.magic.common.models.action.utils.ActionTarget;
import org.hamster.magic.common.models.type.TypeArtifact;
import org.hamster.magic.common.models.type.TypeCreature;
import org.hamster.magic.common.models.type.TypeLand;
import org.hamster.magic.common.models.type.base.ICardType;
import org.hamster.magic.common.models.utils.CardLocation;
import org.hamster.magic.common.models.utils.CardStatus;
import org.hamster.magic.common.models.utils.GameStep;
import org.hamster.magic.common.services.EventService;
import org.hamster.magic.play.controls.buttons.ConsoleTextButton;
import org.hamster.magic.play.controls.popups.ChooseColorlessPopup;

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
	if (this.playCard == null) {
		// unselected a card
		return;
	}
	if (this.playCard.getLocation() == CardLocation.HAND) {
		if (this.playCard.player.magic.gt(this.playCard.magic)) {
			var payButton:ConsoleTextButton = new ConsoleTextButton();
			payButton.text = "施放";
			payButton.addEventListener(MouseEvent.CLICK, payButtonClickHandler);
			actionCtrlContainer.addChild(payButton);
		}
	} else if (CardLocation.getFieldArray().indexOf(this.playCard.getLocation()) >= 0) {
		for each (var cardAction:CardAction in this.playCard.actions) {
			var consoleTextBtn:ConsoleTextButton = new ConsoleTextButton();
			consoleTextBtn.data = cardAction;
			consoleTextBtn.text = cardAction.name;
			consoleTextBtn.addEventListener(MouseEvent.CLICK, actionBtnClickHandler);
			actionCtrlContainer.addChild(consoleTextBtn);
		}
	}
}

private function payButtonClickHandler(evt:MouseEvent):void
{
	var m:Magic = this.playCard.magic;
	if (this.playCard.player.magic.gt(m)) {
		if (m.colorless > 0) {
			var popup:ChooseColorlessPopup = PopUpManager.createPopUp(
				Container(Application.application),
				ChooseColorlessPopup, true) 
				as ChooseColorlessPopup;
			PopUpManager.centerPopUp(popup);
			popup.setNeededData(m, this.playCard.player.magic);
			popup.addEventListener(PopupEvent.APPLY_CLOSE, colorlessPopupCloseHandler);
		} else {
			this.payPlayCard(m.red, m.blue, m.green, 
				m.black, m.white, m.colorless);
		}
	}
}

/**
 * handler function when colorless payment is choosen.
 *  
 * @param evt
 * 
 */
private function colorlessPopupCloseHandler(evt:PopupEvent):void
{
	var popup:ChooseColorlessPopup = ChooseColorlessPopup(evt.currentTarget);
	var m:Magic = popup.selectedMagic.clone();
	PopUpManager.removePopUp(popup);
	this.payPlayCard(m.red, m.blue, m.green, 
		m.black, m.white, m.colorless);
}

private function payPlayCard(red:int, blue:int, green:int, 
							  black:int, white:int, colorless:int):void
{
	this.playCard.player.magic.minusNumber(
		red, blue, green, black, white, colorless);
	
	var cardType:ICardType = this.playCard.type;
	if (cardType is TypeLand) {
		this.playCard.setLocation(CardLocation.LAND);
	} else if (cardType is TypeCreature) {
		this.playCard.setLocation(CardLocation.CREATURE);
	} else if (cardType is TypeArtifact) {
		this.playCard.setLocation(CardLocation.ARTIFACT);
	}	
}

private function actionBtnClickHandler(evt:MouseEvent):void
{
	var curBtn:ConsoleTextButton = ConsoleTextButton(evt.currentTarget);
	var cardAction:CardAction = CardAction(curBtn.data);
	
	if (!cardAction.notNeedTap && this.playCard.status == CardStatus.PLAY_TAPPED) {
		return;
	}
	
	if (cardAction.targets.length > 1) {
		// TODO: popup a select target panel
	}
	var targets:Array = new Array();
	for each (var target:int in cardAction.targets) {
		if (target == ActionTarget.PLAYER) {
			targets.push(this.playCard.player);
		}
	}
	cardAction.execute(GameStep.P_2_MAIN, targets);
	
	if (!cardAction.notNeedTap) {
		this.playCard.status = CardStatus.PLAY_TAPPED;
	}
	
	this.initProperties();
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