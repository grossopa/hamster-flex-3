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
}

private function attackCardClickHandler(evt:ListEvent):void
{
	var playCard:PlayCard = PlayCard(evt.itemRenderer.data);
	
	for each (var attDefUnit:AttackDefUnit in this.attackDefBox.getChildren()) {
		if (attDefUnit.attackerPlayCard == playCard) {
			return;
		}
	}
	
	var newAttDefUnit:AttackDefUnit = new AttackDefUnit();
	newAttDefUnit.attackerPlayCard = playCard;
	newAttDefUnit.addEventListener(PlayCardAttackEvent.REMOVE_ATTACKER, removeAttackerHandler);
	newAttDefUnit.addEventListener(PlayCardAttackEvent.REMOVE_DEFENDER, removeDefenderHandler);
	this.attackDefBox.addChild(newAttDefUnit);
}

private function removeAttackerHandler(evt:PlayCardAttackEvent):void
{
	var curTarget:AttackDefUnit = AttackDefUnit(evt.currentTarget);
	curTarget.removeEventListener(PlayCardAttackEvent.REMOVE_ATTACKER, removeAttackerHandler);
	curTarget.removeEventListener(PlayCardAttackEvent.REMOVE_DEFENDER, removeDefenderHandler);
	this.attackDefBox.removeChild(curTarget);
}

private function removeDefenderHandler(evt:PlayCardAttackEvent):void
{
	
}