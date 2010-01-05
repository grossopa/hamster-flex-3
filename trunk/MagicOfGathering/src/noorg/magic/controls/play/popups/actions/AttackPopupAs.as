// ActionScript file
import mx.collections.ArrayCollection;
import mx.events.ListEvent;

import noorg.magic.controls.play.popups.actions.attack.AttackDefUnit;
import noorg.magic.events.PlayCardAttackEvent;
import noorg.magic.models.PlayCard;
import noorg.magic.models.Player;
import noorg.magic.models.staticValue.CardLocation;
import noorg.magic.models.staticValue.CardStatus;

private var _attacker:Player;
private var _defender:Player;

[Bindable]
public var attackerCreatureList:ArrayCollection = new ArrayCollection();
[Bindable]
public var defenseCreatureList:ArrayCollection = new ArrayCollection();

public function setPlayers(attacker:Player, defender:Player):void
{
	this._attacker = attacker;
	this._defender = defender;
	
	var attCreatureList:ArrayCollection = _attacker.playerCardColl.getLocationArray(CardLocation.CREATURE);
	var defCreatureList:ArrayCollection = _defender.playerCardColl.getLocationArray(CardLocation.CREATURE);
	
	var playCard:PlayCard;
	for each (playCard in attCreatureList) {
		if (playCard.status != CardStatus.PLAY_TAGGED) {
			this.attackerCreatureList.addItem(playCard);
		}
	}
	
	for each (playCard in defCreatureList) {
		if (playCard.status != CardStatus.PLAY_TAGGED) {
			this.defenseCreatureList.addItem(playCard);
		}
	}
	
	this.attackCardList.setStyle("backgroundColor", _attacker.color);
	this.defenseCardList.setStyle("backgroundColor", _defender.color);
	
}

private function attackCardClickHandler(evt:ListEvent):void
{
	var playCard:PlayCard = PlayCard(evt.itemRenderer.data);
	
	for each (var attDefUnit:AttackDefUnit in this.attackDefBox.getChildren()) {
		if (attDefUnit.attackerPlayCard == playCard) {
			return;
		}
	}
	
	this.attackerCreatureList.removeItemAt(this.attackerCreatureList.getItemIndex(playCard));
	
	var newAttDefUnit:AttackDefUnit = new AttackDefUnit();
	newAttDefUnit.attackerPlayCard = playCard;
	newAttDefUnit.addEventListener(PlayCardAttackEvent.ADD_DEFENDER, addDefenderHandler);
	newAttDefUnit.addEventListener(PlayCardAttackEvent.REMOVE_ATTACKER, removeAttackerHandler);
	newAttDefUnit.addEventListener(PlayCardAttackEvent.REMOVE_DEFENDER, removeDefenderHandler);
	this.attackDefBox.addChild(newAttDefUnit);
}

private function addDefenderHandler(evt:PlayCardAttackEvent):void
{
	this.defenseCreatureList.removeItemAt(this.defenseCreatureList.getItemIndex(evt.playCard));
}

private function removeAttackerHandler(evt:PlayCardAttackEvent):void
{
	var curTarget:AttackDefUnit = AttackDefUnit(evt.currentTarget);
	curTarget.removeEventListener(PlayCardAttackEvent.ADD_DEFENDER, addDefenderHandler);
	curTarget.removeEventListener(PlayCardAttackEvent.REMOVE_ATTACKER, removeAttackerHandler);
	curTarget.removeEventListener(PlayCardAttackEvent.REMOVE_DEFENDER, removeDefenderHandler);
	this.attackDefBox.removeChild(curTarget);
	
	this.attackerCreatureList.addItem(curTarget.attackerPlayCard);
	this.defenseCreatureList.addAll(evt.relatedCards);
}

private function removeDefenderHandler(evt:PlayCardAttackEvent):void
{
	this.defenseCreatureList.addItem(evt.playCard);
}

